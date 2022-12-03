def standardize(vals: list[str]) -> tuple[int, int]:
  return ('ABC'.index(vals[0]) + 1, 'XYZ'.index(vals[1]) + 1)

def check_win(left: int, right: int) -> str:
  return 'draw' if right-left == 0 else 'win' if right-left in [-2, 1] else 'lose'

res, scores = ['lose', 'draw', 'win'], [0, 3, 6]

def score(left: int, right: int) -> int:
  return right + scores[res.index(check_win(left, right))]

part_1, part_2 = 0, 0

with open('data.txt', 'r') as file:
  for line in file:
    left, right = standardize(line.strip().split(' '))
    part_1 += score(left, right)
    find_choice = next(filter(lambda x: check_win(left, x) == res[right-1], range(1,4)))
    part_2 += score(left, find_choice)

print(part_1, part_2)