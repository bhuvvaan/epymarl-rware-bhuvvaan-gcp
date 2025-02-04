import gym

def list_registered_envs():
    # Get all registered environments
    envs = gym.envs.registry.keys()
    
    # Print each environment's ID
    for env in sorted(envs):
        print(env)

if __name__ == "__main__":
    list_registered_envs()