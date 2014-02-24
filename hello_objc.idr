module Main

import NSString
import NSFunctions

-------------------------------------------------------------------------------
%lib C "objc" 
%link C "/System/Library/Frameworks/Foundation.framework/Foundation" 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
main : IO () 
-------------------------------------------------------------------------------
main = do

   recipient <- NSString.metaclass >>= stringWithUTF8String "world" 
   separator <- NSString.metaclass >>= stringWithUTF8String ", " 
   
   greeting <- NSString.metaclass >>= 
                  stringWithUTF8String "hello" >>=
                     stringByAppendingString separator >>=
                        stringByAppendingString recipient
   
   format <- NSString.metaclass >>= stringWithUTF8String "%@!"
   
   NSLog format greeting
   
   replacement <- NSString.metaclass >>= stringWithUTF8String "everyone" 
   
   greeting <- greeting >>= stringByReplacingOccurrencesOfString recipient {withString = replacement}

   NSLog format greeting

   substr <- greeting >>= substringWithRange (NSMakeRange 7 5)

   substrLen <- substr >>= length -- alternatively, "length substr"

   substring <- substr >>= UTF8String -- alternatively, "UTF8String substr"

   -- 'substring' is now a regular Idris string, and 'substrLen' is an Int
   --
   putStrLn $ "Substring: " ++ substring
   putStrLn $ "Length: " ++ show substrLen   
   
   return ()


