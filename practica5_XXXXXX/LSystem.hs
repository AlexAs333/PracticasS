module LSystem where

import SVG
import Turtle

tplot :: Turtle -> String -> [Position]
tplot (_, _, pos, _) [] = [pos]  -- Caso Base --> Hemos recorrido todo el string
tplot trotuman (s:ss) = pos trotuman : tplot (moveTurtle trotuman action) ss  -- Caso Recursivo
    where
        pos (_, _, p, _) = p
        action = case s of
            '>' -> Forward
            '+' -> TurnRight
            '-' -> TurnLeft