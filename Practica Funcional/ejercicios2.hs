import Prelude
-- {-

-- 11. En una plantación de pinos, de cada árbol se conoce la altura expresada en cm. El peso de un pino se puede calcular a partir de la altura así: 
-- Los pinos se usan para llevarlos a una fábrica de muebles, a la que le sirven árbolesvde entre 400 y 1000 kilos, un pino fuera de este rango no le sirve a la fábrica. Para

-- esta situación:

-- a. Definir la función pesoPino, recibe la altura de un pino y devuelve su peso.

-- b. Definir la función esPesoUtil, recibe un peso en kg y devuelve True si un

-- pino de ese peso le sirve a la fábrica, y False en caso contrario.

-- c. Definir la función sirvePino, recibe la altura de un pino y devuelve True si

-- un pino de ese peso le sirve a la fábrica, y False en caso contrario. Usar

-- composición en la definición.

-- 12. Este ejercicio alguna vez se planteó como un Desafío Café con Leche: Implementar

-- la función esCuadradoPerfecto/1, sin hacer operaciones con punto flotante.

-- Ayuda: les va a venir bien una función auxiliar, tal vez de dos parámetros. Pensar

-- que el primer cuadrado perfecto es 0, para llegar al 2do (1) sumo 1, para llegar al 3ro

-- (4) sumo 3, para llegar al siguiente (9) sumo 5, después sumo 7, 9, 11 etc.. También

-- algo de recursividad van a tener que usar
-- -}

type Medicion  = (Int, Int, Int)
max3 :: Medicion -> Int
max3 (a, b, c) = (max a)  (max b c)

min3 :: Medicion -> Int
min3 (a, b, c) = (min a)  (min b c)

dispersion :: Medicion -> Int
dispersion medida = max3 medida - min3 medida
--Una dispersión se considera chica si es de menos de 30 cm
-- grande si es de más de un metro.


diasParejos :: Medicion -> Bool -- parejos si la dispersión es chica
diasParejos = (< 30) . dispersion 

diasLocos :: Medicion -> Bool
diasLocos = (>100) . dispersion 

diasNormales :: Medicion -> Bool 
diasNormales medida = (not . diasParejos) medida && (not . diasLocos) medida

--3 kg x cm hasta 3 metros, 2 kg x cm arriba de los 3 metros. P.ej. 2 metros ⇒ 600 kg, 5 metros ⇒ 1300 kg.

pesoPino altura 
  | altura < 300	= 3 * altura
  | altura == 300	= 3* altura 
  | otherwise 	= 2 * altura 

main :: IO ()
main = do
--dia :: Medicion 
--dia (4, 6
let resultado = pesoPino 20 
putStrLn ("el resultado es: "  ++  show resultado)