module BinaryTree where

--Definición tipos de datos
data Arbol a = Nodo a (Arbol a) (Arbol a) | Empty

---------------FUNCIONES BÁSICAS DEL ÁRBOL BINARIO---------------
--Devuelve el árbol vacío sin ningún elemento
empty = Empty

--Devuelve un árbol que esta compuesto por una hoja que es a
leaf a = Nodo a Empty Empty

--Devuelve un arbol:
--      a
--    lc rc
tree x lc rc = Nodo x lc rc

--Devuelve el número de elementos de un arbol:
size Empty = 0
size (Nodo _ lc rc) = 1 + size lc + size rc

---------------MUESTRA POR PANTALLA---------------
instance (Show a) => Show (Arbol a) where
    show tree = showTree tree ""

showTree :: (Show a) => Arbol a -> String -> String
showTree Empty _ = "() \n"
showTree (Nodo x Empty Empty) indent =
    show x ++ "\n"
showTree (Nodo x left right) indent =
    show x ++ "\n" ++
    indent ++ "    |- " ++ showTree left (indent ++ "        ") ++
    indent ++ "    |- " ++ showTree right (indent ++ "        ")

---------------FUNCIONES DEL ÁRBOL BINARIO DE BÚSQUEDA (ABB)---------------
--Añade un elemento a el Arbol
add :: (Ord a) => Arbol a -> a -> Arbol a
add Empty x = Nodo x Empty Empty --Caso Base
add (Nodo v izq dch) x  --Caso Recursivo
    | x < v = Nodo v (add izq x) dch
    | x == v = Nodo v izq (add dch x)
    | x > v = Nodo v izq (add dch x)

build :: (Ord a) => [a] -> Arbol a
build l = build' l empty --Inmersión de recursividad

build' :: (Ord a) => [a] -> Arbol a -> Arbol a
build' [] arbol = arbol     --Caso base
build' (x:xs) arbol = build' xs arbol'  --Caso Recursivo
    where
        arbol' = add arbol x