module Main where

  factorial :: Integer -> Integer
  factorial 0 = 1
  factorial x = x * factorial (x - 1)

  fibTuple :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
  fibTuple (x, y, 0) = (x, y, 0)
  fibTuple (x, y, index) = fibTuple (y, x + y, index - 1)

  fibResult :: (Integer, Integer, Integer) -> Integer
  fibResult (x, y, z) = x

  fibNextPair :: (Integer, Integer) -> (Integer, Integer)
  fibNextPair (x, y) = (y, x + y)

  fibNthPair :: Integer -> (Integer, Integer)
  fibNthPair 1 = (1, 1)
  fibNthPair n = fibNextPair (fibNthPair (n - 1))

  fib :: Integer -> Integer
  fib = fst . fibNthPair
