# Using EpyMARL for RWARE

To register a custom RWARE environment, go to MARL file and give the layout of the custom environment. To register the environment just run marl.py file.

To train a RL algorithm on the environment use the command.

```shell
python src/main.py --config=qmix --env-config=gymma with env_args.time_limit=500 env_args.key="marl:your-env-name" save_model=True
```

To visualize results, run from the root folder.

```shell
 python3 plot_results.py --path ./results/sacred/qmix/your-env-name --metric test_return_mean --save_dir ./plots
```

For readme of EpyMARL, visit [https://github.com/uoe-agents/epymarl/blob/main/README.md](url)
 
