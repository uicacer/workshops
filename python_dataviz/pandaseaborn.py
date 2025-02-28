# Import seaborn
import seaborn as sns
import pandas as pd
# Apply the default theme
sns.set_theme()

# Load an example dataset
tips = pd.read_csv('data/tips.csv')
animals = pd.read_csv('data/animals.csv')


#scatterplot
tips = sns.load_dataset("tips")
sns.scatterplot(data=tips, x="total_bill", y="tip")


#scatterplot with hue
sns.scatterplot(data=tips, x="total_bill", y="tip", hue="smoker")


# Create a visualization
sns.scatterplot(
    data=tips,
    x="total_bill", y="tip", col="time",
    hue="smoker", style="smoker", size="size",
)

sns.barplot(data=tips,
            x="day",
            y="tip")

sns.lineplot(data=animals,
            x = "year",
            y="hindfoot_length")