module Main where

  prime :: Integral i => i -> Bool
  prime 2 = True
  prime x
    | x <= 1                                                                      = False
    | x `mod` 2 == 0                                                              = False
    | True `elem` [x `mod` n == 0 | n <- [3,5..truncate (sqrt (fromIntegral x))]] = False
    | otherwise                                                                   = True

  primeNth x = head (drop (x - 1) (take (x) [n | n <- [1..], prime n]))

  primeFactor :: Integer -> Integer -> Integer
  primeFactor n x
    | n == x             = x
    | (x `mod` n == 0)   = primeFactor n (x `div` n)
    | otherwise          = primeFactor (nextPrime n) x

  largestPrimeFactor x = primeFactor 2 x

  -- bad code begins here --

  nextPrime :: Integer -> Integer 
  nextPrime n = if prime (n + 1) then n + 1 else nextPrime (n + 1)

  sumOfPrimes :: Integer -> Integer -> Integer -> Integer
  sumOfPrimes x i n
    | (nextPrime i) >= x  = n
    | otherwise = sumOfPrimes x (nextPrime i) (n + (nextPrime i))

  sumBelow :: Integer -> Integer
  sumBelow n = sumOfPrimes n 0 0
