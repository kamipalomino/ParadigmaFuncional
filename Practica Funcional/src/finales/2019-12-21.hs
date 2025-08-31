import Prelude 
import Text.Show.Functions
import Data.List

data Combo = Combo {
hamburguesa :: [Ingrediente],
bebida :: Bebida 
} deriving (Show)
type Ingrediente = String
type Bebida = String 

agregarIngrediente  :: Ingrediente -> Combo -> Combo
agregarIngrediente unIngrediente combo = combo {hamburguesa = unIngrediente : hamburguesa combo}

cambiarBebida :: Bebida -> Combo -> Combo
cambiarBebida unIngrediente combo = combo {bebida = unIngrediente}

modificarCombo :: Combo -> [(Combo -> Combo)] -> Combo
modificarCombo uncombo  = ($ uncombo) 

comboBasico = Combo {
hamburguesa = ["queso"],
bebida = "coca"
}

main :: IO ()
main = do
let resultado = agregarIngrediente "panceta" comboBasico 
let resultado2 = cambiarBebida "sodas" resultado 
print (resultado)
print (resultado2)