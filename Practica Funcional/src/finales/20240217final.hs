import Text.Show

data A = A{
              habilidad :: [Habilidad]
} deriving (Show)
type Habilidad = String 
type Problema = String 
habilidades :: A -> [Habilidad]
habilidades = habilidad 

sirve :: Problema -> Habilidad -> Bool
sirve p h = p == h
mapSirve p [h] = map (sirve p) [h]
--podrianAyudar :: Problema -> [A] -> [A]
podrianAyudar p a = filter (\unaP ->  any (sirve p) ( habilidades unaP )) a

x = A {
	habilidad = ["xx", "a"]
}
z = A {
	habilidad = ["a", "bb"]
} 
y = A {
	habilidad = ["xx", "c"]
}
personas = [x, z, e, y]
lista = repeat "hola"

e = A {
	habilidad = lista
}
--aplicarReq :: [Requisito] -> Atleta ->Bool
--aplicarReq requisitos atletas = all (\requisito -> requisito atletas) requisitos 
