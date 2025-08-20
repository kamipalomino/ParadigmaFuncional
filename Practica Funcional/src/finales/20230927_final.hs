import Text.Show.Functions
import Prelude 
import Data.Maybe 
import Data.List

data Cafe = Cafe {
					calories :: Double,
					tipo :: String,
					tamaño :: String,
					precio  :: Double 
					} deriving (Show)
type Agregado =  Cafe -> Cafe

aumentarPrecio :: Double ->Agregado
aumentarPrecio monto cafe =cafe {precio = precio cafe + monto }

modificarCalorias :: (Double -> Double) -> Agregado
modificarCalorias modificacion cafe =cafe {calories =(modificacion . calories) cafe }

almendra :: Agregado 
almendra = (aumentarPrecio 150) . ( modificarCalorias (+80))

dulceDeLeche :: Agregado 
dulceDeLeche = (aumentarPrecio 350) . ( modificarCalorias (*3))

chico = Cafe {
					calories = 20,
					tipo = "negro",
					tamaño = "pequenio",
					precio  = 2500 
					} 
listaAgregado :: [Agregado]
listaAgregado = [almendra] ++ repeat dulceDeLeche 

cortarLista :: [Agregado] -> [Agregado]
cortarLista = (take 2)
--aplicar  :: [Agregado] -> Cafe -> Cafe
--aplicar lista cafe = map (\a -> a  cafe ) lista

aplicar :: [Agregado] -> Cafe -> Cafe
aplicar lista cafe = foldl (\c a -> a c) cafe lista

--baplicar :: [Agregado] -> Cafe -> Cafe
baplicar lista cafe = foldl (flip ($)) cafe lista