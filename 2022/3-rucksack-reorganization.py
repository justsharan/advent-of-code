from functools import reduce

ABC = '.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

def find_unique_char(*strs: list[str]) -> str:
  return list(reduce(lambda a, b: set(a) & set(b), strs))[0]

part_1, part_2 = 0, 0
group_inventory = []

with open('data.txt', 'r') as file:
  for i, line in enumerate(file, 1):
    line = line.strip()
    comp1, comp2 = line[:len(line)//2], line[len(line)//2:]
    part_1 += ABC.index(find_unique_char(comp1, comp2))
    if i % 3 == 0:
      part_2 += ABC.index(find_unique_char(*group_inventory, line))
      group_inventory = []
    else:
      group_inventory.append(line)

print(part_1, part_2)