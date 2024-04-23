-- Alex Asensio Boj 874252
-- Pablo Báscones Gállego 874802


import Data.List
import Data.List.NonEmpty (NonEmpty((:|)))

data RList a = Elemento a | Lista [RList a]

flatten :: RList a -> [a]
flatten (Elemento e) = [e] --Caso base: no hay listas en rList, devuelvo lista normal con elemento e
flatten (Lista xs) = concatMap flatten xs --Caso recursivo: hay listas y las concatena a la lista sin recursividad usando flatten

pack :: Eq a => [a] -> [[a]]
pack [] = [] --Caso base: lista vacía
pack (x:xs) = (x : primero) : pack resto
    where
        (primero, resto) = span (== x) xs --span -> divide las que son del resto de la lista (xs) si son iguales que x

--rle :: Eq a => [a] -> [(Integer, a)]
--rle = map (\l -> (toInteger (length l), head l)) . group --Para cada elemento de la lista, aplicamos . group, que enlista a los elementos iguales sucesivos

rle :: Eq a => [a] -> [(Integer, a)]
rle [] = []
rle (x:xs) = (toInteger (length (x:|ys)), x) : rle zs
  where
    (ys, zs) = span (== x) xs

unrle :: Eq a => [(Integer, a)] -> [a]
unrle = concatMap (\(n, x) -> replicate (fromInteger n) x) --Con map aplicamos la función a toda la lista, así que con concatMap lo hacemos y luego lo concatenamos. Con uncurry replicate conseguimos que con la tupla creada, tome el primer elemento de una tupla (numero veces) y lo esccriba ese número de veces en una lista