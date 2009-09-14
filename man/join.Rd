\name{join}
\alias{join}
\title{Join...}
\usage{join(x, y, by=intersect(names(x), names(y)), type="left")}
\description{Join}
\details{Unlike merge, preserves the order of x no matter what join type is used.
If needed, rows from y will be added to the bottom.}
\examples{first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = T))
system.time(b3 <- join(baseball, first, by = "id"))}
