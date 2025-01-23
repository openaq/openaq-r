# openaq R client <img src="https://github.com/user-attachments/assets/3b75f3f7-f570-422f-99dd-17c7835d5594" align="right" alt="openaq hex logo"  style="height: 140px;"/>

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![R-CMD-check](https://github.com/openaq/openaq-r/actions/workflows/check.yaml/badge.svg)](https://github.com/openaq/openaq-r/actions/workflows/check.yaml)
[![Codecov test coverage](https://codecov.io/gh/openaq/openaq-r/graph/badge.svg)](https://app.codecov.io/gh/openaq/openaq-r)

An R package for interacting with the OpenAQ API.

## Installation

The package is available to install through Github. Use the `install_github` command from [remotes](https://cran.r-project.org/web/packages/remotes/index.html) package.

```r
library("remotes")

install_github("openaq/openaq-r")
```

## Quickstart

For a full walkthrough on using openaq we recommend that you read through the
“[Introduction to
openaq](https://openaq.github.io/openaq-r/articles/openaq.html)”
vignette (`vignette("openaq")`). The following guide is a quick and minimal
example to get you started.

1. Register for an account at
    [https://explore.openaq.org/register](https://explore.openaq.org/register).
2. Find your API key in the user [account page](https://explore.openaq.org/account).
3. Save your API key as the `OPENAQ_API_KEY` [environment
    variable](https://rstats.wtf/r-startup.html#renviron) . e.g.
    `OPENAQ_API_KEY=yourkey` in `.Renviron`. See `help(openaq)` for other ways to use and access your API key.

Now we can query OpenAQ for air quality monitoring locations. For this example we will query locations that measure PM<sub>2.5</sub> near (with 10km) Antananarivo, Madagascar (-18.90848, 47.53751)

```r
library(openaq)

locations <- list_locations(
    parameters_id = 2, 
    coordinates = list(-18.90848, 47.53751),
    radius = 10000
)
```

This returns a data frame that will look something like:


|    id|name         |is_mobile |is_monitor |timezone            | countries_id|country_name |country_iso |  latitude| longitude|datetime_first      |datetime_last       |owner_name                        | providers_id|provider_name |
|-----:|:------------|:------------|:----------|:-------------------|------------:|:------------|:-----------|---------:|---------:|:-------------------|:-------------------|:---------------------------------|------------:|:-------------|
| 41726|Antananarivo |FALSE       |TRUE       |Indian/Antananarivo |          182|Madagascar   |MG          | -18.90848|  47.53751|2020-12-22 07:00:00 |2025-01-17 20:00:00 |Unknown Governmental Organization |          119|AirNow        |


## Development

Contributions are welcome. See the [contribution guide](CONTRIBUTING.md) for more information.
