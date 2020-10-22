module Ex01 where
import Data.Char (toUpper)

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


{- Part 1

Write a function 'raise' that converts a string to uppercase

Hint: 'toUpper :: Char -> Char' converts a character to uppercase
if it is lowercase. All other characters are unchanged.
It is imported should you want to use it.

-}
raise :: String -> String
raise [] = []
raise (x:xs) = toUpper x : (raise xs)

{- Part 2

Write a function 'nth' that returns the nth element of a list.
Hint: the test will answer your Qs

-}
nth :: Int -> [a] -> a
nth i (x:xs)  |      i > 1         =      nth (i-1) xs         --if i > 1, recursive call nth
              |      i == 1        =      x    
              |      otherwise     =      x     


{- Part 3

Write a function `commonLen` that compares two sequences
and reports the length of the prefix they have in common.

-}


commonLen :: Eq a => [a] -> [a] -> Int
commonLen _ [] = 0
commonLen [] _ = 0
commonLen (x:xs) (y:ys)     |      x == y        =      1 + commonLen (xs) (ys)         
                            |      otherwise     =      0

{- Part 4



Write a function `runs` that converts a list of things
into a list of sublists, each containing elements of the same value,
which when concatenated together give the same list

So `runs [1,2,2,1,3,3,3,2,2,1,1,4]`
 becomes `[[1],[2,2],[1],[3,3,3],[2,2],[1,1],[4]]`

Hint:  `elem :: Eq a => a -> [a] -> Bool`

HINT: Don't worry about code efficiency
       Seriously, don't!

-}

elem :: Eq a => a -> [a] -> Bool
elem x y:ys    |      x == y       =      x:y:ys        --if x == y append x to list

concurrentEquals:: a -> [a] -> Int
concurrentEquals x y:ys     |      x == y        =      1 + concurrentEquals y ys

splitAt :: Int -> [a] -> ([a], [a])

runs :: Eq a => [a] -> [[a]]
i = 0
ans = []
runs [] = ans        --[] input if recursion complete
runs (x:xs)   |      elem x xs     =  splitAt ((concurrentEquals x xs) x:xs)   
              |      otherwise     = runs (xs) 

{-
Use commonLen to append a list of size x mapped with relavent value into output list.
Cut x from list xs afte r iterating through.
reverse list once finished
-}
