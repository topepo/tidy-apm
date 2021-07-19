# tidy-apm

This repo is a tidymodels companion for the 2013 book "Applied Predictive Modeling". 

The goal of these files is to approximate the analyses in the book with the more modern codebase. 

Some caveats:

 * R uses a different random number generator than it did <= 2013, so results won't be exactly the same. 

 * The packages used are much older than they were when _APM_ was written. For example, there have been over 30 releases of `caret` since the book was compiled. There will be differences in results for this reason. 

 * Some analyses in _APM_ haven't been written in tidymodels (yet) so the code here will be incomplete. In other cases, we may have slightly changed our recommendations for how to conduct some of the analyses. If this is the case, an annotation will be used to point this out. 

## Contributing

Feel free to contribute by 

 * Forking the repository to suggest a change, and/or
 * Starting an issue.

See the `contributing.md` file. 

## Code of Conduct

Please note that the tidy-apm project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
