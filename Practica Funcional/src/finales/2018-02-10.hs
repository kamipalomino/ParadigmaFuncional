import Text.Show.Functions
import Prelude 
import Data.List 

f :: Ord a => a -> (a ->a) -> [(c, a)] -> Bool
f h p = any (< h) . map (p . snd)

lista = cycle [("a", 2) , ("b", 5)]

main :: IO ()
main = do 
let resultado = head  lista
let resultado2 = f 12 (* 2) lista
print (resultado)
print (resultado2)