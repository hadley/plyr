library(plyr)
library(ggplot2)

# First need to create new variables that capture the number of years
# a player has played, and for each year, how far through their career
# they are.

# This is straightforward using the techniques we just learned
b2 <- ddply(baseball, "id", transform,
  cyear = year - min(year) + 1)  
b2 <- ddply(b2, "id", transform,
  career = (cyear - 1) / max(cyear))  

head(b2)

# Now what sort of model should we use?
bruth <- subset(b2, id == "ruthba01")
qplot(career, g, data = bruth, geom = "line")
qplot(career, g, data = b2, geom="boxplot", group = round_any(career, 0.05))

# Could we model that as two straight lines?
bruth$p <- (bruth$career - 0.5) * 100
mod <- lm(g ~ p + p:I(p > 0), data = bruth)
bruth$ghat <- predict(mod)
qplot(career, g, data = bruth, geom = "line") + 
  geom_line(aes(y = ghat), colour = "red")

# It doesn't look great, but it's a start
# Let's fit that model to every player
b2$p <- (b2$career - 0.5) * 100

models <- dlply(b2, "id", lm, formula = g ~ p + p:I(p > 0))
# Or a bit more explicitly
models <- dlply(b2, "id", function(df) lm(g ~ p + p:I(p > 0), data = df))

length(models)
onem <- models[[1]]
onem
summary(onem)

coefs <- coef(onem)
names(coefs) <- c("mid", "inc", "dec")
rsq <- summary(onem)$r.squared

get_coefs <- function(model) {
  coefs <- coef(model)
  names(coefs) <- c("mid", "inc", "dec")
  c(coefs, rsq = summary(model)$r.squared)
}

coefs <- ldply(models, get_coefs)

qplot(rsq, data = coefs, geom = "histogram", binwidth = 0.02)
qplot(mid, data = coefs, geom = "histogram", binwidth = 5)
qplot(inc, data = coefs, geom = "histogram", binwidth = 0.2)
qplot(dec, data = coefs, geom = "histogram", binwidth = 0.2)

qplot(rsq, inc, data=coefs)
qplot(dec, inc, data=coefs, colour=rsq)

# Maybe the problem is everyone doesn't peak in the middle of their careers
# Intead we could use a segmented regression

mod <- lm(g ~ p, data = bruth)
segmented(mod, seg.Z = ~ p, psi = list(p = 0.5))  
segmented(mod, seg.Z = ~ p, psi = list(p = c(0.3, 0.7)))


segmod <- dlply(b2, "id", function(df) {
  df <- as.data.frame(df)
  mod <- lm(g ~ p, data = df)
  segmented(mod, seg.Z = ~ p, psi = list(p = 0.5))  
})



library(segmented)
segmod <- llply(linmod, )
