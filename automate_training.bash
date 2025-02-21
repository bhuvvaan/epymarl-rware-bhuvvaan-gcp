#!/bin/bash

# Define the Python file location
PYTHON_FILE="src/marl.py"

# New layout strings and IDs for each iteration
LAYOUT_STR_VALUES=(
"x.x..x.x.x..x......x..xx...x.x......xx..xx....x...x..x.x..x.x.xx..x.x......x..xx..............gg...."
"x..xx.x.x..x.x............x..xxx..xx.x..x.x.x....x.....xxx.......xx..xxx.x.....x..............gg...."
"...x.xx...xx....x.xx.xxx.x...x.......x..........x..xxx.x..xx.........xx..x.xxx.x..............gg...."
"..x...xx.xx...xx...xx...x..xxx............xx.x..x.x..x.x..x...x...x...xxx....x.x..............gg...."
"x...x....x....x....x.x.x...xx.xx....xx..x.x.......x...x.xxx...xxx.....x....xx.xx..............gg...."
"xxx.........x.xxx.x....xxxx...x.xx...xx......x.....x.x.x...x.xxx....xxx.......................gg...."
"x..xxxxx..x......x.....xx...x..x...x..x..xxxx.x.......x.x.x..x.xx.....x.....x..x..............gg...."
".xxx.....x...x.x...x..x.xx.x...x...x..x....xxx...x..xx.x.x..x.......xx.xx..x..................gg...."
)

LAYOUT_ID_VALUES=("91" "92" "93" "94" "95" "96" "97" "98")

# Loop 20 times
for i in {0..7}
do
    echo "Iteration $i"

    # Pick layout string and ID based on iteration index
    LAYOUT_STR=${LAYOUT_STR_VALUES[$((i % ${#LAYOUT_STR_VALUES[@]}))]}
    LAYOUT_ID=${LAYOUT_ID_VALUES[$((i % ${#LAYOUT_ID_VALUES[@]}))]}

    echo "Updating src/marl.py with layout ID: $LAYOUT_ID"

    # Debug: Check before changes
    grep "layout_str =" "$PYTHON_FILE"
    grep "layout_id =" "$PYTHON_FILE"

    # Modify the Python file to update layout_str and layout_id
    # Modify the Python file to update layout_str and layout_id
    sed -i "s/^layout_str = .*/layout_str = \"$LAYOUT_STR\"/" "$PYTHON_FILE"
    sed -i "s/^layout_id = .*/layout_id = \"$LAYOUT_ID\"/" "$PYTHON_FILE"

    # Debug: Check after changes
    grep "layout_str =" "$PYTHON_FILE"
    grep "layout_id =" "$PYTHON_FILE"

    # Run the script in the background with nohup
    nohup python src/main.py --config=mappo --env-config=gymma with env_args.time_limit=500 env_args.key="marl:rware-tiny-4ag-v2-$LAYOUT_ID" save_model=True common_reward=True &

    # Wait for a few seconds before the next iteration (optional)
    sleep 15
done

echo "Completed 20 iterations."