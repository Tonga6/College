{- butrfeld Andrew Butterfield -}
module Ex02 where

name, idno, username :: String
name      =  "Oisin, Tong"  -- replace with your name
idno      =  "18323736"    -- replace with your student id
username  =  "tongo"   -- replace with your TCD username


declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes and key functions -----------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Dict String d -> String -> Either String d
find []             name              =  Left ("undefined var "++name)
find ( (s,v) : ds ) name | name == s  =  Right v
                         | otherwise  =  find ds name

type EDict = Dict String Double

v42 = Val 42 ; j42 = Just v42

-- do not change anything above !

-- Part 1 : Evaluating Expressions -- (50 test marks, worth 25 Exercise Marks) -

-- Implement the following function so all 'eval' tests pass.

-- eval should return `Left msg` if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.
  -- see test outcomes for the precise format of those messages

eval :: EDict -> Expr -> Either String Double -- (Either Left: Error or Right: Double)
--eval Var
eval d (Var e) = find d e --find Var e in dict d
--eval Val
eval _ (Val e) = Right e

eval d (Add a b) 
    = case (eval d a, eval d b) of  --evaluate both expressions for pattern match
      (Right x, Right y) -> Right (x+y) --if both expressions are valid, return the sum
      (Left x, Right y) -> Left x --if x is invalid, return appropriate error
      (Right x, Left y) -> Left y --if y is invalid, return appropriate error
      (_, _) -> error("Test")

eval d (Mul a b) 
    = case (eval d a, eval d b) of  --evaluate both expressions for pattern match
      (Right x, Right y) -> Right (x*y) --if both expressions are valid, return the product
      (Left x, Right y) -> Left x --if x is invalid, return appropriate error
      (Right x, Left y) -> Left y --if y is invalid, return appropriate error

eval d (Sub a b) 
    = case (eval d a, eval d b) of  --evaluate both expressions for pattern match
      (Right x, Right y) -> Right (x-y) --if both expressions are valid, return the difference
      (Left x, Right y) -> Left x --if x is invalid, return appropriate error
      (Right x, Left y) -> Left y --if y is invalid, return appropriate error

eval d (Dvd a b) 
    = case (eval d a, eval d b) of  --evaluate both expressions for pattern match
      (Right x, Right y) -> Right (x/y) --if both expressions are valid, return the div
      (Left x, Right y) -> Left x --if x is invalid, return appropriate error
      (Right x, Left y) -> Left y --if y is invalid, return appropriate error

eval d (Def n a b)
    = let x = eval d a --evaluate expr a so we can use the result for b
    in case (x) of --check what's up with the result of expr a
      Right x -> eval (define d n x) b --add the result of expr a to the dictionary and then use that new dict for expr b
    

--eval d e = error "eval NYI"



-- Part 2 : Expression Laws -- (15 test marks, worth 15 Exercise Marks) --------

{-

There are many, many laws of algebra that apply to our expressions, e.g.,

  x + y            =  y + z         Law 1
  x + (y + z)      =  (x + y) + z   Law 2
  x - (y + z)      =  (x - y) - z   Law 3
  (x + y)*(x - y)  =  x*x - y*y     Law 4
  ...

  We can implement these directly in Haskell using Expr

  Function LawN takes an expression:
    If it matches the "shape" of the law lefthand-side,
    it replaces it with the corresponding righthand "shape".
    If it does not match, it returns Nothing

    Implement Laws 1 through 4 above
-}


law1 :: Expr -> Maybe Expr
law1 expr 
      = case expr of --if it's real
        (Add x y) -> Just (Add y x) --just swap
        _         -> Nothing


law2 :: Expr -> Maybe Expr
law2 expr
      = case expr of --if it's real
        (Add x (Add y z)) -> Just (Add (Add x y) z) --just swap
        _                 -> Nothing

law3 :: Expr -> Maybe Expr
law3 expr
      = case expr of --if it's real
        (Sub x (Add y z)) -> Just (Sub (Sub x y) z) --just swap
        _                 -> Nothing

law4 :: Expr -> Maybe Expr
law4 expr  
      =case (expr) of --if it's real
        (Mul (Add a b) (Sub c d)) -> Just (Sub (Mul a c) (Mul b d)) --check both conditions against each other
        _                         -> Nothing

