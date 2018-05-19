## Test environments
* local OS X install, R 3.3.3
* win-builder (r-release)
* Travis CI (Ubuntu 14.04), r-release
* r-hub
  - Ubuntu 16.04 LTS, r-release
  - Fedora Linux, r-devel
  - Windows Server 2008 R2, r-devel

## R CMD check results
There were no ERRORs or WARNINGs. There was 1 NOTE in a subset of the R CMD checks regarding potentially misspelled words in the DESCRIPTION file (e.g. peptide). I have manually checked the potential misspellings - they are all spelled correctly and are normal terminology used by biochemists.

## Special notes
Version 0.9.0 is a major overhaul; whereas the previous version (v0.1.0) depended on Java to create the visualizations, the current version is written completely in R. This corrects issues occurring previously with Java 9 and Java 10 on CRAN.
