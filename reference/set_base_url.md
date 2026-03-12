# Sets base URL environment variable

A helper function to set the OPENAQR_BASE_URL environment variable. This
is to override the default URL for testing and custom instance of the
API. This function is generally not used by most users except in
extraordinary cases.

## Usage

``` r
set_base_url(base_url)
```

## Arguments

- base_url:

  A character string containing a URL.

## Value

No return value, called for side effects.

## Examples

``` r
set_base_url("https://example.com")
```
