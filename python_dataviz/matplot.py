import numpy as np
import matplotlib.pyplot as plt

plt.plot([1, 2, 3, 4])
plt.ylabel('Numbers')
plt.show()

############
import matplotlib.pyplot as plt
# Data
x = [22,1,7,2,21,11,14,5]
y = [24,2,12,5,5,5,9,12]
plt.plot(x,y)

# Customize the plot (optional)
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Simple Line Plot')

# Display the plot
plt.savefig('matplotlib/Savefig/lineplot.png')
plt.show()