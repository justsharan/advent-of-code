import Data.List
import Data.List.Split
import System.IO

main = do
  file <- readFile "data.txt"
  let elfCalories = map (sum . map read . splitOn "\n") $ splitOn "\n\n" file
  let res = (reverse . sort) elfCalories
  print $ head res
  print $ sum $ take 3 res