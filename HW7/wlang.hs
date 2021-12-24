-- HW7, CSCE-314
-- JOHN NICHOLS
-- 328001844
module Main where

import Prelude hiding (lookup)

import Test.HUnit
import System.Exit

-- AST definition for W
data WValue = VInt Int 
            | VBool Bool 
              deriving (Eq, Show)

data WExp = Val WValue

          | Var String

          | Plus WExp WExp
          | Minus WExp WExp
          | Multiplies WExp WExp
          | Divides WExp WExp

          | Equals WExp WExp
          | NotEqual WExp WExp
          | Less WExp WExp
          | Greater WExp WExp
          | LessOrEqual WExp WExp
          | GreaterOrEqual WExp WExp

          | And WExp WExp
          | Or WExp WExp
          | Not WExp

data WStmt = Empty
           | VarDecl String WExp
           | Assign String WExp
           | If WExp WStmt WStmt
           | While WExp WStmt
           | Block [WStmt]

type Memory = [(String, WValue)]
marker = ("|", undefined)
isMarker (x, _) = x == "|"

-- eval
eval :: WExp -> Memory -> WValue
eval (Val (VInt x)) myMemory = VInt x
eval (Val (VBool y)) myMemory = VBool y
eval (Var myString) myMemory = fromJust(lookup myString myMemory)
-- +
eval (Plus (Val (VInt x) ) (Val (VInt y))) myMemory = VInt(x+y)
eval (Plus x y) mm = eval (Plus (Val (eval x mm)) (Val (eval y mm))) mm
-- -
eval (Minus (Val (VInt x) ) (Val (VInt y))) myMemory = VInt(x-y)
eval (Minus x y) mm = eval (Minus (Val (eval x mm)) (Val (eval y mm))) mm
-- x
eval (Multiplies (Val (VInt x) ) (Val (VInt y))) myMemory = VInt(x*y)
eval (Multiplies x y) mm = eval (Multiplies (Val (eval x mm)) (Val (eval y mm))) mm
-- /
eval (Divides (Val (VInt x) ) (Val (VInt y))) myMemory = VInt(div x y)
eval (Divides x y) mm = eval (Divides (Val (eval x mm)) (Val (eval y mm))) mm
-- =
eval (Equals x y) mm = VBool ((eval x mm) == (eval y mm))
-- !=
eval (NotEqual x y) mm = VBool ((eval x mm) /= (eval y mm))
-- <
eval (Less x y) mm = VBool (asInt(eval x mm) < asInt(eval y mm))
-- <=
eval (LessOrEqual x y) mm = VBool (asInt(eval x mm) <= asInt(eval y mm))
-- >
eval (Greater x y) mm = VBool (asInt(eval x mm) > asInt(eval y mm))
-- >=
eval (GreaterOrEqual x y) mm = VBool (asInt(eval x mm) >= asInt(eval y mm))
-- and
eval (And (Val (VBool True)) (Val (VBool True))) mm = VBool True 
eval (And (Val (VBool _)) (Val (VBool _))) mm = VBool False 
eval (And x y) mm = eval (And (Val (eval x mm)) (Val (eval y mm))) mm
-- or
eval (Or (Val (VBool False)) (Val (VBool False))) mm = VBool False 
eval (Or (Val (VBool _)) (Val (VBool _))) mm = VBool True 
eval (Or x y) mm = eval (Or (Val (eval x mm)) (Val (eval y mm))) mm
-- not
eval (Not (Val (VBool True))) mm = VBool False
eval (Not (Val (VBool False))) mm = VBool True
eval (Not x) mm =  (eval x mm)

-- exec
exec :: WStmt -> Memory -> Memory
exec (VarDecl name thing) mm =  if (lookup name mm) == Nothing then (name, eval thing mm) : mm   else  error "Variable already declared"  --is this right???? how does memory work???
exec (Assign name thing) mm = if (lookup name mm) /= Nothing then help2 mm name (eval thing mm) else error "Variable was not declared"  --- i know this is wrong lol
exec (Block stmtlist) mm = (bHelp stmtlist mm2)
  where mm2 = ("|",VInt (-1)) : mm
