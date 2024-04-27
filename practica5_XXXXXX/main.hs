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
    let koch = lsystem rulesKoch "Fkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk" 3
    let posKoch = tplot2 (1, 60, (0,0), 0) koch
    savesvg "CurvaDeKoch" posKoch

    --Curva de Koch cuadrada
    let cuadrada = lsystem rulesKochCuadrada "F" 3
    let posCuadrada = tplot2 (1, 90, (0,0), 0) cuadrada
    savesvg "CurvaKochCuadrada" posKoch

    --Koch Snowflake
    let snow = lsystem rulesSnowflake "F++khF++Fkkkk" 3
    let posSnow = tplot2 (1, 60, (0,0), 0) snow
    savesvg "KochSnowflake" posSnow

    --Isla de Minkowski
    let isla = lsystem rulesIsla "F+F+F+F" 2
    let posIsla = tplot2 (1, 90, (0,0), 0) isla
    savesvg "IslaMinkowski" posIsla

    --Sierpinsky Arrow Head
    let sierpinskyarrow = lsystem rulessFlecha "F" 6
    let posflecha = tplot2 (1, 60, (0,0), 0) sierpinskyarrow
    savesvg "SierpinskyArrowHead" posflecha
    
    --Sierpinsky
    let sierpinsky= lsystem rulesSierpinsky"F-G-G" 4
    let possierpinsky = tplot2 (1, 120, (0,0), 180) sierpinsky
    savesvg "TrianguloSierpinsky" possierpinsky

    --Curva de Hilbert
    let hilbert= lsystem rulesHilbert "F" 4
    let poshilbert = tplot2 (1, 90, (0,0), 180) hilbert
    savesvg "CurvaDeHilbert" poshilbert

    --Curva de Gosper
    let gosper = lsystem rulesGosper "F" 3
    let posgosper = tplot2 (1, 90, (0,0), 135) gosper
    savesvg "CurvaDeGosper" posgosper