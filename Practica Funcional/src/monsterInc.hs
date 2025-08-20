{-# LANGUAGE NoMonomorphismRestriction #-}

import Text.Show.Functions -- Para mostrar <Function> en consola cada vez que devuelven una
import Data.List -- Para métodos de colecciones que no vienen por defecto (ver guía de lenguajes)
import Data.Maybe 

{-

2) Obtener el grito que cada monstruo (un empleado de la empresa) le arranca a un niño (su víctima). Hay muchos monstruos y cada uno tiene su forma de trabajar, que consiste precisamente en recibir  a un niño y devolver su grito. 

-}
type Grito = (String, Int, Bool)
data Gritos = Gritos {
onomatopeya :: String,
intensidad :: Int,
mojaLaCama :: Bool
} deriving (Show, Eq)

{-
Obtener la energía que produce un grito, que se calcula como el nivel de terror por la intensidad al cuadrado, en caso de que moje la cama, si no, sólo es el triple del nivel de terror más la intensidad. El nivel de terror es equivalente al largo de la onomatopeya.
-}
--fst1 :: (a, _, _) -> a
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
unGrito = ("AAAAAHG", 10, True) -- 700
otro = ("uf", 2, False)

energiaDeGrito grito  
	| siMojaLaCama grito = nivelDeTerror grito * intenso grito * intenso grito 
	| otherwise = (3 * nivelDeTerror grito) + intenso grito 
{-
De los niños se sabe el nombre, la edad y la altura y se los representa con una tupla con dichas componentes.
-}
type Ninio = (String, Int, Float)
type Monster = (Ninio -> Grito)
nombre :: Ninio -> String 
nombre = fst1

edad :: Ninio -> Int 
edad = snd1

altura :: Ninio -> Float
altura (_, _, a) = a
{-
Monstruos en la empresa hay muchos. En particular, se desea implementar los siguientes, pero podría haber más:-}

-- ● Sullivan (el protagonista) produce un grito "AAAGH" con tantas A como letras tenga el nombre del niño y una intensidad como como 20 /edad; hace mojar la cama si el niño tiene menos de 3 años.
--sullivan :: Monster 
sullivan nene = ( "GH", (20 div) edad nene,  edad nene < 3)

-- ● Randall Boggs (la lagartija) produce un grito de “¡Mamadera!”, con tanta intensidad como vocales en el nombre de la persona; hace mojar la cama en los niños que miden entre 0,8 y 1,2 altura.

-- ● Chuck Norris produce siempre un grito que dice todo el abecedario, con 1000 de nivel de intensidad y siempre hace que mojen la cama.

-- ● Un Osito Cariñoso produce un grito “uf”, con un nivel de intensidad igual a la edad del niño y nunca moja la cama.

