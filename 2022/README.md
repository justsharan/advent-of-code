# Advent of Code 2022

I've decided to attempt this year's AOC challenges in both Python and Haskell. Python, because I'd like to quickly hack together a working solution to try and get on the leaderboard. Then, I go through and try to implement a similar solution in Haskell in an attempt to become more proficient with the language.

## Table of Contents

1. [Day 1: Calorie Counting](#day-1-calorie-counting)
    1. [Python Solution](#python-solution)
    2. [Haskell Solution](#haskell-solution)
2. [Day 2: Rock Paper Scissors](#day-2-rock-paper-scissors)
    1. [Python Solution](#python-solution-1)
    2. [Haskell Solution](#haskell-solution-1)

## Day 1: Calorie Counting

### Python Solution

I start out by defining an `elves` variable that will contain a bunch of integers. It will contain the total amount of calories for each elf.

As I iterate through the array, I will sum up the amount of calories of the current elf I'm on by directly adding to the last (`elves[-1]`) element of the array. Once I reach a newline, i.e. it's time to start counting the calories of a new elf, I'll append a 0 to the array and add to it starting from the next iteration of the for loop.

In the end, I sort `elves` by decreasing order, so the highest calorie elf will be first in the array, second highest will be second, etc. For part 1, I return `elves[0]`, which represents the elf with the highest calorie count. For part 2, I sum up the first three elements of `elves`, or `elves[0:3]`.

### Haskell Solution

First, I read the file into the `file` variable. Then, I split it by `\n\n` so It's a list of strings, where each string is all the food of a particular elf, separated by newlines. Then, I split each string in the list by newlines, read them into ints, and sum them up. Now, I'm left with the total calories of all elves in `[Int]`. Then, I sort it (by ascending order, default) and reverse the order. For part 1, I return the first element using `head`. For part 2, I `take` the first 3 elements and sum them up.

## Day 2: Rock Paper Scissors

### Python Solution

This problem has a lot of moving pieces, so I decided to tackle it using a reductionist approach. Solve really simple related problems first. I identified three main things I thought I'll need to be able to do in order to solve the question, and wrote pure functions to accomplish these tasks. These are the tasks I identified:

* Standardize inputs into a common format (left moves are provided as ABC, right moves are provided as XYZ)

Initially, I thought about converting them to RPS (R = Rock, P = Paper, S = Scissors), but that would just make it too cumbersome. Instead, I chose to convert them to integers (1 = Rock, 2 = Paper, 3 = Scissors), as these are also the scores for them. So when it comes time to calculate the scores for pairs of moves, I can just add the right value rather than mapping them to integers separately.

```py
def standardize(vals: list[str]) -> tuple[int, int]:
  return ('ABC'.index(vals[0]) + 1, 'XYZ'.index(vals[1]) + 1)
```

It takes a list of choices `['A', 'Z']`, for example, and outputs a tuple of ints `(1, 3)`. It does this by getting the index of it in the string `'ABC'` or `'XYZ'` and adding 1 to it, so `'A'` would be at the 0th position in '`ABC'`, and 0 + 1 = 1, which is our identifier for Rock.

* Check for wins, given two moves. This should be easy enough, as the problem itself gave us the possible winning combinations:

> Rock Paper Scissors is a game between two players. Each game contains many rounds; in each round, the players each simultaneously choose one of Rock, Paper, or Scissors using a hand shape. Then, a winner for that round is selected: Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both players choose the same shape, the round instead ends in a draw.

I initially wrote this function:

```py
def check_win(left: int, right: int) -> str:
  if left == right:
    return 'draw'
  if (right == 1 and left == 3) \
  or (right == 3 and left == 2) \
  or (right == 2 and left == 1):
    return 'win'
  else:
    return 'lose'
```

As you can see, it just implements the winning combinations verbatim. However, since we're just comparing numbers, I saw a simpler solution.

In the first comparison, `right - left = -2`. In the other two comparisons, `right - left = 1`. So, we should be able to identify the winning combinations just by checking the value of `right - left`. Thus, I was able to reduce it to this:

```py
def check_win(left: int, right: int) -> str:
  return 'draw' if right-left == 0 else 'win' if right-left in [-2, 1] else 'lose'
```

After testing a couple combinations, both functions gave me the same results, so I settled on this version of the function.

* Calculate the score, given two moves. The problem gave us this information:

> The score for a single round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).

In terms of code:

```py
res = ['lose', 'draw', 'win']
scores = [0, 3, 6]
```

And, we've already standardized the two inputs to 1-2-3 (for rock, paper, and scissors), so we can just use that to get the score for our shape, and add it to the result's score.

```py
def score(left: int, right: int) -> int:
  return right + scores[res.index(check_win(left, right))]
```

I put the whole thing together. I read the file line by line and standardize the inputs first, and then calculate the score for each line and append it to my total score for part 1. For part 2, I find the appropriate move I need to make by iterating through all the possible choices `range(1,4)` (a.k.a. `[1, 2, 3]`) and figuring which combination of moves gets me the result I want.

As I find the winning combo for each line (stored in `find_choice`), I `score()` the moves and append it to my part 2 score. Finally, I print both scores to stdout.

### Haskell Solution

Too lazy to type this out, plus I'm also working to condense this code.
