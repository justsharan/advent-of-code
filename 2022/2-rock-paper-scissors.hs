import System.IO

main = do
  file <- readFile "data.txt"
  let info = lines files
  print $ sum $ map (score . parseLine) info
  print $ sum $ map (score . decideMove . parseResultLine) info

data Item = Rock | Paper | Scissors deriving (Eq, Show)
data Result = Win | Draw | Lose deriving (Eq, Show)

parseLine :: String -> (Item, Item)
parseLine line = (standardize $ line !! 0, standardize $ line !! 2)

standardize :: Char -> Item
standardize item
  | item `elem` "AX" = Rock
  | item `elem` "BY" = Paper
  | otherwise        = Scissors

parseResultLine :: String -> (Item, Result)
parseResultLine line = (standardize $ line !! 0, standardizeRes $ line !! 2)

standardizeRes :: Char -> Result
standardizeRes 'X' = Lose
standardizeRes 'Y' = Draw
standardizeRes 'Z' = Win

checkWin :: Item -> Item -> Result
checkWin Scissors Rock  = Win
checkWin Paper Scissors = Win
checkWin Rock Paper     = Win
checkWin first second
  | first == second     = Draw
  | otherwise           = Lose

scoreUser :: Item -> Int
scoreUser Rock = 1
scoreUser Paper = 2
scoreUser Scissors = 3

scoreResult :: Result -> Int
scoreResult Win = 6
scoreResult Draw = 3
scoreResult Lose = 0

score :: (Item, Item) -> Int
score (left, right) = (scoreUser right) + (scoreResult $ checkWin left right)

decideMove :: (Item, Result) -> (Item, Item)
decideMove (left, res) =
  (left, head (filter (\right -> checkWin left right == res)
    [Rock, Paper, Scissors]))