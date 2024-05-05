--Alex Asensio Boj 874252
--Pablo Báscones Gállego 874802



--Esta función recibe dos parámetros, una lista que reordenar y el número de las nuevas listas a crear de todas sus combinaciones
--Función para calcular el número de combinaciones (Siendo m length lista y n length nuevas listas): m!/n! (m-n)!
combine :: Int -> [a] -> [[a]]
combine 0 [_] = [[]]    --Caso base: al llegar a 0 no quedan más elementos que coger, te quedas con lo que te queda
combine _ []     = []    -- Caso base: cuando la lista está vacía, no hay combinaciones posibles
combine n (s:ss) = map (s:) (combine (n-1) ss) ++ combine n ss --Caso recursivo: para toda la lista (Map) agrego x al principio de cada lista, luego recursivamente enlistas al resto de la lista de manera recursiva,

permute :: (Eq a) => [a] -> [[a]]
permute [] = [[]] --Caso base
permute xs = [x : ys | x <- xs, ys <- permute (borrar x xs)] -- Genera todas las permutaciones de la lista `xs` seleccionando cada elemento `x` y 
                                                            --generando recursivamente todas las permutaciones de la lista restante después de eliminar `x`.
    where --Función borrar: elimina elementos de la lista. Los ya permutados
        borrar _ []                 = [] -- Lista vacía -> no borramos
        borrar y (x:xs)
            | x == y    = xs               -- Si el primer elemento es igual a `y`, se borra, devolviendo el resto de la lista
            | otherwise = x : borrar y xs  -- Si el primer elemento no es igual a `y`, se conserva y se aplica `borrar` recursivamente al resto de la lista