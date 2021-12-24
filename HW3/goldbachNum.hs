--this function checks if a number is in a list of a 2 * perfect square
isDoubleSquare:: [Integer] -> Integer-> Bool
isDoubleSquare (x:xs) n
    | x < n = isDoubleSquare xs n
    | n == x = True
    | x > n = False

--this function takes a list of all primes and composite number it is checking n
loopOfPrimes :: [Integer] -> Integer -> Bool
loopOfPrimes (x:xs) n --(x:xs) is the list of primes , n is the composite number
    | x > n = False
    | even (n-x) = if isDoubleSquare ([2*(x^2) | x <- [1..]]) (n-x) then True else loopOfPrimes xs n
    | odd (n-x) = loopOfPrimes xs n

--isPrime Functions from class
isPrime:: Integer -> Bool
isPrime 1 = False
isPrime n = ([] == [x | x <- [2..(n-1)], n `mod` x == 0])

--makes the list of infinite primes based on isPrime
listOfPrimes:: [Integer]
listOfPrimes  = [k | k<-[1..], isPrime k]

--this function will generate an infinite list of compisite numbers
listOfComposite:: [Integer]
listOfComposite  = [k | k<-[2..], not (isPrime k), odd k]

--this function will loop through a list of composite numbers to check when the conjecture is false
compositeLooper:: [Integer] -> Bool -> Integer 
--compositeLooper ans False = head ans
compositeLooper (x:xs) isStopped = if not (loopOfPrimes listOfPrimes x) then x else compositeLooper xs (loopOfPrimes listOfPrimes x)

goldBach:: Integer 