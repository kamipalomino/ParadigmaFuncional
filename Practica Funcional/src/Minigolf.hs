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
} deriving (Eq,Ord, Show)

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


-- 3. Lo que nos interesa de los distintos **obstáculos** es si un tiro puede superarlo, y en el caso de poder superarlo, cómo se ve afectado dicho tiro por el obstáculo. 
-- Se desea saber cómo queda un tiro luego de intentar superar un obstáculo, teniendo en cuenta que en caso de no superarlo, se detiene, quedando con todos sus componentes en 0.

type Obstaculo = Tiro -> Tiro 
type Superar = Tiro -> Bool
tunelConRampita :: Obstaculo 
laguna :: Int -> Obstaculo
hoyo :: Obstaculo 

{-
Un *túnel con rampita* sólo es superado si la precisión es mayor a 90 yendo al ras del suelo, independientemente de la velocidad del tiro. 
Al salir del túnel la velocidad del tiro se duplica, la precisión pasa a ser 100 y la altura 0.
-}

tunelConRampita tiro
  | superaTunelConRampita (precision tiro) (altura tiro)  = tiro {velocidad = (velocidad tiro) * 2, precision = 100, altura = 0} 
  | otherwise   = tiro {precision = 0, velocidad = 0, altura = 0}

tunel tiro
  | superaTunelConRampita (precision tiro) (altura tiro)  = tiro {velocidad = (velocidad tiro) * 2, precision = 100, altura = 0} 
  | otherwise   = tiro {precision = 0, velocidad = 0, altura = 0}

superaTunelConRampita :: (Eq a, Ord a1, Num a, Num a1) => a1 -> a -> Bool
superaTunelConRampita precision altura = (>) precision 90 &&  (==) 0 altura
   
{-   Una *laguna* es superada si la velocidad del tiro es mayor a 80 y tiene una altura de entre 1 y 5 metros.
     Luego de superar una laguna el tiro llega con la misma velocidad y precisión, pero una altura equivalente a la altura original dividida por el largo de la laguna.
-}
--superaLaguna velocidad altura = (>) velocidad 80 && between 1 5 altura

superarLaguna :: Tiro -> Bool
superarLaguna tiro = (>) (velocidad tiro ) 80 && between 1 5 (altura tiro)

laguna largo tiro
  | superarLaguna tiro  = tiro {altura = (div) (altura tiro) largo}  
  | otherwise   = tiro {precision = 0, velocidad = 0, altura = 0}

{-
    Un *hoyo* se supera si la velocidad del tiro está entre 5 y 20 m/s yendo al ras del suelo con una precisión mayor a 95. 
    Al superar el hoyo, el tiro se detiene, quedando con todos sus componentes en 0. 
-}

superarHoyo :: Tiro -> Bool
superarHoyo tiro = (>) (precision tiro)  95 && between 5 20 (velocidad tiro)  && (==) 0 (altura tiro)

hoyo tiro
  | superarHoyo tiro  = tiro {precision = 0, velocidad = 0, altura = 0}  
  | otherwise   = tiro {precision = 0, velocidad = 0, altura = 0}


-- Ejemplos tiros
primerTiro = UnTiro {velocidad = 2, precision = 92, altura = 0}
seTiro = UnTiro {velocidad = 92, precision = 82, altura = 4}
terTiro = UnTiro {velocidad = 8, precision = 100, altura = 0}

tiros = [primerTiro, terTiro, seTiro]
-- 4. Definir **palosUtiles** que dada una persona y un obstáculo, permita determinar qué palos le sirven para superarlo.
golpear :: Jugador -> [Palo] -> [Tiro]
golpear gamer otro =  map (golpe gamer) otro

--palosUtiles :: Jugador -> [Palo] -> [Palo]
palosUtiles gamer otro =  filter (utiles gamer) otro

esUtil :: Superar -> [Tiro] -> Bool
esUtil obst otros = any (\tiro -> obst tiro) otros

utiles gamer otro =  (esUtil superarLaguna . golpear gamer) otro
    {- Saber, a partir de un conjunto de obstáculos y un tiro, cuántos obstáculos consecutivos se pueden superar.
    *Por ejemplo, para un tiro de velocidad = 10, precisión = 95 y altura = 0, y una lista con dos túneles con rampita seguidos de un hoyo, el resultado sería 2 ya que la velocidad al salir del segundo túnel es de 40, por ende no supera el hoyo.*
     
    - **BONUS:** resolver este problema sin recursividad, teniendo en cuenta que existe una función `takeWhile :: (a -> Bool) -> [a] -> [a]` que podría ser de utilidad.
    
    - Definir **paloMasUtil** que recibe una persona y una lista de obstáculos y determina cuál es el palo que le permite superar más obstáculos con un solo tiro.
    
5. Dada una lista de tipo `[(Jugador, Puntos)]` que tiene la información de cuántos puntos ganó cada niño al finalizar el torneo, se pide retornar la lista de padres que pierden la apuesta por ser el “padre del niño que no ganó”. Se dice que un niño ganó el torneo si tiene más puntos que los otros niños.

-}



-------------------MAIN----------------
main :: IO ()
main = do
let resultado = golpe bart putter 
print (bart)
print (resultado)