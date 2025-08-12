-- Main function to start the calculator
main :: IO ()
main = do
    -- Display a welcome message
    putStrLn "Welcome to the Haskell Calculator!"
    
    -- Prompt the user for the first number
    putStrLn "Enter the first number:"
    a <- getLine
    
    -- Prompt the user for the second number
    putStrLn "Enter the second number:"
    num2 <- getLine
    
    -- Prompt the user to choose an operation (+, -, *, /)
    putStrLn "Choose an operation (+, -, *, /):"
    operation <- getLine
    
    -- Convert the inputs from String to Double for calculations
    let num1 = a :: Double
    let num2 = b  :: Double
    
    -- Call the calculate function to perform the operation
    let result = calculate operation num1 num2
    
    -- Display the result of the calculation
    putStrLn ("The result is: " ++ result)
    
-- Function to perform calculations based on the operation chosen
calculate :: String -> Double -> Double -> Double
calculate "+" x y = x + y    -- Addition
calculate "-" x y = x - y    -- Subtraction
calculate "*" x y = x * y    -- Multiplication
calculate "/" x y = if y /= 0 then x / y else error "Cannot divide by zero"    -- Division with error check for division by zero
calculate _ _ _ = error "Invalid operation"   -- Error for any invalid operation
