
injuries <- vroom::vroom("neiss/injuries.tsv.gz")
products <- vroom::vroom("neiss/products.tsv")
population <- vroom::vroom("neiss/population.tsv")

# toilets
selected <- injuries %>% filter(prod_code == 649)
dim(selected)

# weighted by weight (0 .. 1)

# location
# count by location and weight by weight
selected %>% count(location, wt = weight, sort = TRUE)


# body part
selected %>% count(body_part, wt = weight, sort = TRUE)

# diagnosis
selected %>% count(diag, wt = weight, sort = TRUE)

summary <- selected %>% count(age, sex, wt = weight)
summary


summary %>%
  ggplot(aes(age, n, colour = sex)) +
  geom_line() +
  labs(y = "Estimated number of injuries")

# count products n
summary <- selected %>%
  count(age, sex, wt = weight)

population <- vroom::vroom("neiss/population.tsv")

summary <- selected %>%
  count(age, sex, wt = weight) %>%
  left_join(population, by = c("age", "sex")) %>%
  mutate(rate = n / population * 1e4)


summary %>%
  ggplot(aes(age, rate, colour = sex)) +
  geom_line(na.rm = TRUE) +
  labs(y = "Injuries per 10,000 people")

# have a look at random sample of narratives.
# we do this for product number 649 want a shiny
# app to do this for other products.
selected %>%
  sample_n(10) %>%
  pull(narrative)


# fct_infreq(f)
# changes the order of the factor levels depending on their
# frequency... the most frequest gets the highest level
f <- factor(c("b", "b", "a", "c", "c", "c"))
fct_infreq(f)


x <- factor(rep(LETTERS[1:9], times = c(40, 10, 5, 27, 1, 1, 1, 1, 1)))
# this lists A though to I
x %>% table()

# this lists the top 3 then a further category called other
x %>% fct_lump_n(3) %>% table()



vv <- injuries %>% mutate(diag = fct_lump(fct_infreq(diag), n = 5))
# five values
vv$diag %>% table()


xx <- injuries %>%
  # replace diag variable with
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))
xx

# make a function
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}
