import random
from dfs2 import correct_layout, create_empty_grid, place_black_tiles_randomly, place_blue_tiles_adjacent_to_black, print_grid, x_size, y_size, num_black_tiles

def modify_and_flatten_grid():
    # Create and modify the grid
    grid = correct_layout(num_black_tiles)
    
    # Add a row at the bottom with all whites
    #grid.append(['.' for _ in range(y_size)])
    
    # Replace all blues ('e') with whites ('.')
    for i in range(x_size+1):
        for j in range(y_size):
            if grid[i][j] == 'e':
                grid[i][j] = '.'
    
    # Flatten the grid into a 1D array
    flattened_grid = [cell for row in grid for cell in row]
    
    return flattened_grid

flattened_grid_set = set()  # Use a set for uniqueness
unique_grid_count = 0
max_iterations = 100  # Set a limit for iterations to avoid infinite loops

while unique_grid_count < max_iterations:
    flattened_grid = modify_and_flatten_grid()
    
    # Convert flattened grid to a tuple for immutability and set compatibility
    flattened_grid_tuple = tuple(flattened_grid)
    
    if flattened_grid_tuple not in flattened_grid_set:
        flattened_grid_set.add(flattened_grid_tuple)
        unique_grid_count += 1
        print(f"Unique grids: {unique_grid_count}")
    else:
        break

print("Finished generating unique grids.")

# Select 5 random layouts from the unique grids
if len(flattened_grid_set) >= 5:
    random_selected_grids = random.sample(flattened_grid_set, 5)
    
    # Convert and print each selected grid in 2D form
    for index, flattened_grid in enumerate(random_selected_grids):
        # Reconstruct the 2D grid from the flattened version.
        grid = []
        for i in range(x_size + 1):  # +1 to account for the additional row
            row = flattened_grid[i * y_size : (i + 1) * y_size]
            grid.append(row)
        print(f"\nGrid {index + 1}:")
        print_grid(grid)
else:
    print("Not enough unique grids were generated.")
