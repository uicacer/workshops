# Exercise 1
p <- ggplot(anscombe_tidy, aes(x=x, y=y))

# 1a
p + geom_point()

# 1b
p + geom_point(color="orange", shape="triangle")

# 1c
p + geom_point(aes(color=set, shape=set))

# Exercise 2

p <- ggplot(anscombe_tidy, aes(x=x, y=y))
p + geom_point() + facet_wrap(~set)

# Exercise 3

ggplot(airline, aes(x=date, y=passengers)) +
  geom_line() +
  facet_wrap(~ month)

# Exercise 4

# 4a
ggplot(mtcars, aes(x=factor(cyl))) +
  geom_bar(aes(fill=factor(cyl)))

# 4b
ggplot(airline, aes(x=month, y=passengers)) +
  geom_bar(stat="summary", fun="mean")

# Exercise 5

ggplot(anscombe_tidy, aes(x, y)) +
  geom_point(color="red") +
  geom_smooth(method = "lm", se = FALSE, color="darkblue") +
  facet_wrap(~ set) +
  xlab("independent variable") + ylab("dependent variable") +
  ggtitle("Anscombe's Quartet")
