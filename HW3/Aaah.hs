seeDoctor:: String -> String -> Bool 
seeDoctor [] [] = False
seeDoctor doctor patient = if length doctor < length patient && not ('A' `elem` patient) && not ('H' `elem` patient) && ('A' `elem` doctor) && ('H' `elem` doctor) then True else False
