# Method for converting openaq_licenses_list to data frame.

Method for converting openaq_licenses_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_licenses_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of licenses as returned from list_licenses.

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

A data frame class of the licenses results, with the following columns:

- id:

  Numeric. The licenses identifier.

- name:

  Character. The license name.

- commercial_use_allowed:

  Logical. Indicates whether commerical use is allowed under the license
  terms.

- attribution_required:

  Logical. Indicates whether attribution is required under the license
  terms.

- share_alike_required:

  Logical. Indicates whether share-alike is required under the license
  terms.

- modification_allowed:

  Logical. Indicates whether modification is allowed under the license
  terms.

- redistribution_allowed:

  Logical. Indicates whether redistribution is allowed under the license
  terms.

- source_url:

  String. The URL of the license as listed by the upstream source.

The data frame also includes a `meta` attribute from the original
`openaq_licenses_list`.

## Examples

``` r
if (FALSE) { # interactive()
licenses <- list_licenses(as_data_frame = FALSE)
as.data.frame(licenses)
}
```
