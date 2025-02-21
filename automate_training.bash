#!/bin/bash

# Define the Python file location
PYTHON_FILE="src/marl.py"

# New layout strings and IDs for each iteration
LAYOUT_STR_VALUES=(
".xx...x.xxx.x.x.........xxx.xx.x.x.x....x..x.....x......xxx...........xx.x.x..xx..............gg...."
"xxx..xxx....x.....x..xx.x...x.....x.x....x....xx.x...x.x.x.xx.......x.x.xx.x..................gg...."
"..x.xx.x.xx.x..x....x...x...x............xxxxxxx.......x.x.x...x...x.xx....x.x.x..............gg...."
"x.x.x.....x...xxx....xx.....x..x..x.xxxx.xx..x...........x.xx.x.x.x...x.x......x..............gg...."
".....x.x..x.xx.x....xxx...xxx.....xx....x.x....x.xxx......x...xx.xxx..x........x..............gg...."
".xx...xxx..x....x.x.............xx.xx..x..xx.x.....x..xx.xx.......xx...x.xx...xx..............gg...."
"..x...x...x.x.x..x.x...x.x.x..x.xxx....x..x...x.x.x...x..x....x.xx....xx....xx................gg...."
".x...xxxx....x........x.....xxxxxx.xx.xx...........xxx...xx....xx..x..x.....xx................gg...."
"x......xx.x.x...........x..x..x.xxx.x.xxx.xx......x..x....x..x....x......xx.xxxx..............gg...."
".xx.xx......x..x..xxx.x..xx..xx...x.....x...xx....xx..xx.xx.......xx....x.x...................gg...."
"xx...x..x....xxxx......x..x......x..xxx..x.x..x...xx...x.......x.x.xx..x.x...xx...............gg...."
"xx..x..x....x.....x......xxx.x.xx..x....x....x.x..x....x.x..........x.xxxxxxx.x...............gg...."
".........x..x.xxxx.x.xx.x.xx..x.x...........xxxxx...xx...x..x.....x.....x...x.xx..............gg...."
".xxxx.x..........x.xx..xx............xx.....x.xx...x.x..xxx.x..x.xx......x.x..xx..............gg...."
"...xxx.xx..x..........xx.x..xx..x.xx.xx..x..x..x.....xx.x.x.x.x.....x....x..x.................gg...."
".x..............x....x.xx...xxxx.xx....x.....x.x..x.xx.x...xx..xxxxx.xx......x................gg...."
".xxxxx.xx...............x.xx.xxx.xx..x........x.x.xxx.x..xx.....x.x.x.x.......................gg...."
"...xxxxx...xx......x....x......x..x.xxx...xx.xxx..x...x..x.x.....x.xxx...x....................gg...."
"x...x....x..x.xx.x...x.xx...x......x...xxx.xxxx...x...x....xx...........x..xxxx...............gg...."
"x...xx...x..x...x..xx.xxxxx.......x.x..x......x..x.xxx..x...x.x.x....x......x..x..............gg...."
)

LAYOUT_ID_VALUES=("71" "72" "73" "74" "75" "76" "77" "78" "79" "80" "81" "82" "83" "84" "85" "86" "87" "88" "89" "90")

# Loop 20 times
for i in {0..19}
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