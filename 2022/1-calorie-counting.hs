import Data.List
import Data.List.Split
import System.IO

main = do
  file <- readFile "data.txt"
  let res = (reverse . sort . parseInput) file
  print $ head res
  print $ sum $ take 3 res

parseInput :: String -> [Int]
parseInput input = 
  fmap (sum . map read . splitOn "\n")
  (splitOn "\n\n" input)