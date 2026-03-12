# Method for converting openaq_providers_list to data frame.

Method for converting openaq_providers_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_providers_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of providers as returned from list_providers.

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

A data frame class of the providers results, with the following columns:

- id:

  Numeric. The providers identifier.

- name:

  Character. The name of the provider.

- source_name:

  Factor. The name of the source.

- export_prefix:

  Character. Prefixed when exported to file store.

- datetime_added:

  POSIXct. Datetime when the provider was first added to OpenAQ.

- datetime_first:

  POSIXct. Datetime of the first measurement value from the provider.

- datetime_last:

  POSIXct. Datetime of the last measurement value from the provider.

- entities_id:

  Numeric. Entities identifier for the provider.

- parameter_ids:

  Character. A comma delimited list of parameters identifier measured by
  the provider.

The data frame also includes a `meta` attribute from the original
`openaq_providers_list`.

## Examples

``` r
if (FALSE) { # interactive()
providers <- list_providers(as_data_frame = FALSE)
as.data.frame(providers)
}
```
