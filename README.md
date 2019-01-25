# helixvis: Visualize alpha-helical peptide sequences

[![Travis Build Status](https://travis-ci.org/rrrlw/helixvis.svg?branch=master)](https://travis-ci.org/rrrlw/helixvis)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rrrlw/helixvis?branch=master&svg=true)](https://ci.appveyor.com/project/rrrlw/helixvis)
[![Coverage Status](https://img.shields.io/codecov/c/github/rrrlw/helixvis/master.svg)](https://codecov.io/github/rrrlw/helixvis?branch=master)

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![CRAN version](http://www.r-pkg.org/badges/version/helixvis)](https://CRAN.R-project.org/package=helixvis)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/helixvis)](https://CRAN.R-project.org/package=helixvis)

[![JOSS DOI](https://joss.theoj.org/papers/10.21105/joss.01008/status.svg)](https://doi.org/10.21105/joss.01008)
[![Zenodo DOI](https://zenodo.org/badge/134013329.svg)](https://zenodo.org/badge/latestdoi/134013329)

## Purpose

helixvis can be used to create publication-quality, 2-dimensional visualizations of alpha-helical peptide sequences.
Specifically, this package allows the user to programmatically generate helical wheels and wenxiang diagrams to provide a bird's eye, top-down view of alpha-helical oligopeptides.
Although other tools exist to complete this task, they generally provide a graphical user interface for manual input of peptide sequences, without allowing for programmatic creation and customization of visualizations.
Programmatic generation of helical wheels in open source R provides multiple benefits, including:

* quick and easy incorporation of wheels into Rmarkdown documents
* rapid generation of many peptides (e.g. all the elements of a peptide database) without manual steps
* programmatic customization of visualizations using ggplot2
* reproducibility: practically zero manual steps required for design and creation of helical wheels and wenxiang diagrams

## Installation

helixvis is available on [CRAN](https://CRAN.R-project.org/package=helixvis).
The development version is available on [GitHub](https://github.com/rrrlw/helixvis).
The following R code can be used to install and load helixvis.

```r
# install from CRAN
install.packages("helixvis")

# install development version from GitHub repository
devtools::install_github("rrrlw/helixvis", build_vignettes = TRUE)

# load for use
library("helixvis")
```

## Usage

The following code demonstrates the use of helixvis to using sample data included in the package (development version only).


```r
# load helixvis
library("helixvis")

# load sample dataset
data("sequence")

# visualize helical wheel from first peptide in sample data
draw_wheel(sequence$Seq[1])

# save to workspace
ggplot2::ggsave(paste(sequence$Name[1], ".png", sep = ""),
                width = 6, height = 6)

# visualize wenxiang diagram from second peptide in sample data
draw_wenxiang(sequence$Seq[2])

# save to workspace
ggplot2::ggsave(paste(sequence$Name[2], ".png", sep = ""),
                width = 6, height = 6)
```

## Contributions

Please report any bugs, suggestions, etc. on the [issues page](https://github.com/rrrlw/helixvis/issues) of the [helixvis GitHub repository](https://github.com/rrrlw/helixvis).
Contributions (bug fixes, new features, etc.) are welcome via pull requests (generally from forked repositories).
