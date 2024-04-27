module Rules where

rulesArrowHead :: Char -> String
rulesArrowHead c = s
    where 
        s = case c of
            'F' -> "G-F-G"
            'G' -> "F+G+F"
            _   -> [c]

rulesKoch :: Char -> String
rulesKoch c = s
    where 
        s = case c of
            'F' -> "F+F--F+F"
            _   -> [c]

rulesKochCuadrada :: Char -> String
rulesKochCuadrada c = s
    where 
        s = case c of
            'F' -> "F+F-F-F+F"
            _   -> [c]
             

rulesSnowflake :: Char -> String
rulesSnowflake c = s
    where 
        s = case c of
            'F' -> "F-F++F-F"
            _   -> [c]

rulesIsla :: Char -> String
rulesIsla c = s
    where 
        s = case c of
            'F' -> "F+F-F-FF+F+F-F"
            _   -> [c]

rulessFlecha :: Char -> String
rulessFlecha c = s
    where 
        s = case c of
            'F' -> "G-F-G"
            'G' -> "F+G+F" 
            _   -> [c]

rulesSierpinsky :: Char -> String
rulesSierpinsky c = s
    where 
        s = case c of
            'F' -> "F-G+F+G-F"
            'G' -> "GG" 
            _   -> [c]

rulesHilbert :: Char -> String
rulesHilbert c = s
    where 
        s = case c of
            'F' -> "-G>+F>F+>G"
            'G' -> "+F>-G>G->F+" 
            _   -> [c]

rulesGosper :: Char -> String
rulesGosper c = s
    where 
        s = case c of
            'F' -> "F-G--G+F++FF+G"
            'G' -> "+F-GG--G-F++F+G" 
            _   -> [c]