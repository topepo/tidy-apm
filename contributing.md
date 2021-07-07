# Contributing

Thank you for your interest in contributing. This file contains what you need to know to help. 

- For __questions and discussions__ about tidymodels packages, modeling, and machine learning, please [post on RStudio Community](https://rstd.io/tidymodels-community).

If you have a __contribution__, please fork the repo and make a pull request (PR). If these terms are unfamiliar to you, take a look at [_Happy Git and GitHub for the useR_](https://happygitwithr.com/). It might be helpful to start a GitHub issue to discuss them before putting a lot of effort into it. 

If you make significant changes, include the phrase "I assign the copyright of this contribution to the authors listed in the `DESCRIPTION` file".

__If you find a bug__, please make an issue or pull request. Since all of the data and code are available, we will require minimal reprex (reproducible example). The goal of a reprex is to make it as easy as possible for me to recreate your problem so that we can fix it. If you've never heard of a reprex before, start by reading "[What is a reprex](https://github.com/tidyverse/reprex#what-is-a-reprex)", and follow the advice further down that page. 

Do not copy/paste large chunks of content from the book to the website. Do this sparingly. 

## Formatting

 * All code chunks have labels that are concise but descriptive. They should also make good figure names. Look at each chapter's chunk names; we keep a common prefix for each chapter. Names should use `-` to space words.

 * When possible, use figure chunk names that match to the figure number form the book (e.g., `chapter-02-fig-01`). The website does not have to reproduce all of the book figures. 

 * Figures should have transparent backgrounds and legends (if any) on top.

 * Please use US spellings (e.g. "color" instead of "colour"). 

 * Do not break lines within sentences or paragraphs. 

 * Adhere as best as possible to the [`tidyverse` style guide](https://style.tidyverse.org/). 

 * Please avoid adding new package dependencies. If that can't be avoided, add them to the DESCRIPTION file. 

## Getting started

You will need the packages used to build the website. The best way to do that is to install the `devtools` package and, from the project root directory, run:

```r
devtools::install()
​```

That this will probably install some development versions of packages. 

Note that some of the data sets are large and some models may take a very long time to run. 
