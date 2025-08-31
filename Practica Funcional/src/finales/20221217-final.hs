import Text.Show
import Prelude 

type Person = Int
type Bebida = Int

tomar :: Bebida ->  Person -> Person 
tomar unaBebida  = (+ unaBebida)

mezclar :: Bebida -> Bebida -> Bebida
mezclar unaBebida otra = unaBebida * otra

seTomanUnCoctelConEstasBebidas :: [Bebida] -> [Person] -> [Person]
seTomanUnCoctelConEstasBebidas bebidas personas = map (tomar (foldl1 mezclar bebidas) )personas

people = [0, 1, 3]
coctel = [ 2, 2, 2]

main :: IO ()
main = do
	let resultado = seTomanUnCoctelConEstasBebidas coctel people 
	print (resultado)