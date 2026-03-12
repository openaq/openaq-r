# Method for converting openaq_countries_list to data frame.

Method for converting openaq_countries_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_countries_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of countries as returned from list_countries.

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

## Value

A data frame class of the countries results, with the following columns:

- id:

  Numeric. The countries identifier

- name:

  Character. Then English name of the country.

- code:

  Character. The ISO-3166 Alpha 2 identifier for the country.

- datetime_first:

  POSIXct. The datetime of the first measurement value available in the
  country.

- datetime_last:

  POSIXct. The datetime of the last measurement value available in the
  country.

- parameter_ids:

  Character. A comma delimited list of parameter ids that are measured
  within the country.

- parameter_names:

  Character. a comma delimited list of parameter names and their units
  that are measured within the country.

The data frame also includes a `meta` attribute from the original
`openaq_countries_list`.

## Examples

``` r
if (FALSE) { # interactive()
countries <- list_countries(as_data_frame = FALSE)
as.data.frame(countries)
}
```
