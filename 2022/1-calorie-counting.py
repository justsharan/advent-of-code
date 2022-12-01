elves = [0]

with open('data.txt', 'r') as file:
  for line in file:
    if len(line) == 1:
      elves.append(0)
    else:
      elves[-1] += int(line.rstrip())

elves = sorted(elves, reverse=True)

print(elves[0])
print(sum(elves[0:3]))