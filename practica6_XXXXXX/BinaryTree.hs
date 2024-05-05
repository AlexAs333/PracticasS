--Alex Asensio Boj 874252
--Pablo Báscone Gállego 874802

module BinaryTree where

import Data.List

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

---------------FUNCIONES DEL ÁRBOL BINARIO DE BÚSQUEDA EQUILIBRADO (AVL)---------------
buildBalanced :: (Ord a) => [a] -> Arbol a
buildBalanced l = buildBalanced' lOrd empty
    where
        lOrd = sort l

buildBalanced' :: (Ord a) => [a] -> Arbol a -> Arbol a
buildBalanced' [] arbol = arbol
buildBalanced' l arbol = arbol'
    where
        (medio, listaIzq, listaDech) = divideLista l
        arbol' = Nodo medio (buildBalanced' listaIzq empty) (buildBalanced' listaDech empty)

balance :: (Ord a) => Arbol a -> Arbol a
balance arbol = buildBalanced l
    where
        l = arbolLista arbol

--divideLista :: [a] -> (a, [a], [a])
--divideLista [] = error "La lista está vacía"
--divideLista [x] = (x, [], [])
--divideLista xs = (mid, left, right)
  --where
    --mid = head (drop (length xs `div` 2) xs)
    --left = take (length xs `div` 2) xs
    --right = drop ((length xs `div` 2) + 1) xs

divideLista :: [a] -> (a, [a], [a])
divideLista [] = error "La lista está vacía"
divideLista xs = (mid, left, right)
  where
    (left, mid:right) = splitAt (length xs `div` 2) xs

arbolLista :: Arbol a -> [a]
arbolLista Empty = []
arbolLista (Nodo x izq dch) = arbolLista izq ++ [x] ++ arbolLista dch

---------------RECORRIDO DE ÁRBOLES BINARIOS---------------
preorder :: Arbol a -> [a]
preorder Empty = []
preorder (Nodo x izq dch) = [x] ++ preorder izq ++ preorder dch

inorder :: Arbol a -> [a]
inorder Empty = []
inorder (Nodo x izq dch) =  inorder izq ++ [x] ++ inorder dch

postorder :: Arbol a -> [a]
postorder Empty = []
postorder (Nodo x izq dch) =  postorder izq ++ postorder dch ++ [x]

between :: (Ord a) => Arbol a -> a -> a -> [a]
between arbol min max = filter (\x -> x == min || (x == max) || (x > min && x < max)) aLista
    where
        aLista = arbolLista arbol