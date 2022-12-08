```py
import matplotlib.pyplot as plt
import numpy as np

t = np.linspace(0, 10, 4000)
y = np.sin(2*np.pi*3*t)

plt.plot(t, y, 'k')
# plt.show()
plt.axis('off')
plt.savefig('sine.png', transparent=True)
```

![44166205-7669f800-a0d3-11e8-9744-7b1d22a0feee.png (876×690)](https://user-images.githubusercontent.com/5549677/44166205-7669f800-a0d3-11e8-9744-7b1d22a0feee.png)