exec (If exp stmt1 stmt2) mm = if asBool(eval exp mm) then exec stmt1 mm else exec stmt2 mm
exec (While exp stmt1) mm = if asBool(eval exp mm) then exec (While exp stmt1) (exec stmt1 mm) else mm 
bHelp :: [WStmt] -> Memory -> Memory
bHelp [] mm = memD mm
bHelp (x:xs) mm = (bHelp xs (exec x mm))
memD:: Memory -> Memory
memD (x:xs) = if not (isMarker x) then memD xs else xs
help:: Memory -> String -> Int -> Int 
help (x:xs) f count = if fst x == f then count else help xs f (count+1)
help2:: Memory -> String -> WValue -> Memory
help2 myList name newV = take count myList ++ [(name,newV)] ++ drop (count+1) myList
  where count = (help myList name 0 )
-- ex
result = lookup "result" ( exec factorial [("result", undefined), ("x", VInt 10)] )

factorial = 
  Block
  [
    VarDecl "acc" (Val (VInt 1)),
    While (Greater (Var "x") (Val (VInt 1)))
    (
      Block
      [
        Assign "acc" (Multiplies (Var "acc") (Var "x")),
        Assign "x" (Minus (Var "x") (Val (VInt 1)))         
      ]
    ),
    Assign "result" (Var "acc")
  ]

p1 = Block
     [
       VarDecl "x" (Val (VInt 0)),
       VarDecl "b" (Greater (Var "x") (Val (VInt 0))),
       If (Or (Var "b") (Not (GreaterOrEqual (Var "x") (Val (VInt 0)))))
         ( Block [ Assign "x" (Val (VInt 1)) ] )
         ( Block [ Assign "x" (Val (VInt 2)) ] )
     ]

-- some useful helper functions
lookup s [] = Nothing
lookup s ((k,v):xs) | s == k = Just v
                    | otherwise = lookup s xs

asInt (VInt v) = v
asInt x = error $ "Expected a number, got " ++ show x

asBool (VBool v) = v
asBool x = error $ "Expected a boolean, got " ++ show x

fromJust (Just v) = v
fromJust Nothing = error "Expected a value in Maybe, but got Nothing"

-- unit tests
myTestList =

  TestList [
    test $ assertEqual "p1 test" [] (exec p1 []),

    let res = lookup "result" (exec factorial [("result", undefined), ("x", VInt 10)])
    in test $ assertBool "factorial of 10" (3628800 == asInt (fromJust res))
    ]    

-- main: run the unit tests  
main = do c <- runTestTT myTestList
          putStrLn $ show c
          let errs = errors c
              fails = failures c
          if (errs + fails /= 0) then exitFailure else return ()

fibonacci :: Int -> Int
fibonacci n = asInt(fromJust(lookup "result" (exec fibH [("result",undefined),("n",VInt n)])))
fibH = Block
  [
    VarDecl "x" (Val (VInt 0)),
    VarDecl "y" (Val (VInt 1)),
    VarDecl "count" (Val (VInt (1))),
    If (Equals (Var "n") (Val(VInt 0)))
      (Block [Assign "result"(Val(VInt 0))])
      (Block [
        If (Equals (Var "n") (Val(VInt 1)))
          (Block [Assign "result"(Val(VInt 1))])
          (Block [
              While (Less (Var "count")(Var "n"))
                (Block
                  [
                    Assign "result" (Plus (Var "x") (Var "y")),
                    Assign "x" (Var "y"),
                    Assign "y" (Var "result"),
                    Assign "count" (Plus (Var "count") (Val (VInt 1)))
                  ])
          ])
      ])
  ]
