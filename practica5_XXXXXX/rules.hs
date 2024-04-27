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