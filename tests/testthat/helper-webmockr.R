local_webmockr <- function(env = parent.frame()) {
  webmockr::stub_registry_clear()
  webmockr::enable()
  withr::defer(webmockr::disable(), envir = env)
  withr::defer(webmockr::stub_registry_clear(), envir = env)
}