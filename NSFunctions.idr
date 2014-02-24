module NSFunctions

import objective_c
import NSString

-------------------------------------------------------------------------------
NSLog : Object a => NSString -> a -> IO ()
-------------------------------------------------------------------------------
NSLog fmt arg = do
   format <- getPtr fmt
   argument <- getPtr arg
   mkForeign (FFun "NSLog" [FPtr, FPtr] FUnit) format argument

