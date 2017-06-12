Package name: getmstatistic


Title: Quantifying Systematic Heterogeneity in Meta-Analysis.

Authors: Lerato E. Magosi, Jemma C. Hopewell and Martin Farrall


Description:

getmstatistic computes M statistics to assess the contribution of each participating study 
in a meta-analysis. It's primary use is to identify outlier studies, which either 
show "null" effects or consistently show stronger or weaker genetic effects than average, 
across the panel of variants examined in a GWAS meta-analysis. In contrast to conventional 
heterogeneity metrics (Q-statistic, I-squared and tau-squared) which measure random 
heterogeneity at individual variants, the M-statistic measures systematic (non-random) 
heterogeneity across multiple independently associated variants.

Reference:

Magosi LE, Goel A, Hopewell JC, Farrall M, on behalf of the CARDIoGRAMplusC4D Consortium (2017) 
Identifying systematic heterogeneity patterns in genetic association meta-analysis studies. 
PLoS Genet 13(5): e1006755. https://doi.org/10.1371/journal.pgen.1006755

Installation files:

getmstatistic.ado
getmstatistic.sthlp

Sample dataset:
heartgenes214.dta


Dependencies (commands that need to be installed for getmstatistic to work):

cii
duplicates
egen
latabstat
metareg
savesome
summarize
tabstat
qqvalue


Support: lmagosi@well.ox.ac.uk or magosil86@gmail.com

