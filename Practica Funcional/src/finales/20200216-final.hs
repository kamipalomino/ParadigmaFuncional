import Text.Show
import Text.Show.Functions
import Data.List
import Prelude 

type Bebida = Persona -> Persona

data Persona = Persona {
nombre :: String, 
edad :: Int, 
bebidas :: [Bebida]
} deriving (Show)

--instance Show Persona => Persona -> Persona 

cafe  (Persona n e bs) = Persona n (e + 1) (cafe:bs)
cafe' :: Bebida 
cafe' person =  agregarBebida cafe person {edad =  edad person + 1} 

cindor  (Persona n e bs) = Persona ("Energizado "++ n) e (cindor:bs)

cindor' :: Bebida
cindor' person =  agregarBebida cindor person {nombre = "Energizado " ++ nombre person} 

gatorade (Persona n e bs) = Persona n e (gatorade:bs)
gatorade' :: Bebida
gatorade' =  agregarBebida gatorade

tomar persona unaBebida = unaBebida persona 

puedeTomar persona unaBebida = ((<60) . edad . tomar unaBebida) persona

juan = Persona "Juan" 23 []

-- 1. ¿Qué pasará si se hacen las siguientes consultas? Justificar conceptualmente.

-- > puedeTomar cafe juan  => True

-- > edad juan  => 23

-- 2. ¿Hay lógica repetida entre las bebidas? En caso positivo, proponer una solución para evitarlo e indicar qué conceptos se aprovechan. En caso negativo, justificar por qué no.
agregarBebida unaBebida persona = persona  {bebidas = unaBebida : bebidas persona}
-- 3. Dada la siguiente función
f persona = head . map (tomar persona) 
-- filter (puedeTomar persona) 

-- Indicar el tipo de la función f.
f :: Persona -> [Bebida] -> Persona
-- Proponer un nombre más expresivo para la función c. Si tenemos la siguiente lista infinita de bebidas:

muchasBebidas = cycle [cafe, cindor, gatorade]
-- ¿qué sucede al evaluar f para juan y y muchas Bebidas? En caso que termine, indicar cómo se reduce a su valor final. En caso que no termine, justificar por qué y dar un contraejemplo.

main :: IO ()
main = do
let resultado = puedeTomar  cafe' juan
let resultado2 = f juan [cindor', cafe, cindor]
print (resultado)
print (juan)
print (resultado2)