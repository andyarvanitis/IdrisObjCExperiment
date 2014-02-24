module objective_c

%include C "objc/runtime.h"
%include C "objc_stubs.h"

-------------------------------------------------------------------------------
class Object a where
   getPtr : a -> IO Ptr

-------------------------------------------------------------------------------
getClass : String -> IO Ptr
-------------------------------------------------------------------------------
getClass name = mkForeign (FFun "objc_getClass" [FString] FPtr) name

-------------------------------------------------------------------------------
getSelector : String -> IO Ptr
-------------------------------------------------------------------------------
getSelector selname = mkForeign (FFun "sel_registerName" [FString] FPtr) selname 

