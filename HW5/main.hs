--HW5
--JOHN NICHOLS

--Q1 TREE TRAVERSAL

data Tree a b = Branch b (Tree a b) (Tree a b)
                | Leaf a

displayOne :: (Show a, Show b) => Tree a b -> String
displayOne (Leaf a) = ['\t'] ++ show a 
displayOne (Branch b l r) = show b ++ "\n\t" ++ displayOne l ++ "\n\t" ++displayOne r 
displayTwo :: (Show a, Show b) => Int-> Tree a b -> String
displayTwo f (Leaf a)  = ['\n'] ++ extend  ++ show a
    where extend = foldr (++) " " ([" " | x<-[1..f]])
displayTwo f (Branch b l r)  = ['\n'] ++ extend ++ show b ++ displayTwo (f+8) l ++ extend ++displayTwo (f+8) r 
    where extend = foldr (++) " " ([" " | x<-[1..f]])

instance (Show a, Show b) => Show (Tree a b) where
    show = displayTwo 0
mytree = Branch "A" (Branch "B" (Leaf (1::Int)) (Leaf (2::Int))) (Leaf (3::Int))

sumLeafs :: Tree a b  -> [a] 
sumLeafs (Leaf a) = [a]
sumLeafs (Branch b l r) = sumLeafs l ++ sumLeafs r
branchc :: Tree a b  -> [b]
branchc (Leaf a) = []
branchc (Branch b l r) = [b] ++ branchc l ++ branchc r
allLeaf :: Show a => [a] -> [String]
allLeaf leaves = map show ( leaves)
allBranch :: Show a => [a] -> [String]
allBranch branch = map show ( branch)

preorder:: (Show a , Show b) => Tree a b -> String
preorder (Leaf a) =  show a
preorder (Branch b l r) = show b ++  preorder l ++  preorder r
postorder:: (Show a , Show b) => Tree a b -> String 
postorder myTree = reverse (preorder myTree)
inorder:: (Show a, Show b) => Tree a b -> String 
inorder (Leaf a) = show a
inorder (Branch b l r) = inorder l ++ show b ++ inorder r


--Q2 SETS AND SET PRODUCTS

type Set a = [a]

func :: Set a -> Set a
func ls = ls
mkSet :: Eq a => [a] -> Set a 
mkSet [] = []
mkSet (l:ls) = if l `elem` ls then mkSet ls else l:mkSet ls 

--subset [1,2] [1,2,3]
subset :: Eq a => Set a -> Set a -> Bool
subset [] _ = True
subset (l1:ls1) ls2 = if l1 `elem` ls2 then subset ls1 ls2 else False

--setEqual [[1,2,3]] [[3,2,1]]
setEqual :: Eq a => Set a -> Set a -> Bool
setEqual ls1 ls2 = if (subset ls1 ls2) && (subset ls2 ls1) then True else False

--used given examples
setProd:: (Eq t, Eq t1) => Set t -> Set t1 -> Set (t,t1)
setProd set1 set2 = zip (concatMap (replicate (length set2)) set1) (take l (cycle set2))
                        where l = lcm (length set1) (length set2)


--Q3 SET PARTITIONS AND BELL NUMBERS
--this isn't working for many reasons below is my attempt at it

partition :: Int -> Set t -> Set(Set t)
partition _ [] = []
partition n xs = (take n xs) : (partition n (drop n xs))

unionPartition :: Set t -> Set(Set t) 
unionPartition xs = partition (length xs) xs
seperatePartition :: Set t -> Set(Set t) 
seperatePartition xs = partition 1 xs
transitionPartition :: Int -> Set t -> Set(Set t)
transitionPartition n xs = if (n < length xs) then partition (length xs - n) xs else []
fullPartition :: Int -> Set t -> Set(Set(Set t))
fullPartition n xs = if (n >= 0) then (transitionPartition n xs):(fullPartition (n-1) xs) else []

partitionSet :: Eq t => Set t -> Set(Set(Set t))
partitionSet xs = fullPartition (length (xs) - 1) xs
permutate :: (Eq t) => Set t -> Set(Set t)
permutate [] = [[]]
permutate l = [t:x | t <- l, x <- (permutate $ filter (\x -> x /= t) l)]

lastPartition' :: Eq t => Set(Set t) -> Set(Set(Set t))
lastPartition' [] = [[]]
lastPartition' permList = (fullPartition (length (head permList)) (head permList)) ++ lastPartition' (tail permList)

partitionSet' :: Eq t => Set t -> Set(Set(Set t))
partitionSet' xs = lastPartition' (permutate xs)

numbersList n = take n (repeat 1) 

bellNum :: Int -> Int
bellNum n = length(partitionSet (numbersList n))

weave [] [] = []
weave (l:ls) (m:ms) = (l,m) : weave2 ls ms
weave2 a b = weave b a

