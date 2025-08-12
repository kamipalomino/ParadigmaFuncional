main :: IO()
main = do
  putStr "Enter your name: "
  name <- getLine
  putStrLn ("Hi, " ++ name ++ "!")
  putStrLn (" Escribe un caracter ")
  y <- getChar 
--  putStrLn (" Escribe un caracter ")
  x <- getChar 
--  putStrLn (" Escribe un caracter ")
  t <- getChar 
  putStrLn ("escribiste ")
  putChar y
  putChar x
  putChar t
  putStrLn (" fin")