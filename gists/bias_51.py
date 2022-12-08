import random
import collections
from pipe import ProcessMap, Reduce # github.com/tandav/pipe
import operator
import tqdm

def biased_coin(bias=0.51): return random.random() < bias


def count_brokes(n_simulations):
    brokes = collections.Counter()
    
    for _ in tqdm.tqdm(range(n_simulations)):
        alice = 100
        bob   = 100

        while alice > 0 and bob > 0:
            if biased_coin():
                alice += 1
                bob -= 1
            else:
                alice -= 1
                bob += 1

        if alice == 0: brokes['alice'] += 1
        else: brokes['bob'] += 1
        
    return brokes

if __name__ == '__main__':

    n_simulations = 5_000_000
    n_threads = 16
    simulations_per_thread = n_simulations // n_threads
    print(f'{n_simulations=} {n_threads=} {simulations_per_thread=}')
    brokes = n_threads * [simulations_per_thread] | ProcessMap(count_brokes) | Reduce(operator.add)

    print('brokes:', brokes)
    n = sum(brokes.values())
    print('brokes: alice:', brokes['alice'] / n)
    print('brokes: bob:  ', brokes['bob' ]  / n)
    print('='*70)
