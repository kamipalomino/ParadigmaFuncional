import Prelude 
import Text.Show.Functions

data Futbolista = UnFutbolista {
posicion :: [Int],
goles :: Int
} deriving (Show, Eq)

tito = UnFutbolista [9,10] 47

meterGoles cant (UnFutbolista posiciones goles) = UnFutbolista posiciones (goles +cant)

jugarDePosicion posicion (UnFutbolista ps goles) = UnFutbolista (agregarPosicion posicion ps) goles

agregarPosicion p ps | not (elem p ps) && between 1 11 p = p : ps
                                    | otherwise = ps
                             


main :: IO ( )
main = do
print (tito)
print (meterGoles 2 tito)
let resultado = goles tito
print(resultado)