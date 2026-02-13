# Vignettes

The vignettes in this package are pre-compiled because they demonstrate
functionality that requires OpenAQ API authentication.

## Building Vignettes

To rebuild vignettes from source:

1. Ensure you have an OpenAQ API key set as `OPENAQ_API_KEY`
2. Run: `Rscript vignettes/precompile.R`
3. Commit the updated `.Rmd` files

The `.Rmd.orig` files contain the source code, and the `.Rmd` files
are the pre-compiled versions included in the package.
