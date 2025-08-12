--Import GHC.Num
-- Definimos una función que suma dos números
suma :: Int -> Int -> Int
suma x y = x + y

--Definir la función esMultiploDe/2, que devuelve True si el segundo es múltiplo del primero,
esMultiploDe :: Int -> Int -> Bool
esMultiploDe num otroNum = mod otroNum num == 0

esMultiploDeTres :: Int -> Bool
esMultiploDeTres = esMultiploDe 3 

cubo :: Int -> Int 
cubo  =  (^3)

--area :: Num -> Num -> Num
area base altura = base + altura 

esBisiesto n
  | (not . esMultiploDe 100 ) n	&&	(esMultiploDe 4) n	= True 
  | esMultiploDe 400 n	 = True 
  | otherwise	 = False

celsiusToFahr = (+32) . (*1.8)

fahrToCelsius n =  ( n - 32) *0.55556

haceFrioF = (<8) . fahrToCelsius 
-- Función principal (main) que imprime el resultado
main :: IO ()
main = do
    let resultado = cubo 2
    let areas = area 15.5 0.5
    let bisiesto = esBisiesto 2000
    let fahrenheit = celsiusToFahr 100
    let celsius = fahrToCelsius 212
    let frio = haceFrioF 32
    putStrLn ("el resultado es: " ++ show frio)

