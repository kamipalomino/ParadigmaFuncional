import Text.Show.Functions
import Prelude 
import Data.List 

g [ ] = True 
g (t: te) = fst t > 3 && g te
-- a
listaA = ["hola", "Bariloche", "Córdoba"]
-- b
listaB =[(2, True), (9,False)]
-- c
listaC = map (\n -> (n, "algo")) [1 ..]
-- D
listaD = map (\n -> (n, "algo")) [10 ..]
 -- 2 
listas = [ ]
--elPrimeroEsMayor :: Num a => [(a,b)] -> Bool
elPrimeroEsMayor lista = all (> 3)  . map fst $ lista

main :: IO ()
main = do 
--let resultado1 = elPrimeroEsMayor  listaA   -- OK
let resultado2 = elPrimeroEsMayor listaB --OK 
let resultado3 = elPrimeroEsMayor listaC --OK 
-- let resultado4 = elPrimeroEsMayor listaD   --OK
let resultado = elPrimeroEsMayor listas --OK 
print (resultado)
print (resultado2)
print (resultado3)
--print (resultado4)