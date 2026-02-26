# Method for converting openaq_parameters_list to data frame.

Method for converting openaq_parameters_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_parameters_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of parameters as returned from list_parameters.

- row.names:

  `NULL` or a character vector giving the row names for the data frame.
  Missing values are not allowed.

- optional:

  logical. If TRUE, setting row names and converting column names (to
  syntactic names: see make.names) is optional. Note that all of R's
  base package as.data.frame() methods use optional only for column
  names treatment, basically with the meaning of data.frame(\*,
  check.names = !optional). See also the make.names argument of the
  matrix method.

- ...:

  additional arguments to be passed to or from methods.

## Examples

``` r
if (FALSE) { # interactive()
parameters <- list_parameters()
as.data.frame(parameters)
}
```
