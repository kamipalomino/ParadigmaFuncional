import Prelude 
--import Library 
import Test.Hspec 

-- --file-watch 
main = hspec $ do
  describe "Description del test" $ do
     it " unaFuncion pi " $ unaFuncion "pi" `shouldBe` 3.14
    
    
    
unaFuncion :: String -> Number
unaFuncion "pi" = 3.14
