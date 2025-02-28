import pandas as pd
import matplotlib.pyplot as plt

 
# reading the database
data = pd.read_csv("data/tips.csv")
 
# printing the top 10 rows
print(data.head(10))

 
 
# reading the database
data = pd.read_csv("data/tips.csv")
 
# Scatter plot with day against tip
plt.scatter(data['day'], data['tip'])
 
# Adding Title to the Plot
plt.title("Scatter Plot")
 
# Setting the X and Y labels
plt.xlabel('Day')
plt.ylabel('Tip')
 
plt.show()



##bar chart

# reading the database
data = pd.read_csv("data/tips.csv")
 
# Bar chart with day against tip
plt.bar(data['day'], data['tip'])
 
plt.title("Bar Chart")
 
# Setting the X and Y labels
plt.xlabel('Day')
plt.ylabel('Tip')
 
# Adding the legends
plt.show()