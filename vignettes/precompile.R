old_wd <- getwd()

setwd("vignettes/")
# Pre-compile vignettes that depend on API key
knitr::knit("querying-rollups.Rmd.orig", output = "querying-rollups.Rmd")
knitr::knit("querying-measurements.Rmd.orig", output = "querying-measurements.Rmd")
knitr::knit("plotting.Rmd.orig", output = "plotting.Rmd")
knitr::knit("geospatial-queries.Rmd.orig", output = "geospatial-queries.Rmd")
knitr::knit("openaq.Rmd.orig", output = "openaq.Rmd")


setwd(old_wd)
