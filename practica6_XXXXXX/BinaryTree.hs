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
add :: Arbol t -> Ord x -> Arbol t
