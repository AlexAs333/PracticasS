--Alex Asensio Boj 874252
--Pablo Báscones Gállego 874802



--Esta función recibe dos parámetros, una lista que reordenar y el número de las nuevas listas a crear de todas sus combinaciones
--Función para calcular el número de combinaciones (Siendo m length lista y n length nuevas listas): m!/n! (m-n)!
combine :: Int -> [a] -> [[a]]
combine 0 [_] = [[]]    --Caso base: al llegar a 0 no quedan más elementos que coger, te quedas con lo que te queda
combine n (s:ss) = Map (s:) (combine n-1 [ss]) ++ combine n xs --Caso recursivo: para toda la lista (Map) agrego x al principio de cada lista, luego recursivamente enlistas al resto de la lista de manera recursiva, 