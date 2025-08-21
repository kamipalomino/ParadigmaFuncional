import Text.Show.Functions
import Prelude 
import Data.Maybe 
import Data.List
{-Existen diferentes personajes de Los Simpson. De cada uno se sabe su nombre, el dinero que tiene y su felicidad (que puede ser mayor o igual a cero pero nunca negativa). 
-}
data Personaje = Personaje {
nombre  :: String,
dinero :: Int,
felicidad :: Int 
} deriving (Show)

homero = Personaje { 
nombre = "Homero", 
dinero = 0, 
felicidad =30
 }
skinner = Personaje { 
nombre = "Skinner",
dinero =20, 
felicidad = 15
 }
lisa = Personaje  {
nombre= "Lisa", 
dinero =0,
felicidad =0
 }
-- Actividades
type Actividad = Personaje -> Personaje 


{- Ir a la escuela elemental de springfield: se le resta 20 a la felicidad del personaje, salvo que sea lisa, en cuyo caso aumenta la felicidad en igual cantidad.-}
--irEscuela :: Actividad 
irEscuela p  
					| esLisa p       = (+20)  $ felicidad 
					|otherwise   = (min 0) . (- 20) . felicidad 

esLisa :: Personaje -> Bool
esLisa =  ("Lisa"==) . nombre

{- Comer una cierta cantidad de donas: se le suma 10 de felicidad por cada dona comida y se le resta $10. -}

--comerNDonas :: Int -> Actividad 
comerNDonas n = ((+ n *10). felicidad) . ((- 10) . dinero)

{- Ir a trabajar: gana una cantidad de dinero según qué trabajo sea. Si es la "planta nuclear" son 14$ (porque son 14 caracteres). -}

--irATrabajar :: String -> Actividad
irATrabajar trabajo = (+ length trabajo)  . (dinero)  

{- Ir a trabajar como director: implica ir a a trabajar a "escuela elemental" y restar 20 de felicidad (como todo el que va a dicha escuela) -}

irATrabajarDirector p  = irATrabajar "escuela elemental"  p . irEscuela p

-- Actividad extra 

--sacarFoto :: Actividad 
sacarFoto = ((+ 50) . felicidad . (+10) dinero)

--- homero come una docena de donas
h = comerNDonas 12 homero
-- skinner va a trabajar como director
s = irATrabajarDirector skinner 
-- lisa va a la escuela y luego realiza la actividad inventada
l = (sacarFoto . irEscuela) lisa 