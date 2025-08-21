import Text.Show
import Data.List 
import Prelude 

type Barrio = String
type Mail = String
type Requisito = Depto -> Bool
type Busqueda = [Requisito]

data Depto = Depto {
 ambientes :: Int,
 superficie :: Int,
 precio :: Int,
 barrio :: Barrio
} deriving (Show, Eq, Ord)

data Persona = Persona {
   mail :: Mail,
   busquedas :: [Busqueda]
}
ordenarSegun :: Ord a => (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) = (ordenarSegun criterio . filter (not . criterio x)) xs ++ [x] ++ (ordenarSegun criterio . filter (criterio x)) xs

between cotaInferior cotaSuperior valor = valor <= cotaSuperior && valor >= cotaInferior

deptosDeEjemplo = [
 Depto 3 80 7500 "Palermo",
 Depto 1 45 3500 "Villa Urquiza",
 Depto 2 50 5000 "Palermo",
 Depto 1 45 5500 "Recoleta"]

mayor :: Ord b => (a -> b) -> a -> (a -> Bool)
mayor f x y = f x > f y

menor :: Ord b => (a -> b) -> a -> a -> Bool
menor f x y= not (mayor f x y)

{-
Mostrar un ejemplo de cómo se usaría una de estas funciones para ordenar una lista de strings en base a su longitud usando ordenarSegun.
-}
ejemploOrden = ordenarSegun (mayor length) ["ax", "d", "CVCC"]

{- ubicadoEn que dada una lista de barrios que le interesan al usuario, retorne verdadero si el departamento se encuentra en alguno de los barrios de la lista.
-}
ubicadoEn :: [Barrio] -> Requisito 
ubicadoEn barrios =  flip elem barrios . barrio 

{-
cumpleRango que a partir de una función y dos números, indique si el valor retornado por la función al ser aplicada con el departamento se encuentra entre los dos valores indicados.
-}
cumpleRango funcion x y = between x y . funcion 

{-
Definir la función cumpleBusqueda que se cumple si todos los requisitos de una búsqueda se verifican para un departamento dado.
-}
cumpleBusqueda :: Depto -> Busqueda -> Bool
cumpleBusqueda2 depto = all ($ depto)
cumpleBusqueda depto = all (\req -> req depto)
{-
Definir la función buscar que a partir de una búsqueda, un criterio de ordenamiento y una lista de departamentos retorne todos aquellos que cumplen con la búsqueda ordenados en base al criterio recibido.
-}

buscar :: Busqueda -> (Depto -> Depto -> Bool) -> ([Depto] -> [Depto])
buscar request criterio = ordenarSegun criterio . filter (flip cumpleBusqueda request)

--buscar' criterio deptos  = ordenarSegun criterio . filter cumpleBusqueda .  
{-
Mostrar un ejemplo de uso de buscar para obtener los departamentos de ejemplo, ordenado por mayor superficie, que cumplan con:
Encontrarse en Recoleta o Palermo. Ser de 1 o 2 ambientes. Precio menor a $6000 por mes
-}

buscarEj = buscar [ubicadoEn ["Recoleta", "Palermo"], cumpleRango precio 0 6000, cumpleRango ambientes 1 2] (mayor superficie) deptosDeEjemplo

{-
Definir la función mailsDePersonasInteresadas que a partir de un departamento y una lista de personas retorne los mails de las personas que tienen alguna búsqueda que se cumpla para el departamento dado.
-}
mailsDePersonasInteresadas :: Depto -> ([Persona] -> [Mail])
mailsDePersonasInteresadas depto = map mail . filter (any (cumpleBusqueda depto) . busquedas) 
