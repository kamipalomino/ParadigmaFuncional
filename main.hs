-- Definimos una función que suma dos números
suma :: Int -> Int -> Int
suma x y = x + y

-- Función principal (main) que imprime el resultado
main :: IO ()
main = do
    let resultado = suma 3 5
    putStrLn ("La suma de 3 y 5 es: " ++ show resultado)
    