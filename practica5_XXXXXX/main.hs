module Main where

import LSystem
import SVG
import Rules

main :: IO ()
main = do
-------------------PRUEBAS TORTUGA-------------------
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

-------------------PRUEBAS DIBUJOS-------------------
    --Arrow Head
    let arrowHead = lsystem rulesArrowHead "F" 2
    let posArrowHead = tplot2 (1, 40, (0,0), 60) arrowHead
    savesvg "ArrowHead" posArrowHead

    --Curva de Koch
    let koch = lsystem rulesKoch "F" 3
    let posKoch = tplot2 (1, 20, (0,0), 60) koch
    savesvg "CurvaDeKoch" posKoch

    --Curva de Koch cuadrada
    let cuadrada = lsystem rulesKochCuadrada "F" 3
    let posCuadrada = tplot2 (1, 20, (0,0), 90) cuadrada
    savesvg "CurvaKochCuadrada" posKoch

    --Koch Snowflake
    let snow = lsystem rulesSnowflake "F++F++F" 3
    let posSnow = tplot2 (1, 20, (0,0), 60) snow
    savesvg "KochSnowflake" posSnow

    --Isla de Minkowski
    let isla = lsystem rulesIsla "F+F+F+F" 3
    let posIsla = tplot2 (1, 20, (0,0), 90) isla
    savesvg "IslaMinkowski" posIsla