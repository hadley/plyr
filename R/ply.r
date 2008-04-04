# Consistent syntax for subsetting/filtering; sorting; transforming; rotating?
# 
# ddply(data, .(cyl), sort_d, .())
# sort_d(data, vars)
# sort_a(data, margins)
# sort_l(data, f)?

# some automated way to report progress?

# List (l)
#   * recursive? 

# ddply()
# d_filter(data, .(cyl == 3))
# d_filter(data, function(row) row$cyl == 3)
# d_manip(data, .(vs * am, w2 = wt / mpg, am = NULL, w2 - mean(w2)))
# d_order(data, .(cyl, vs ^ 2))









# Replicate equivalent? -----------------
# Function to do replicates?
# borrow do notation from Daniel Kaplan?
# add as extra apply argument?
# llply(1:10, )


# aggregate - per column, returns df
# ave - split on all factors, single column, returns numeric
# by - per subset, returns list
# summary - no split, compute summaries per column
# bystats
# mApply
# summarize
# smean.sd 

# When try used, should spit out informative warnings about where error occured (unless .quiet = TRUE)


# Also want to be able to easy do things like:
# subset bulls which have at least five from a given country