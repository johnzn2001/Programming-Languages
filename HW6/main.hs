--HW6
--JOHN NICHOLS 328001844

--Q1 EVALUATING

data E = IntLit Int
       | BoolLit Bool
       | Plus E E
       | Minus E E
       | Multiplies E E
       | Exponentiate E E
       | Equals E E
         deriving (Eq, Show)
eval :: E -> E
eval (Multiplies (IntLit x) (IntLit y)) = IntLit (x * y)
eval (Multiplies x y) = eval(Multiplies (eval(x)) (eval(y)))
eval (Plus (IntLit x) (IntLit y)) = IntLit(x+y)
eval (Plus x y) = eval(Plus (eval(x)) (eval(y)))
eval (Minus (IntLit x) (IntLit y)) = IntLit (x - y)
eval (Minus x y) = eval(Minus (eval(x)) (eval(y)))
eval (Equals x y) = BoolLit (eval x == eval y )
eval (Exponentiate (IntLit x) (IntLit y)) = IntLit (x^y)
eval (Exponentiate x y) = eval(Exponentiate (eval(x)) (eval(y)))

eval (BoolLit x) = BoolLit x
eval (IntLit x) = IntLit x

--Q2 TRANSFORMING

divEq:: Int -> Int -> Int-> Int
divEq x y count  
  | (x `mod` y ) == 0 &&  x>0 = divEq (x `div` y ) y (count+1)
  | x == 1 = count
  
log2Sim :: E -> E
log2Sim (IntLit 1) = IntLit 0
log2Sim (IntLit x) = IntLit (divEq x 2 0)

log2Sim (Multiplies (IntLit x) (IntLit y)) = Plus (IntLit x) (IntLit y) 
log2Sim (Multiplies x y) = Plus (log2Sim(x)) (log2Sim(y)) 
log2Sim (Exponentiate (IntLit x)(IntLit y)) = Multiplies (log2Sim(IntLit x)) (IntLit y)
log2Sim (Exponentiate x y) = Multiplies (log2Sim x) (log2Sim y)

log2Sim (Equals x y) = Equals (log2Sim x) (log2Sim y)
log2Sim (BoolLit x) = (BoolLit x)