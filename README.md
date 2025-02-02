[![Travis-CI Build Status](https://travis-ci.org/magosil86/getmstatistic.svg?branch=master)](https://travis-ci.org/magosil86/getmstatistic)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/magosil86/getmstatistic/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/magosil86/getmstatistic.svg)](https://github.com/magosil86/getmstatistic/issues)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/getmstatistic)](https://cran.r-project.org/package=getmstatistic)
[![Coverage status](https://codecov.io/gh/magosil86/getmstatistic/branch/master/graph/badge.svg)](https://codecov.io/github/magosil86/getmstatistic?branch=master)
[![CRAN_Logs_Rstudio](https://cranlogs.r-pkg.org/badges/grand-total/getmstatistic)](http://cran.rstudio.com/web/packages/getmstatistic/index.html)

<!--- [![CRAN_Logs_Rstudio](http://cranlogs.r-pkg.org/badges/getmstatistic)](http://cran.rstudio.com/web/packages/getmstatistic/index.html) --->


# [getmstatistic]() <img src="getmstatistic-striking-image.png" align="right" />

_M_ - An aggregate statistic, to identify systematic heterogeneity patterns and their direction of effect in meta-analysis 
 
## Overview
 
 _M_ quantitatively describes systematic (non-random) heterogeneity patterns acting across multiple variants in a GWAS meta-analysis. It's primary use is to identify outlier studies, which either show "null" effects or consistently show stronger or weaker genetic effects than average across, the panel of variants examined in a meta-analysis.

 _M_ differs from conventional heterogeneity metrics (Q-statistic, I<sup>2</sup>), in that, it measures heterogeneity across multiple independently associated variants, whilst (Q-statistic, I<sup>2</sup>) measure heterogeneity at individual variants. Essentially, _M_ measures systematic heterogeneity, whilst (Q-statistic, I<sup>2</sup>) measure random variant-specific heterogeneity.

### Sources of systematic heterogeneity
Systematic heterogeneity can arise in a meta-analysis due to differences in the study characteristics of participating studies. Some of the differences may include: ancestry, allele frequencies, phenotype definition, age-of-disease onset, family-history, gender, linkage disequilibrium and quality control thresholds.

### Practical benefits of exploring systematic heterogeneity

* Reveal studies showing systematically weaker effects than average which could lower the power of a meta-analysis to detect genetic signals. For example, outlier studies that pass typical quality control checks (genotype call rate, Hardy-Weinberg equilibrium cutoffs, genomic control) but might show no association with phenotype of interest due to faulty genotype data (e.g. flipped alleles and/or strands, incorrect minor allele frequencies).

* Reveal studies showing systematically stronger effects than average which can elucidate biologically important differences among the studies e.g. sexual dimorphism or sub-phenotype variability.



## Installation: Stata

* Install getmstatistic [**Stata** command](https://github.com/magosil86/getmstatistic) from SSC

1. Start stata
2. To install the getmstatistic stata module: `ssc install getmstatistic`
3. To get the example dataset in your current working directory: `net get getmstatistic`
4. You're all set, getmstatistic is installed, try some of the examples in the getmstatistic help file

Tip! getmstatistic depends on the following user-written Stata commands which can be installed
 using `ssc install package-name` or findit `package-name`:

* latabstat
* metareg
* savesome
* tabstat
* qqvalue

A full list of getmstatistic dependencies can be found in the help file.

---

* Install getmstatistic [**Stata** command](https://github.com/magosil86/getmstatistic) manually

* Download the getmstatistic zip file: [getmstatistic_0.1.1_stata_ssc.zip](https://github.com/magosil86/getmstatistic/blob/master/getmstatistic_0.1.1_stata/getmstatistic_0.1.1_stata_ssc.zip)

```
1. Unzip the folder

Tip! the folder should contain the following files: getmstatistic.ado getmstatistic.sthlp heartgenes214.dta

2. Start stata

3. Locate your personal directory where stata stores user generated files by typing: `sysdir`
sysdir

Tip! on mac the ado/personal directory is likely to be at: ~/Library/Application Support/Stata/ado/personal/
for linux: ~/ado/personal/ 
for windows: c:\ado\personal\

4. Copy getmstatistic.ado and getmstatistic.sthlp to the g sub-directory in personal

Tip! if the g sub-directory does not exist, that just means you do not have user generated commands
that start with the letter g. In that case create a folder named g in the personal directory.

5. Type help getmstatistic in Stata to open the getmstatistic help file.

6. Load the example dataset: heartgenes214.dta

7. You're all set, getmstatistic is installed, try some of the examples in the getmstatistic help file

```

## Installation: getmstatistic [**R** package](https://github.com/magosil86/getmstatistic)

```{r}
# To install the release version from CRAN:
install.packages("getmstatistic")

# Load libraries
library(getmstatistic)  # for calculating M statistics
library(gridExtra)      # for generating tables


# To install the development version from GitHub:

# install devtools
install.packages("devtools")

# install getmstatistic
library(devtools)
devtools::install_github("magosil86/getmstatistic")

# Load libraries
library(getmstatistic)  # for calculating M statistics
library(gridExtra)      # for generating tables

```


## Usage

*  Take a look at an [example workflow](https://github.com/magosil86/getmstatistic/blob/master/vignettes/getmstatistic-tutorial.md)

## Details

* Essentially, _M_ statistics are computed by aggregating standardized predicted random effects (SPREs). To read up about the statistical theory behind the _M_ statistic see:

Magosi LE, Goel A, Hopewell JC, Farrall M, on behalf of the CARDIoGRAMplusC4D Consortium (2017) Identifying systematic heterogeneity patterns in genetic association meta-analysis studies. PLoS Genet 13(5): e1006755. [https://doi.org/10.1371/journal.pgen.1006755](https://doi.org/10.1371/journal.pgen.1006755).


## Getting help

To suggest new features, learn about getmstatistic updates, report bugs, ask questions about the mstatistic, or just interact with other users, sign up to the [getmstatistic](https://groups.google.com/forum/#!forum/getmstatistic) mailing list.


## Code of conduct
Contributions are welcome. Please observe the [Contributor Code of Conduct](https://github.com/magosil86/getmstatistic/blob/master/CONDUCT.md) when participating in this project.

## Citation
Magosi LE, Goel A, Hopewell JC, Farrall M, on behalf of the CARDIoGRAMplusC4D Consortium (2017) Identifying systematic heterogeneity patterns in genetic association meta-analysis studies. PLoS Genet 13(5): e1006755. [https://doi.org/10.1371/journal.pgen.1006755](https://doi.org/10.1371/journal.pgen.1006755).


## Acknowledgements.
Roger M. Harbord’s metareg command for computation of standardized predicted random effects which are then incorporated into calculations for the _M_ statistics. Harbord, R. M., & Higgins, J. P. T. (2008). Meta-regression in Stata. Stata Journal 8: 493‚Äì519.


## Authors.
Lerato E. Magosi, Jemma C. Hopewell and Martin Farrall.

## Maintainer.
Lerato E. Magosi lmagosi@well.ox.ac.uk or magosil86@gmail.com

## License

See the [LICENSE](https://github.com/magosil86/getmstatistic/blob/master/LICENSE) file.

