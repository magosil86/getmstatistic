#' heartgenes214.
#'
#' heartgenes214 is a multi-ethnic GWAS meta-analysis dataset for coronary
#' artery disease.
#'
#' It comprises summary data (effect-sizes and their corresponding standard 
#'     errors) for 48 studies (68,801 cases and 123,504 controls), at 214 lead 
#'     variants independently associated with coronary artery disease 
#'     (P < 0.00005, FDR < 5\%). Of the 214 lead variants, 44 are genome-wide 
#'     significant (p < 5e-08). The meta-analysis dataset is based on 
#'     individuals of: African American, Hispanic American, East Asian, 
#'     South Asian, Middle Eastern and European ancestry. 
#'
#' The study effect-sizes have been flipped to ensure alignment of the 
#'     effect alleles.
#'
#' Standard errors were genomically corrected at the study-level.
#'
#'
#' @format A data frame with seven variables:
#' \describe{
#' \item{\code{beta_flipped}}{Effect-sizes expressed as log odds ratios. Numeric}
#' \item{\code{gcse}}{Standard errors}
#' \item{\code{studies}}{Names of participating studies}
#' \item{\code{variants}}{Names of genetic variants/SNPs}
#' \item{\code{cases}}{Number of cases in each participating study}
#' \item{\code{controls}}{Number of controls in each participating study}
#' \item{\code{fdr214_gwas46}}{Flag indicating GWAS significant variants, 
#'       1: Not GWAS-significant, 2: GWAS-significant}
#' }
#'
#' @source Magosi LE, Goel A, Hopewell JC, Farrall M, on behalf of the 
#'         CARDIoGRAMplusC4D Consortium (2017) Identifying systematic 
#'         heterogeneity patterns in genetic association meta-analysis studies. 
#'         PLoS Genet 13(5): e1006755. https://doi.org/10.1371/journal.pgen.1006755.
#'
#'         \url{https://magosil86.github.io/getmstatistic/}
#'
"heartgenes214"