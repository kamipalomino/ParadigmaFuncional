import Prelude 

--Tenemos estas declaraciones:

--edad :: Persona -> Float
data Persona = Persona {nombre :: String, edad :: Float} deriving (Eq)
x = Persona {nombre = "x", edad = 2.0}
y = Persona {nombre = "y", edad = 4.0}
z = Persona {nombre ="z", edad = 5.0}


f1 _ [ ] = False
f1 numero (x:xs) = 2 * x < numero || f1 numero xs
f1' numero = comparar (< numero) (2*)

f2 e lista = length (filter (\x -> edad x < e) lista) >= 1
f2' e = comparar (< e) edad

f3 tope palabras = any ((<tope).length) palabras
f3' tope = comparar (< tope) length 

--comparar ::  (a -> Bool) -> (a -> b) -> a -> [b] -> Bool
comparar criterio otro = any (criterio . otro)

r = ["xx", "xcv"]

main :: IO()
main = do
let resultado = f3 3 r
let resultado2 = f3' 3 r
print (resultado)
print (resultado2)