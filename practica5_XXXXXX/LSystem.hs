module LSystem where

import Data.Char
import SVG
import Turtle
import Rules

-------------------TAREA 1-------------------
tplot :: Turtle -> String -> [Position]
tplot (_, _, pos, _) [] = [pos]  -- Caso Base --> Hemos recorrido todo el string
tplot trotuman (s:ss) = pos trotuman : tplot (moveTurtle trotuman action) ss  -- Caso Recursivo
    where
        pos (_, _, p, _) = p
        action = case s of
            '>' -> Forward
            '+' -> TurnRight
            '-' -> TurnLeft

-------------------TAREA 2-------------------
--Devuelve String de movimientos
lsystem :: (Char -> String) -> String -> Int -> String
lsystem rule s 0 = s -- Caso Base --> Ya se ha hecho todas las veces
lsystem rule s n = lsystem rule (concat (map rule s)) (n - 1) -- Caso recursivo             

tplot2 :: Turtle -> String -> [Position]
tplot2 (_, _, pos, _) [] = [pos]  -- Caso Base --> Hemos recorrido todo el string
tplot2 trotuchad (s:ss) = pos trotuchad : tplot2 newTrotuchad ss  -- Caso Recursivo
    where
        pos (_, _, p, _) = p
        newTrotuchad = case s of
            '>' -> (moveTurtle trotuchad Forward) --Nueva hacia alante y tal
            c | isUpper c -> (moveTurtle trotuchad Forward)
            '+' -> (moveTurtle trotuchad TurnRight)
            '-' -> (moveTurtle trotuchad TurnLeft)
            otherwise -> trotuchad -- La old