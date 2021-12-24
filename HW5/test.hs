----------------------------------------------------
--FILE NAME: A3.hs           |* * * * * |##########|
--NAME: Han Hong             | * * * * *|##########|
--                           |* * * * * |##########|
--CSCE 314 SECTION 500       |#####################|
--UIN: 824000237             |#####################|
----------------------------------------------------

import Data.Char

--Data Types, Type Classes ======================================================
data Tree a b = Branch b (Tree a b) (Tree a b)
			  | Leaf a
			  
instance (Show a, Show b) => Show (Tree a b) where
  show tree =
    let helper n (Leaf a) = (take n $ repeat ' ') ++ show a
        helper n (Branch nd l1 l2) = (take n $ repeat ' ') ++ show nd ++ "\n" ++
                                     (helper (n+2) l1) ++ "\n" ++
                                     (helper (n+2) l2)
    in  helper 0 tree

preorder  :: (a -> c) -> (b -> c) -> Tree a b -> [c]
preorder leaf branch (Leaf x) = [leaf x]
preorder leaf branch (Branch nd l1 l2) =
  (branch nd) :
  ((preorder leaf branch l1) ++ (preorder leaf branch l2))
  
postorder :: (a -> c) -> (b -> c) -> Tree a b -> [c]
postorder leaf branch (Leaf x) = [leaf x]
postorder leaf branch (Branch nd l1 l2) =
  ((postorder leaf branch l1) ++ (postorder leaf branch l2)) ++ [branch nd]
  
inorder :: (a -> c) -> (b -> c) -> Tree a b -> [c]
inorder leaf branch (Leaf x) = [leaf x]
inorder leaf branch (Branch nd l1 l2) =
  (inorder leaf branch l1) ++ [branch nd] ++ (inorder leaf branch l2)
  
-- mytree = Branch "A" 
           -- (Branch "B" 
              -- (Leaf 1) 
              -- (Leaf 2)) 
           -- (Leaf 3)