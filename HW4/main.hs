-- HW4
-- JOHN NICHOLS 328001844
-- Q1 CRT

sumList :: [(Integer, Integer)] -> Integer
sumList [] = 1
sumList (x:xs) = snd x * sumList xs 
factorsList :: (Integer, Integer) -> [Integer]
factorsList (a,n) = [a + x  | x <- [0..105], x `mod` n == 0]
leastCommon:: [Integer] -> Integer -> Bool
leastCommon myList n = n `elem` myList --if n is in the list 

listC :: [Integer] -> [Integer] -> Integer
listC [] _ = -1
listC (x:xs) l2 = if leastCommon l2 x then x else listC xs l2
setEq:: (Integer, Integer)-> (Integer, Integer) -> (Integer, Integer)
setEq (a1,n1) (a2,n2) =  (listC (factorsList(a1, n1)) (factorsList(a2, n2))  , n1 * n2)
loopEq :: [(Integer,Integer)] ->(Integer,Integer)-> (Integer,Integer)
loopEq [] (a,n) = (a,n) 
loopEq (x:xs) current = loopEq xs (setEq current (x))

-- END CODE
crt:: [(Integer,Integer)] -> (Integer,Integer)
crt (x:xs) = loopEq xs x


-- Q2 K/ANAGRAM
factorCount :: Integer -> [Integer]
factorCount  n = [x | x <- [2..div n 2 +1], n `mod` x == 0]
kcomposite :: Integer -> [Integer]
kcomposite n = [x | x <- [1..], toInteger (length (factorCount x)) == n ]

checkTwo :: Integer -> [Integer]-> Bool
checkTwo _ [] = False
checkTwo listLength (x:xs)
    | listLength > x = checkTwo listLength xs
    | listLength == x = True
    | listLength < x = False
changeTwo :: [Char] -> [Char]
changeTwo myWord = if x then myWord else changeTwo (myWord ++ ['X']) 
    where x = checkTwo ( toInteger (length myWord)) (kcomposite 2)

createRow :: [Char] -> Integer -> [Char]
createRow myWord n = take (fromInteger n) myWord
createColl :: [Char] -> [Integer] -> [[Char]]
createColl [] _ = []
createColl myWord n = [createRow (myWord) (sndFactor)] ++ createColl (drop (fromInteger sndFactor) myWord) n
    where sndFactor = last n

combineAll:: [[Char]] -> [Char]
combineAll [] = []
combineAll listOfStrings = if head listOfStrings == [] then [] else map head listOfStrings ++ combineAll (map tail listOfStrings)
-- END CODE
anagramEncode :: [Char] -> [Char]
anagramEncode myList = combineAll (createColl (changeTwo myList) (factorCount  (toInteger (length (changeTwo myList)))))

cleanAll:: [Char]->[Char]
cleanAll myList = if last myList /= 'X' then myList else cleanAll (init myList)
-- END CODE
anagramDecode :: [Char] -> [Char]
anagramDecode myList = cleanAll (combineAll (createColl myList (reverse (factorCount  (toInteger (length (myList)))))))

col :: [[Int]] -> [Int]
col n = map head n


--Q3 DIE HARD
oneTwo :: (Integer,Integer) ->(Integer,Integer)-> (Integer,Integer)
oneTwo jugs jugSizes = if fst jugs == 0 || snd jugs == snd jugSizes then jugs else oneTwo (fst jugs - 1,snd jugs +1) jugSizes
twoOne :: (Integer,Integer) ->(Integer,Integer)-> (Integer,Integer)
twoOne jugs jugSizes = if snd jugs == 0 || fst jugs == fst jugSizes then jugs else twoOne (fst jugs + 1,snd jugs -1) jugSizes

checkList:: (Integer,Integer) ->(Integer,Integer)->Integer->(Integer,Integer)
checkList jugs sizeOfJugs i --i is the action number we want to do
    | i == 1 = if fst jugs == fst sizeOfJugs then jugs else (fst sizeOfJugs, snd jugs)
    | i == 2 = if snd jugs == snd sizeOfJugs then jugs else (fst jugs ,snd sizeOfJugs)
    | i == 3 = if fst jugs == 0 || snd jugs == snd sizeOfJugs then jugs else oneTwo (fst jugs - 1,snd jugs +1) sizeOfJugs
    | i == 4 = if snd jugs == 0 || fst jugs == fst sizeOfJugs then jugs else twoOne (fst jugs + 1,snd jugs -1) sizeOfJugs
    | i == 5 = (0 ,snd jugs)
    | i == 6 = (fst jugs ,0)
    | otherwise = (-100,-100) --catch all of bad
checkWorks:: [(Integer,Integer)] -> (Integer,Integer) -> (Integer,Integer)->[Integer] -> Int-> Bool
checkWorks stateList jugs _ [] _ = False
checkWorks stateList jugs sizeOfJugs (x:xs) output  
    |  (fst newState + snd newState) == toInteger output = True
    |  newState `elem` stateList =  checkWorks stateList jugs sizeOfJugs xs output  
    |  otherwise = checkWorks (stateList ++ [newState]) newState sizeOfJugs [1..6] output 
    where newState = checkList jugs sizeOfJugs x --the state we are checking 

-- END CODE
measureWater:: Int -> Int -> Int -> Bool
measureWater jug1 jug2 output = checkWorks [(0,0)] (0,0) (toInteger jug1, toInteger jug2) [1..6] output
    -- [(0,0),(3,0),(0,3),(3,3),(1,5)]