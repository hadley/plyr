library(ggplot2)
options(na.action = "na.exclude")

# Helper functions ----------------------------------------------------------
deseas <- function(var, month) {
  resid(lm(var ~ factor(month))) + mean(var, na.rm = TRUE)
}

# Explore multiple cities ----------------------------------------------------
tx <- read.csv("tx-house-sales.csv")

# We know from our exploration of Houston data that many of the series
# have strong seasonal components.  It's a good idea to check that's true for 
# all cities.  We'll start with sales.
qplot(date, sales, data = tx, geom = "line", group = city)
ggsave("tx-all-sales.pdf", width = 8, height = 4)

# Hmmmm.  Problem!  There's a large variation in the number of sales between
# cities.  The seasonal pattern does look pretty constant though.

# First possible solution, just remove the seasonal effect as we did for a 
# single city, but applied to multiple cities (using model as a tool)  
tx <- ddply(tx, "city", transform, 
  sales_ds = deseas(sales, month))
qplot(date, sales_ds, data = tx, geom = "line", group = city)
ggsave("tx-all-sales-ds.pdf", width = 8, height = 4)

# It works, but we don't gain much insight into what's going on.
# Let's fit the models, and actually look at them this time
models <- dlply(tx, "city", function(df) 
  lm(sales ~ factor(month), data = df))

models[[1]]
coef(models[[1]])

# To extract the coefficients, we want to go from a list to data frame
# Notice how plyr remembers the city names that we originally broke the
# models up by.
ldply(models, coef)

# Two problems with the model:
#   * Coefficients aren't comparable, because of varying sizes
#     Solution: log-transform to convert to ratios
#   * Coefficients not in useful form for plotting
#     Solution: create data frame ourselves
qplot(date, log10(sales), data = tx, geom = "line", group = city)
ggsave("tx-all-sales-log.pdf", width = 8, height = 6)

models2 <- dlply(tx, "city", function(df) 
  lm(log10(sales) ~ factor(month), data = df))
coef2 <- ldply(models2, function(mod) {
  data.frame(
    month = 1:12, 
    effect = c(0, coef(mod)[-1]), 
    intercept = coef(mod)[1])
})

# Pretty consistent pattern, although there are few outliers
qplot(month, effect, data = coef2, group = city, geom = "line")
ggsave("tx-all-month.pdf", width = 8, height = 6)
# More interpretable if we back-transform - can now interpret as ratios
qplot(month, 10 ^ effect, data = coef2, group = city, geom = "line")
ggsave("tx-all-month-back.pdf", width = 8, height = 6)
# What are the outliers?
qplot(month, 10 ^ effect, data = coef2, geom = "line") + facet_wrap(~ city)
ggsave("tx-all-month-back-city.pdf", width = 8, height = 6)
# They are small cities. Hmmmmm

# Have a look at the distributions
qplot(effect, data = coef2, binwidth = 0.05) + facet_wrap(~ month)

# Single model ----------------------------------------------------

mod <- lm(log10(sales) ~ city + factor(month), data = tx)

tx$sales2 <- 10 ^ resid(mod)
qplot(date, sales2, data = tx, geom = "line", group = city)
ggsave("tx-all-single.pdf", width = 8, height = 6)
# Now we're starting to get somewhere!  Can see general pattern, although
# there are a few outliers.  Look at cities individually to identify:
last_plot() + facet_wrap(~ city)
ggsave("tx-all-single-city.pdf", width = 8, height = 6)
# Some problem cities:
#   * Bryan-College station: has different seasonal pattern (Texas A&M?)
#   * Similarly with San Marcos (a lot of missing data)
#   * Palestine: massive increase beginning 2007

# Can resolve seasonal problems by fitting separate seasonal pattern to each
# city (Challenge: how is this different to the indivudal models we fit 
# before?)  But probably better to use more sophisticated model (e.g. mixed 
# effects) model.
mod2 <- lm(log10(sales) ~ city:factor(month), data = tx)
tx$sales3 <- 10 ^ resid(mod2)
qplot(date, sales3, data = tx, geom = "line") + facet_wrap(~ city)

# Further exploration
qplot(date, sales2, data = tx, geom = "line", group = city, alpha = I(0.2))
last_plot() + geom_smooth(aes(group = 1))

# Could smooth individual cities - again just using model as a tool
library(mgcv)
smooth <- function(var, date) {
  predict(gam(var ~ s(date)))
}
tx <- ddply(tx, "city", transform, 
  sales2_sm = smooth(sales2, date))
qplot(date, sales2_sm, data = tx, geom = "line", group = city)

# Another approach -----------------------------------------------------------

# Essence of most cities is seasonal term plus long term smooth trend.  We
# could fit this model to each city, and then look for model which don't
# fit well.

library(splines)
models3 <- dlply(tx, "city", function(df) {
  lm(log10(sales) ~ factor(month) + ns(date, 3), data = df)
})

# Extract rsquared from each model
rsq <- function(mod) c(rsq = summary(mod)$r.squared)
quality <- ldply(models3, rsq) 
qplot(rsq, city, data = quality)
ggsave("tx-all-quality.pdf", width = 6, height = 6)

qplot(rsq, reorder(city, rsq), data = quality)
ggsave("tx-all-quality-ordered.pdf", width = 6, height = 6)

quality$poor <- quality$rsq < 0.7
tx2 <- merge(tx, quality, by = "city")

# The cities don't look particularly differnet 
qplot(date, log10(sales), data = tx2, geom = "line", colour = poor) + 
  facet_wrap(~ city) + opts(legend.position = "none")
ggsave("tx-all-quality-col.pdf", width = 8, height = 6)

# But we should probably look at the residuals & predictions
mfit <- ldply(models3, function(mod) {
  data.frame(resid = resid(mod), pred = predict(mod))
})
tx2 <- cbind(tx2, mfit[, -1])
qplot(date, pred, data = tx2, geom = "line", colour = poor) + 
  facet_wrap(~ city) + opts(legend.position = "none")
ggsave("tx-all-poor-quality-col-pred.pdf", width = 8, height = 6)
qplot(date, resid, data = tx2, geom = "line", colour = poor) + 
  facet_wrap(~ city) + opts(legend.position = "none")
ggsave("tx-all-poor-quality-col-resid.pdf", width = 8, height = 6)
