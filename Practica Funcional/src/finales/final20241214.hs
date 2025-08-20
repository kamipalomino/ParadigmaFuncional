import Text.Show.Functions
import Prelude 
import Data.Maybe 
import Data.List

data Atleta = Atleta {
					edad :: Int,
					nacionalidad :: String,
					equipamiento :: [String]
					} deriving (Eq, Ord, Show)

--Requisito = (Eq a) => a -> Atleta -> Bool 
type Requisito = (Atleta -> Bool)

reqPorNac :: String -> Requisito
reqPorNac pais = (pais ==) . nacionalidad

reqPorNoNac :: String -> Requisito
reqPorNoNac pais = not . (reqPorNac pais )

reqSerMayorDe :: Int -> Requisito 
reqSerMayorDe anios = (<) anios . edad

reqEquipoNoPermitido :: String -> Requisito 
reqEquipoNoPermitido equipo = not . elem equipo . equipamiento 

competencia :: [Requisito]
competencia =[reqPorNac "Argentino", reqPorNoNac "Brasilero", reqSerMayorDe 18]

aplicarReq :: [Requisito] -> Atleta ->Bool
aplicarReq requisitos atletas = all (\requisito -> requisito atletas) requisitos 

controlDeInscrpcion :: [Requisito] -> [Atleta] -> [Atleta]
controlDeInscrpcion unaCompetencia = filter (aplicarReq unaCompetencia)


cam = Atleta {
			edad = 35,
			nacionalidad = "Argentino",
			equipamiento = ["pelota"]
			}
lu = Atleta {
			edad = 15,
			nacionalidad = "Argentino",
			equipamiento = []
			}
yo = Atleta {
			edad = 35,
			nacionalidad = "Brasilero",
			equipamiento = ["pelota"]
			}