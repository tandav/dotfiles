есть функция `get_random_number`  
которая даёт значения от 0 до 5  

Используя только ее, сделать функцию `get_random_extended`  
которая возвращает рандомное число от 0 до 7

```
0 1 2 3 4  ->  0 1 2 3 4 5 6
```

```python
import numpy as np
import matplotlib.pyplot as plt
```


```python
def get_random_number():
    '''0 1 2 3 4'''
    return np.random.randint(0, 5)
```


```python
def get_random_extended():
    '''0 1 2 3 4 5 6'''
    accuracy = 100
    random_float = 0
    for i in range(1, accuracy + 1):
        random_float += 7 / 5**i * get_random_number()
    return(int(random_float))
```


```python
r = [get_random_extended() for i in range(100000)]
```


```python
labels, counts = np.unique(r, return_counts=True)
plt.bar(labels, counts, align='center', facecolor=(0, 0, 1, 0.5), edgecolor='black')
plt.xticks(labels)
plt.show()
```


![output_5_0](https://user-images.githubusercontent.com/5549677/46347122-16afb800-c653-11e8-87ae-f3c2c701e114.png)

