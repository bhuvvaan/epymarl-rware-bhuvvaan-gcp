import gym
import marl  # Import the module where the registration code is

env = gym.make("WarehouseEnv-v0")
print(env.observation_space)
print(env.action_space)