""" 
Oversimplified version of a path walker for grading the assignment

TODO:
 - Implement a recursive algorithm instead of a while true to seach all possible paths instead.
"""
import sys
import copy
from typing import List, Tuple


class bcolors:
    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKCYAN = "\033[96m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


def fail(x: int, y: int, current: str, grid, used):
    print(f"Board is invalid, see position [{x},{y}], should be {current}")
    for x, line in enumerate(grid):
        for y, ele in enumerate(line):
            if used[x][y]:
                print(bcolors.OKGREEN + f"{ele} ", end="")
            else:
                print(bcolors.WARNING + f"{ele} ", end="")
        print(bcolors.ENDC)


def sucess():
    print(bcolors.BOLD + bcolors.OKGREEN + "Board is valid" + bcolors.ENDC)


# returns them in [up, right, left, down]
def getneighbor(x: int, y: int, grid: List[List[str]]):
    neighbors = [0] * 4
    neighbors[0] = grid[x - 1][y] if x - 1 >= 0 else "#"
    neighbors[1] = grid[x][y + 1] if y + 1 < 10 else "#"
    neighbors[2] = grid[x][y - 1] if y - 1 >= 0 else "#"
    neighbors[3] = grid[x + 1][y] if x + 1 < 10 else "#"
    return neighbors


def move(direction: int, x: int, y: int) -> Tuple[int, int]:
    if direction == 0:
        x = x - 1
    elif direction == 1:
        y = y + 1
    elif direction == 2:
        y = y - 1
    elif direction == 3:
        x = x + 1
    return (x, y)


def check(current, grid, used, x, y):
    # Check whether letter is correct
    if current != grid[x][y]:
        print("manually review the board, possible mixed paths")
        fail(x, y, current, grid, used)
        return False

    # Log position to prevent loops
    used[x][y] = True

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
            fail(x, y, current, grid, used)
            return False
        else:
            # check to see if all have been visited
            bounds = getneighbor(x, y, used)
            if any([not x for x in bounds]):
                fail(x, y, current, grid, used)
                return False
            return True

    for idx, dir in enumerate(neighbors):
        if dir == current:
            nx, ny = move(idx, x, y)
            if not used[nx][ny]:  # If we've reached a new spot
                if check(current, grid, copy.deepcopy(used), nx, ny):
                    return True
    return False


grid: List[List[str]] = []
# Check to see if A starts in top right
used: List[List[bool]] = [[False for _ in range(10)] for _ in range(10)]
current: str = "A"
x: int = 0
y: int = 0

# Grab board from stdin
for line in sys.stdin:
    grid.append(line.split())

try:
    if check(current, grid, used, x, y):
        sucess()
    else:
        print("program failed, terminating...")
except KeyboardInterrupt:
    for line in grid:
        print(line)
