module NSObject

import objective_c

-------------------------------------------------------------------------------
data NSObject'Class = Metaclass

instance Object NSObject'Class where
   getPtr o = getClass "NSObject"

-------------------------------------------------------------------------------
metaclass : IO NSObject'Class
-------------------------------------------------------------------------------
metaclass = return Metaclass

-------------------------------------------------------------------------------
record NSObject : Type where
   asObject : (pointer : Ptr) -> NSObject

instance Object NSObject where
   getPtr o = return (pointer o)


