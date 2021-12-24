-- HW3
-- JOHN NICHOLS 3280001844
-- Q1

myReverse :: [Integer] -> [Integer]
myReverse [] = []
myReverse (x:xs) = reverse xs ++ [x]

isElement :: Integer -> [Integer] -> Bool 
isElement _ [] = False
isElement n (x:xs) = if n==x then True else isElement n xs

duplicate :: [Integer] -> [Integer]
duplicate [] = []
duplicate (x:xs) = x:x:duplicate xs

removeDuplicate :: [Integer] -> [Integer]
removeDuplicate [] = []
removeDuplicate (x: xs)
    | x `elem` xs = removeDuplicate xs 
    | otherwise = x : removeDuplicate xs 

rotate:: String -> Int -> String 
rotate xs n = take len . drop(n `mod` len) . cycle $ xs
    where len = length xs

flatten :: [[Integer]] -> [Integer]
flatten [] = []
flatten myList = head myList ++ flatten(tail myList)

isPalindrome :: String -> Bool 
isPalindrome [] = True
isPalindrome (x:[]) = True
isPalindrome x = if head x /= last x then False  else isPalindrome( tail (init x))

coprime :: Integer -> Integer -> Integer
coprime x y = if x `mod` y == 0 then y else coprime y (mod x y)


-- END OF Q1

-- START OF Q2 AAAH


seeDoctor:: String -> String -> Bool 
seeDoctor [] [] = False
seeDoctor doctor patient = if length doctor < length patient && not ('A' `elem` patient) && not ('H' `elem` patient) && ('A' `elem` doctor) && ('H' `elem` doctor) then True else False


-- END OF Q2

-- START OF Q3 WATERGATE


waterGate:: Integer -> Integer 
waterGate n = countG (looper ( [False | x <- [1..n]] ) 1 n) 0

countG:: [Bool] -> Integer ->Integer
countG [] counter = counter
countG (x:xs) counter = if x then countG xs (counter+1) else countG xs counter

looper:: [Bool] -> Integer ->Integer -> [Bool]
looper myList _ 0= myList
looper myList i stopper= looper (flipT myList 1 i) (i+1) (stopper -1)

flipT :: [Bool] -> Integer-> Integer -> [Bool]
flipT [] _ _ = []
flipT (x:xs) n i = if(mod n i == 0) then (not x):flipT xs (n+1) i else x:flipT xs (n+1) i


-- END OF Q3

-- START OF Q4 GOLDBACH


sqDouble:: [Integer] -> Integer-> Bool
sqDouble (x:xs) n
    | x < n = sqDouble xs n
    | n == x = True
    | x > n = False

primeL :: [Integer] -> Integer -> Bool
primeL (x:xs) n --(x:xs) is the list of primes , n is the composite number
    | x > n = False
    | even (n-x) = if sqDouble ([2*(x^2) | x <- [1..]]) (n-x) then True else primeL xs n
    | odd (n-x) = primeL xs n

isPrime:: Integer -> Bool
isPrime 1 = False
isPrime n = ([] == [x | x <- [2..(n-1)], n `mod` x == 0])

listP:: [Integer]
listP  = [k | k<-[1..], isPrime k]

listC:: [Integer]
listC  = [k | k<-[2..], not (isPrime k), odd k]

checkC:: [Integer] -> Bool -> Integer 
checkC (x:xs) isStopped = if not (primeL listP x) then x else checkC xs (primeL listP x)

goldBach:: Integer 
goldBach = checkC listC True