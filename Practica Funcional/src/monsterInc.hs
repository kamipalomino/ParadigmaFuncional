
import Text.Show.Functions -- Para mostrar <Function> en consola cada vez que devuelven una
import Data.List -- Para métodos de colecciones que no vienen por defecto (ver guía de lenguajes)
import Data.Maybe 


type Grito = (String, Int, Bool)
data Gritos = Gritos {
onomatopeya :: String,
intensidad :: Int,
mojaLaCama :: Bool
} deriving (Show, Eq)

fst1 (a, b, c) = a
snd1 (a, b, c) = b

unaOnomatopeya :: Grito -> String
unaOno :: Gritos -> String
unaOno = onomatopeya 
unaOnomatopeya  grito = fst1 grito 

siMojaLaCama:: Grito -> Bool
siMojaLaCama (_, _,  mojaLaCama) = mojaLaCama

intenso:: Grito -> Int 
intenso grito =  snd1 grito 

nivelDeTerror :: Grito -> Int 
nivelDeTerror = length . unaOnomatopeya 


{-
Obtener la energía que produce un grito, que se calcula como el nivel de terror por la intensidad al cuadrado, en caso de que moje la cama, si no, sólo es el triple del nivel de terror más la intensidad. El nivel de terror es equivalente al largo de la onomatopeya.
-}
unGrito = ("AAAAAHG", 10, True) -- 700
otro = ("uf", 2, False)

energiaDeGrito :: Grito -> Int
energiaDeGrito grito  
	| siMojaLaCama grito = nivelDeTerror grito * intenso grito * intenso grito 
	| otherwise = (3 * nivelDeTerror grito) + intenso grito 
{-
De los niños se sabe el nombre, la edad y la altura y se los representa con una tupla con dichas componentes.
-}
type Ninio = (String, Int, Float)
x = ("marco", 2, 1.3)

nombre :: Ninio -> String 
nombre n = fst1 n

edad :: Ninio -> Int 
edad = snd1

altura :: Ninio -> Float
altura (_, _, a) = a
{-
Monstruos en la empresa hay muchos. En particular, se desea implementar los siguientes, pero podría haber más:-}
type Monster = Ninio -> Grito

-- ● Sullivan (el protagonista) produce un grito "AAAGH" con tantas A como letras tenga el nombre del niño y una intensidad como como 20 /edad; hace mojar la cama si el niño tiene menos de 3 años.
sullivan :: Monster 
sullivan nene = ( grita nene ++ "GH" ,    edad nene,  edad nene < 3)

lenNombre = length . nombre 
grita n   = replicate (lenNombre n ) 'A'

-- ● Randall Boggs (la lagartija) produce  grito de “¡Mamadera!”, con tanta intensidad como vocales en el nombre de la persona; hace mojar la cama en los niños que miden entre 0,8 y 1,2 altura.
randall :: Monster 
randall nene =("Mamadera", (contarVocales . nombre) nene,  altura nene < 1.2)

esVocal :: Char -> Bool
esVocal c = c `elem` "aeiouAEIOU"

contarVocales :: String -> Int
contarVocales palabra = length (filter esVocal palabra)

-- ● Chuck Norris produce siempre un grito que dice todo el abecedario, con 1000 de nivel de intensidad y siempre hace que mojen la cama.

chuck  :: Monster 
chuck _ = ("abcdefghijklmnopqrstuvwxyz", 1000, True) 

-- ● Un Osito Cariñoso produce un grito “uf”, con un nivel de intensidad igual a la edad del niño y nunca moja la cama.
osito :: Monster
osito nene = ("uf", edad nene, False)

main :: IO ()
main = do
    -- Test the different colors
    let resultado = nombre x
    --Print the output
    print ("el resultado es "++ resultado)

