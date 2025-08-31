import Prelude 
import Text.Show.Functions
import Data.List

-- Modelo inicial

data Jugador = UnJugador {

  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
  
} deriving (Eq, Show)

 
data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)


data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)


type Puntos = Int


-- Jugadores de ejemplo

bart = UnJugador "Bart" "Homero" (Habilidad 25 60)

todd = UnJugador "Todd" "Ned" (Habilidad 15 80)

rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)


-- Funciones útiles


between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
  | f a > f b = a
  | otherwise = b


-- También necesitaremos modelar los __palos de golf__ que pueden usarse y los __obstáculos__ que deben enfrentar para ganar el juego.
type Palo = Habilidad -> Tiro

-- El **putter** genera un tiro con velocidad igual a 10, el doble de la precisión recibida y altura 0.
putter :: Palo
putter habilidad = UnTiro {velocidad= 10, precision= (* 2)  (precisionJugador habilidad), altura= 0 }

-- La **madera** genera uno de velocidad igual a 100, altura igual a 5 y la mitad de la precisión.
madera :: Palo 
madera hab = UnTiro {velocidad= 100, precision =  (precisionJugador hab) `div`  2 , altura = 5}

-- Los **hierros**, que varían del 1 al 10 (número al que denominaremos n),generan un tiro de velocidad igual a la fuerza multiplicada por n, la precisión dividida por n y una altura de n-3 (con mínimo 0). Modelarlos dela forma más genérica posible.
hierro :: Int -> Palo
hierro n hab = UnTiro {velocidad = n * fuerzaJugador hab , precision =  (precisionJugador hab) `div`  n , altura = mayorSegun nMenosM n 3}

nMenosM :: Int -> Int
nMenosM n = ( - ) n 3
-- Definir una constante **palos** que sea una lista con todos los palos que se pueden usar en el juego.* 

palos :: [Palo]
palos = [madera, hierro 4, putter]

-- 2. Definir la función **golpe** que dados una persona y un palo, obtiene el tiro resultante de usar ese palo con las habilidades de la persona.

golpe :: Jugador -> Palo -> Tiro 
golpe juga palo = palo (habilidad juga)

type Obstaculo = Tiro -> Bool /

tunelConRampita :: Obstaculo 
laguna :: Int -> Obstaculo 
hoyo :: Obstaculo 
{-
3. Lo que nos interesa de los distintos **obstáculos** es si un tiro puede superarlo, y en el caso de poder superarlo, cómo se ve afectado dicho tiro por el obstáculo. En principio necesitamos representar los siguientes obstáculos:

    - Un *túnel con rampita* sólo es superado si la precisión es mayor a 90 yendo al ras del suelo, independientemente de la velocidad del tiro. Al salir del túnel la velocidad del tiro se duplica, la precisión pasa a ser 100 y la altura 0.
    
    - Una *laguna* es superada si la velocidad del tiro es mayor a 80 y tiene una altura de entre 1 y 5 metros. Luego de superar una laguna el tiro llega con la misma velocidad y precisión, pero una altura equivalente a la altura original dividida por el largo de la laguna.
    
    - Un *hoyo* se supera si la velocidad del tiro está entre 5 y 20 m/s yendo al ras del suelo con una precisión mayor a 95. Al superar el hoyo, el tiro se detiene, quedando con todos sus componentes en 0.
    
-}



-------------------MAIN----------------
main :: IO ()
main = do
let resultado = golpe bart putter 
print (bart)
print (resultado)