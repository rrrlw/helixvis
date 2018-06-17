# helixvis: An R package to visualize alpha-helical peptide sequences

[![Build Status](https://travis-ci.org/rrrlw/helixvis.svg?branch=master)](https://travis-ci.org/rrrlw/helixvis)
[![](http://www.r-pkg.org/badges/version/helixvis)](https://CRAN.R-project.org/package=helixvis)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Purpose

helixvis can be used to create pretty, publication-quality visualizations of alpha-helical peptide sequences.
Specifically, this package allows the user to programmatically generate helical wheels to provide a bird's eye, top-down view of a short, alpha-helical peptide.
Although tools exist to complete this task (e.g. HeliQuest), they generally provide a user interface for manual input of peptide sequences, without allowing for programmatic creation of helical visualizations.
Programmatic generation of helical wheels in open source R provides multiple benefits, including:

* quick and easy incorporation of wheels into R markdown documents
* rapid generation of many peptides (e.g. all the elements of a peptide database) without manual steps
* reproducibility and collaboration

The current vision is for helixvis to implement generation of Wenxiang diagrams and helical nets, along with increased customization of the visualizations themselves.
Please report any bugs, suggestions, etc. on the [issue page](https://github.com/rrrlw/helixvis/issues) of the [helixvis GitHub repository](https://github.com/rrrlw/helixvis).

## Installation

helixvis is available on [CRAN](https://CRAN.R-project.org/package=helixvis).
The following R code can be used to install and load helixvis.

```r
# install from CRAN
install.packages("helixvis")

# load library for use
library("helixvis")
```

## Usage

The following code demonstrates the use of helixvis to create a helical wheel for the first 18 residues of melittin, a potent antimicrobial peptide found in bee venom.

```r
# load helixvis
library("helixvis")

# create helical wheel (18 residue limit)
draw_wheel("GIGAVLKVLTTGLPALIS")

# save visualization in working directory
png("MelittinWheel.png")
draw_wheel("GIGAVLKVLTTGLPALIS")
dev.off()
```
