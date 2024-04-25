module Main where

import LSystem
import SVG
-----PRUEBAS TORTUGA-----
main :: IO ()
main = do
    --Cuadrado
    let figura = tplot (1,90,(0,0),90) ">+>+>+>+"
    savesvg "cuadrado" figura

    --Triangulo equilatero
    let triangulo = tplot (1, 120, (0,0), 90) ">+>+>"
    savesvg "triangulo" triangulo

    --Hexágono regular
    let hexagono = tplot (1, 60, (0,0), 90) ">+>+>+>+>+>"
    savesvg "hexagono" hexagono

    --Estrella
    let estrella = tplot (1, 144, (0,0), 90) ">+>+>+>+>"
    savesvg "estrella" estrella