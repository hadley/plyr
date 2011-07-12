library(ggplot2)

# Explore housing trends within Houston, 2000+
houston <- subset(read.csv("tx-house-sales.csv"), city == "Houston")

# Strong seasonal effects make it harder to see long term trend
qplot(date, avgprice, data = houston, geom = "line")
ggsave("tx-houston-price.pdf", width = 8, height = 4)
qplot(date, listings, data = houston, geom = "line")
qplot(date, sales, data = houston, geom = "line")
ggsave("tx-houston-sales.pdf", width = 8, height = 4)
qplot(date, sales / listings, data = houston, geom = "line")
qplot(date, onmarket, data = houston, geom = "line")
ggsave("tx-houston-onmarket.pdf", width = 8, height = 4)

# Good way of looking at seasonal variation is to display months on x axis
# and draw a separate line for each year.
avg <- stat_summary(aes(group = 1), fun.y = "mean", geom = "line", 
  colour = "red", size = 2, na.rm = TRUE)

qplot(month, avgprice, data = houston, geom = "line", group = year) + avg
ggsave("tx-houston-price-monthly.pdf", width = 8, height = 6)
qplot(month, listings, data = houston, geom = "line", group = year) + avg
qplot(month, sales, data = houston, geom = "line", group = year) + avg
qplot(month, sales / listings, data = houston, geom = "line", group = year) + avg
qplot(month, onmarket, data = houston, geom = "line", group = year) + avg

# So we'll remove the monthly averages with a linear model
# Here we're using the model as a tool - don't care about the coefficients
deseas <- function(var, month) {
  resid(lm(var ~ factor(month), na.action = "na.exclude")) + 
    mean(var, na.rm = TRUE)
}

houston <- transform(houston,
  avgprice_ds = deseas(avgprice, month),
  listings_ds = deseas(listings, month),
  sales_ds = deseas(sales, month), 
  onmarket_ds = deseas(onmarket, month)
)
# Always a good idea to check we did what we thought we did.
qplot(month, avgprice_ds, data = houston, geom = "line", group = year) + avg
ggsave("tx-houston-price-monthly-ds.pdf", width = 8, height = 6)

# Findings -------------------------------------------------------------------

# Average price took a big hit mig-late 2008
qplot(date, avgprice_ds, data = houston, geom = "line")
ggsave("tx-houston-price-ds.pdf", width = 8, height = 4)

# Number of sales started slowing mid 2006, big drop mid 2008
qplot(date, sales_ds, data = houston, geom = "line")
ggsave("tx-houston-sales-ds.pdf", width = 8, height = 4)

# Listings start slowing at the start of 2006.  Leading indicator?
qplot(date, listings_ds, data = houston, geom = "line")

# Steady decline in success - lower percent are sold each month, and 
# the average length of time listed increases
qplot(date, sales_ds / listings_ds, data = houston, geom = "line")
qplot(date, onmarket_ds, data = houston, geom = "line")
ggsave("tx-houston-onmarket-ds.pdf", width = 8, height = 4)

# Hypothesis: number of sales falling because people uncertain about
# buying a new house.  Avg price not falling as rapidly because people now
# overvalue their current home.  Eventually as house stays on market for
# longer (~6 months), they drop their price in an effort to sell.