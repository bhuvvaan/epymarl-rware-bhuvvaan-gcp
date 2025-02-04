import random

# Define grid dimensions
x_size = 8   # Number of rows
y_size = 10  # Number of columns
num_black_tiles = 28  # Fixed number of black tiles

def create_empty_grid(x_size, y_size):
    """Create an empty grid filled with white tiles ('.')."""
    return [['.' for _ in range(y_size)] for _ in range(x_size)]

def print_grid(grid):
    """Print the grid without any additional characters or highlighting."""
    for row in grid:
        print(''.join(row))
    print()

def place_black_tiles_randomly(grid, num_black_tiles):
    """Randomly place a fixed number of black tiles ('@') on the grid."""
    placed = 0
    while placed < num_black_tiles:
        i = random.randint(0, x_size - 1)
        j = random.randint(0, y_size - 1)
        if grid[i][j] == '.':
            grid[i][j] = '@'
            placed += 1

def place_blue_tiles_adjacent_to_black(grid):
    """
    For each black tile, attempt to place a blue tile ('e') in one of its adjacent cells.
    Each black tile gets one blue tile (if an adjacent white cell is available).
    If any black tile cannot have a blue tile placed next to it, restart the whole process.
    """
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    for i in range(x_size):
        for j in range(y_size):
            if grid[i][j] == '@':
                random.shuffle(directions)
                placed = False
                for dx, dy in directions:
                    ni, nj = i + dx, j + dy
                    if 0 <= ni < x_size and 0 <= nj < y_size and grid[ni][nj] == '.':
                        grid[ni][nj] = 'e'
                        placed = True
                        break  # Place only one blue tile per black tile.
                if not placed:
                    #print(f"Error: Could not place a blue tile adjacent to black tile at ({i}, {j}). Restarting...")
                    return False  # Indicate failure and restart the process
    return True  # Return True if all black tiles have adjacent blue tiles

def add_bottom_row(grid):
    """Adds a row at the bottom with the first tile as 'e' and the rest as '.'. 
    This is to ensure that the blue tiles are connected to Goal"""
    new_row = ['e'] + ['.'] * (y_size - 1)  # First tile is 'e', others are '.'
    grid.append(new_row)  # Add new row to the grid


def validate_blue_connectivity(grid):
    """
    Check that all blue tiles ('e') are connected, treating black tiles ('@') as barriers.
    We use a DFS starting from the first blue tile found.
    """
    visited = [[False for _ in range(y_size)] for _ in range(x_size)]
    
    def dfs(i, j):
        if i < 0 or i >= x_size or j < 0 or j >= y_size:
            return
        if grid[i][j] == '@' or visited[i][j]:
            return
        visited[i][j] = True
        for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
            dfs(i + dx, j + dy)
    
    # Find the first blue tile to start DFS.
    start_found = False
    for i in range(x_size):
        for j in range(y_size):
            if grid[i][j] == 'e':
                dfs(i, j)
                start_found = True
                break
        if start_found:
            break

    # If no blue tile is found, connectivity fails.
    if not start_found:
        return False

    # Ensure every blue tile was visited by DFS.
    for i in range(x_size):
        for j in range(y_size):
            if grid[i][j] == 'e' and not visited[i][j]:
                return False
    return True


def correct_layout(num_black_tiles):
    """
    Repeatedly generate the grid until the blue tiles ('e') are fully connected.
    The process:
      1. Create an empty grid.
      2. Place fixed black tiles randomly.
      3. Place blue tiles adjacent to the black tiles.
      4. Check connectivity of blue tiles.
    """
    while True:
        grid = create_empty_grid(x_size, y_size)
        place_black_tiles_randomly(grid, num_black_tiles)
        if not place_blue_tiles_adjacent_to_black(grid):
            #print("Restarting grid generation due to failed blue tile placement.")
            continue  # Restart the whole process if placing blue tiles failed
        add_bottom_row(grid)
        if validate_blue_connectivity(grid):
            return grid
        #print("Re-validating and adjusting layout...")


# Main program
grid = correct_layout(num_black_tiles)
print("Final Grid Layout:")
print_grid(grid)  # Modify or remove w_rows as needed.