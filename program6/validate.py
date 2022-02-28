from operator import ne
import sys
from time import sleep
from typing import List, Set, Tuple


def fail(x: int, y: int, current: str):
    print(f"Board is invalid, see position [{x},{y}], should be {current}")


def sucess():
    print("Board is valid")


# returns them in [up, right, left, down]
def getneighbor(x: int, y: int, grid: List[List[str]]):
    neighbors = [0] * 4
    neighbors[0] = grid[x - 1][y] if (x - 1) >= 0 else "#"
    neighbors[1] = grid[x][y + 1] if y + 1 < 10 else "#"
    neighbors[2] = grid[x][y - 1] if y - 1 >= 0 else "#"
    neighbors[3] = grid[x + 1][y] if x + 1 < 10 else "#"
    return neighbors


grid: List[List[str]] = []

if len(sys.argv) == 2:
    with open("test.txt") as file:
        for line in file:
            grid.append(line.split())
else:
    # Grab board from stdin
    for line in sys.stdin:
        grid.append(line.split())


# Check to see if A starts in top right
used: Set[Tuple[int, int]] = set()
current: str = "A"
x: int = 0
y: int = 0

for line in grid:
    print(line)
while True:
    # Check whether letter is correct
    if current != grid[x][y]:
        fail(x, y, current)
        break

    # Log position to prevent loops
    used.add((x, y))
    # Increment current
    current = chr(ord(current) + 1)
    if ord(current) > ord("Z"):
        current = "A"
    # Get neighbors
    neighbors = getneighbor(x, y, grid)

    # Check if the next element exists in the neighbors
    if current not in neighbors:
        # if the next element isn't found, check for empty neighbors
        if "." in neighbors:
            fail(x, y, current)
            break
        else:
            # check to see if all have been visited
            if (x - 1, y) in used or x - 1 < 0:
                if (x, y + 1) in used or y + 1 >= 10:
                    if (x, y - 1) in used or y - 1 < 0:
                        if (x + 1, y) in used or x + 1 >= 10:
                            sucess()
                            break
            fail(x, y, current)
            break

    direction = neighbors.index(current)

    if direction == 0:
        x = x - 1
    elif direction == 1:
        y = y + 1
    elif direction == 2:
        y = y - 1
    else:
        x = x + 1
