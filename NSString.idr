module NSString

import objective_c
import NSObject 
import NSRange

-------------------------------------------------------------------------------
data NSString'Class = Metaclass

instance Object NSString'Class where
   getPtr o = getClass "NSString"

-------------------------------------------------------------------------------
metaclass : IO NSString'Class
-------------------------------------------------------------------------------
metaclass = return Metaclass

-------------------------------------------------------------------------------
record NSString : Type where
   asObject : (pointer : Ptr) -> NSString

instance Object NSString where
   getPtr o = return (pointer o)

-------------------------------------------------------------------------------
-------------------------- Implicit conversions -------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
implicit asNSObject : NSString -> NSObject
-------------------------------------------------------------------------------
asNSObject o = NSObject.asObject (NSString.pointer o)

-------------------------------------------------------------------------------
-- Note: Is this ever dangerous?
-------------------------------------------------------------------------------
implicit liftNSString : NSString -> IO NSString
-------------------------------------------------------------------------------
liftNSString s = return s

-------------------------------------------------------------------------------
--------------------------- Class methods -------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
stringWithUTF8String : String -> NSString'Class -> IO NSString
-------------------------------------------------------------------------------
stringWithUTF8String s c = do 
   obj <- getPtr c
   sel <- getSelector "stringWithUTF8String:" 
   result <- mkForeign (FFun "objc_msgSend" [FPtr, FPtr, FString] FPtr) 
                                             obj   sel   s
   return (asObject result)

-------------------------------------------------------------------------------
--------------------------- Instance methods ----------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
stringByAppendingString : NSString -> NSString -> IO NSString
-------------------------------------------------------------------------------
stringByAppendingString s o = do 
   obj <- getPtr o
   sel <- getSelector "stringByAppendingString:"
   str <- getPtr s
   result <- mkForeign (FFun "objc_msgSend" [FPtr, FPtr, FPtr] FPtr) 
                                             obj   sel   str      
   return (asObject result)

-------------------------------------------------------------------------------
UTF8String : NSString -> IO String
-------------------------------------------------------------------------------
UTF8String o = do 
   obj <- getPtr o
   sel <- getSelector "UTF8String" 
   mkForeign (FFun "objc_msgSend" [FPtr, FPtr] FString) obj sel

-------------------------------------------------------------------------------
stringByReplacingOccurrencesOfString : NSString -> (withString : NSString) ->
                                       NSString -> 
                                       IO NSString
-------------------------------------------------------------------------------
stringByReplacingOccurrencesOfString s r o = do 
   obj <- getPtr o
   sel <- getSelector "stringByReplacingOccurrencesOfString:withString:"
   old <- getPtr s
   new <- getPtr r
   result <- mkForeign (FFun "objc_msgSend" [FPtr, FPtr, FPtr, FPtr] FPtr) 
                                             obj   sel   old   new      
   return (asObject result)

-------------------------------------------------------------------------------
length : NSString -> IO Int
-------------------------------------------------------------------------------
length o = do 
   obj <- getPtr o
   sel <- getSelector "length" 
   mkForeign (FFun "objc_msgSend" [FPtr, FPtr] FInt) obj sel

-------------------------------------------------------------------------------
substringWithRange : NSRange -> NSString -> IO NSString
-------------------------------------------------------------------------------
substringWithRange (NSMakeRange loc len) o = do
   obj <- getPtr o
   sel <- getSelector "substringWithRange:"
   result <- mkForeign (FFun "objc_msgSend" [FPtr, FPtr, FInt, FInt] FPtr) 
                                             obj   sel   loc   len      
   return (asObject result)



