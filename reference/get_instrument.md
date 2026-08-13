# Get a single instrument from the instruments resource.

Get a single instrument from the instruments resource.

## Usage

``` r
get_instrument(
  instruments_id,
  as_data_frame = TRUE,
  dry_run = FALSE,
  api_key = NULL
)
```

## Arguments

- instruments_id:

  An integer representing the OpenAQ instruments_id.

- as_data_frame:

  A logical for toggling whether to return results as data frame or
  list, default is `TRUE`.

- dry_run:

  A logical for toggling a dry run of the request, default is `FALSE`.

- api_key:

  A valid OpenAQ API key string, default is `NULL`.

## Value

A data frame or a list of the results.

## Examples

``` r
if (FALSE) { # interactive()
instrument <- get_instrument(42)
}
```
