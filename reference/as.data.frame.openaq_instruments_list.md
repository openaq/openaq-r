# Method for converting openaq_instruments_list to data frame.

Method for converting openaq_instruments_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_instruments_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of instruments as returned from list_instruments.

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

A data frame class of the instruments results, with the following
columns:

- id:

  Numeric. The instruments identifier.

- name:

  Character. The name of the measurement instrument.

- is_monitor:

  Logical. Indicates if the instrument is considered a reference
  monitor.

- manufacturer_id:

  Numeric. The manufacturers identifier for the manufacturer that makes
  the instrument.

- manufacturer_name:

  Factor. The name of manufacturer that makes the instrument.

The data frame also includes a `meta` attribute from the original
`openaq_instruments_list`.

## Examples

``` r
if (FALSE) { # interactive()
instruments <- list_instruments(as_data_frame = FALSE)
as.data.frame(instruments)
}
```
