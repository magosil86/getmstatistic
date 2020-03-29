# Goal: Generate and export S3 class/methods for getmstatistic and document using roxygen tags
#
#' Quantifying Systematic Heterogeneity in Meta-Analysis.
#'
#' \code{getmstatistic} computes \emph{M} statistics to assess the contribution
#' of each participating study in a meta-analysis. The \emph{M} statistic 
#' aggregates heterogeneity information across multiple variants to, identify 
#' systematic heterogeneity patterns and their direction of effect in 
#' meta-analysis. It's primary use is to identify outlier studies, which either 
#' show "null" effects or consistently show stronger or weaker genetic effects 
#' than average, across the panel of variants examined in a GWAS meta-analysis. 
#'
#' In contrast to conventional heterogeneity metrics (Q-statistic, I-squared and 
#' tau-squared) which measure random heterogeneity at individual variants, 
#' \emph{M} measures systematic (non-random) heterogeneity across multiple 
#' independently associated variants. 
#'
#' Systematic heterogeneity can arise in a meta-analysis due to differences in 
#' the study characteristics of participating studies. Some of the differences 
#' may include: ancestry, allele frequencies, phenotype definition, 
#' age-of-disease onset, family-history, gender, linkage disequilibrium and 
#' quality control thresholds. See the getmstatistic website for statistical 
#' theory, documentation and examples.
#'
#' \code{getmstatistic} uses summary data i.e. study effect-sizes and their 
#' corresponding standard errors to calculate \emph{M} statistics (One \emph{M} 
#' for each study in the meta-analysis).
#'
#' In particular, \code{getmstatistic} employs the inverse-variance weighted 
#' random effects regression model provided in the \code{metafor} R package 
#' to extract SPREs (standardized predicted random effects) which are then 
#' aggregated to formulate \emph{M} statistics.
#' 
#' 
#' @seealso \code{\link[metafor]{rma.uni}} function in \code{metafor} for random
#'     effects model, and \url{https://magosil86.github.io/getmstatistic/} for 
#'     getmstatistic website. 
#'
#' @aliases getm getmstat getmstatistic Rgetmstatistic
#'
#' @param beta_in A numeric vector of study effect-sizes e.g. log odds-ratios. 
#' @param lambda_se_in A numeric vector of standard errors, genomically 
#'        corrected at study-level. 
#' @param study_names_in A character vector of study names. 
#' @param variant_names_in A character vector of variant names e.g. rsIDs.
#' @param tau2_method A character scalar, method to estimate heterogeneity: 
#'        either "DL" or "REML" (Optional). Note: The REML method uses the 
#'        iterative Fisher scoring algorithm (step length = 0.5, maximum 
#'        iterations = 10000) to estimate tau2.
#' @param x_axis_increment_in A numeric scalar, value by which x-axis 
#'        of M scatterplot will be incremented (Optional).
#' @param x_axis_round_in A numeric scalar, value to which x-axis labels of 
#'        M scatterplot will be rounded (Optional).
#' @param produce_plots A boolean to generate plots (optional).
#' @param save_dir A character scalar specifying a path to the directory where
#'        plots should be stored (optional). Required if produce_plots = TRUE.
#' @param verbose_output An optional boolean to display intermediate output.
#' @param ... Further arguments.
#'
#' @return Returns a list containing:
#' \itemize{
#'   \item Mstatistic_expected_mean   , A numeric scalar for the expected mean for M
#'   \item Mstatistic_expected_sd     , A numeric scalar for the expected standard deviation 
#'         for M
#'   \item number_studies             , A numeric scalar for the number of studies
#'   \item number_variants            , A numeric scalar for the number of variants
#'   \item Mstatistic_crit_alpha_0_05 , A numeric scalar of the critical M value at the 5
#'         percent significance level.
#'   \item M_dataset (dataframe) A dataset of the computed M statistics, which
#'         includes the following fields:
#'   \itemize{
#'         \item M           , Mstatistic
#'         \item M_sd        , standard deviation of M
#'         \item M_se        , standard error of M
#'         \item lowerbound  , lowerbound of M 95% confidence interval
#'         \item upperbound  , upperbound of M 95% confidence interval
#'         \item bonfpvalue  , 2-sided bonferroni pvalues of M
#'         \item qvalue      , false discovery rate adjusted pvalues of M
#'         \item tau2        , tau_squared, DL estimates of between-study 
#' heterogeneity
#'         \item I2          , I_squared, proportion of total variation due to 
#' between study variance
#'         \item Q           , Cochran's Q
#'         \item xb          , fitted values excluding random effects
#'         \item usta        , standardized predicted random effect (SPRE)
#'         \item xbu         , fitted values including random effects
#'         \item stdxbu      , standard error of prediction (fitted values) 
#' including random effects
#'         \item hat         , diagonal elements of the projection hat matrix
#'         \item study       , study numbers    
#'         \item snp         , variant numbers
#'         \item beta_mean   , average variant effect size
#'         \item oddsratio   , average variant effect size as oddsratio
#'         \item beta_n   , number of variants in each study
#'         }
#'   \item influential_studies_0_05 (dataframe) A dataset of influential studies 
#'        significant at the 5 percent level.
#'   \item weaker_studies_0_05 (dataframe) A dataset of under-performing studies 
#'        significant at the 5 percent level.
#' }
#'
#' @examples
#' library(getmstatistic)
#' library(gridExtra)
#'
#' 
#' # Basic M analysis using the heartgenes214 dataset.
#' # heartgenes214 is a multi-ethnic GWAS meta-analysis dataset for coronary artery disease.
#' # To learn more about the heartgenes214 dataset ?heartgenes214
#'
#' # Running an M analysis on 20 GWAS significant variants (p < 5e-08) in the first 10 studies
#'
#' heartgenes44_10studies <- subset(heartgenes214, studies <= 10 & fdr214_gwas46 == 2) 
#' heartgenes20_10studies <- subset(heartgenes44_10studies, 
#'     variants %in% unique(heartgenes44_10studies$variants)[1:20])
#' 
#' # Set directory to store plots, this can be a temporary directory
#' # or a path to a directory of choice e.g. plots_dir <- "~/Downloads"
#' plots_dir <- tempdir()
#'
#' getmstatistic_results <- getmstatistic(heartgenes20_10studies$beta_flipped, 
#'                                         heartgenes20_10studies$gcse, 
#'                                         heartgenes20_10studies$variants, 
#'                                         heartgenes20_10studies$studies,
#'                                         save_dir = plots_dir)
#' getmstatistic_results
#'
#' # Explore results generated by getmstatistic function
#'
#' # Retrieve dataset of M statistics
#' dframe <- getmstatistic_results$M_dataset
#' 
#' \donttest{
#' 
#' str(dframe)
#'}
#'
#' # Retrieve dataset of stronger than average studies (significant at 5% level)
#' getmstatistic_results$influential_studies_0_05
#' 
#' # Retrieve dataset of weaker than average studies (significant at 5% level)
#' getmstatistic_results$weaker_studies_0_05
#'
#' # Retrieve number of studies and variants
#' getmstatistic_results$number_studies
#' getmstatistic_results$number_variants
#' 
#' # Retrieve expected mean, sd and critical M value at 5% significance level
#' getmstatistic_results$M_expected_mean
#' getmstatistic_results$M_expected_sd
#' getmstatistic_results$M_crit_alpha_0_05
#'
#' # To view plots stored in a temporary directory, call `tempdir()` to view the directory path 
#' tempdir()
#'
#'
#' # Additional examples: These take a little bit longer to run
#' 
#' \dontrun{
#'
#' # Set directory to store plots, this can be a temporary directory
#' # or a path to a directory of choice e.g. plots_dir <- "~/Downloads"
#' plots_dir <- tempdir()
#'
#' # Run M analysis on all 214 lead variants
#' # heartgenes214 is a multi-ethnic GWAS meta-analysis dataset for coronary artery disease.
#' getmstatistic_results <- getmstatistic(heartgenes214$beta_flipped, 
#'                                         heartgenes214$gcse, 
#'                                         heartgenes214$variants, 
#'                                         heartgenes214$studies,
#'                                         save_dir = plots_dir)
#' getmstatistic_results
#'
#'
#' # Subset the GWAS significant variants (p < 5e-08) in heartgenes214
#' heartgenes44 <- subset(heartgenes214, heartgenes214$fdr214_gwas46 == 2)
#'
#' # Exploring getmstatistic options:
#' #     Estimate heterogeneity using "REML", default is "DL"
#' #     Modify x-axis of M scatterplot
#' #     Run M analysis verbosely
#' getmstatistic_results <- getmstatistic(heartgenes44$beta_flipped, 
#'                                         heartgenes44$gcse, 
#'                                         heartgenes44$variants, 
#'                                         heartgenes44$studies,
#'                                         save_dir = plots_dir,
#'                                         tau2_method = "REML",
#'                                         x_axis_increment_in = 0.03, 
#'                                         x_axis_round_in = 3,
#'                                         produce_plots = TRUE,
#'                                         verbose_output = TRUE)
#' getmstatistic_results
#'
#'
#' }
#'
#' @export
getmstatistic <- function(beta_in, lambda_se_in, study_names_in, variant_names_in, ...) UseMethod("getmstatistic")

#' @describeIn getmstatistic Computes M statistics
#' @export
getmstatistic.default <- function(beta_in, lambda_se_in, study_names_in, 
                                  variant_names_in, save_dir = getwd(), tau2_method = "DL",
                                  x_axis_increment_in = 0.02, x_axis_round_in = 2, 
                                  produce_plots = TRUE, verbose_output = FALSE, ...) {

    # Check whether all required variables are present
    if (missing(beta_in))
        stop("Beta values missing, need to specify study effect-sizes.")
 
    if (missing(lambda_se_in))
        stop("Standard errors missing, need to specify standard errors.")

    if (missing(study_names_in))
        stop("Study names missing, need to specify study names.")

    if (missing(variant_names_in))
        stop("Variant names missing, need to specify variant names.")

    
    # Verify datatypes of required variables
    if (!is.numeric(c(beta_in, lambda_se_in))) {

        stop("beta_in and lambda_se_in should be of type, numeric.")

    }


    if (!is.character(c(variant_names_in, study_names_in))) {

        stop("variant_names_in and study_names_in should be of type, character.")

    }
    
    compute_m_results <- compute_m_statistics(beta_in, lambda_se_in, study_names_in, variant_names_in, 
                                              save_dir, tau2_method, x_axis_increment_in, 
                                              x_axis_round_in, produce_plots, verbose_output)
    
    compute_m_results$call <- match.call()
    
    class(compute_m_results) <- "getmstatistic"
    
    compute_m_results
    
}

#' @export
print.getmstatistic <- function(x, ..., verbose_output = FALSE) {

    cat("Call:\n")
    print(x$call)

    cat("\nM_expected_mean:\n")
    print(x$M_expected_mean)

    cat("\nM_expected_sd:\n")
    print(x$M_expected_sd)

    cat("\nM_crit_alpha_0_05:\n")
    print(x$M_crit_alpha_0_05)
    
    cat("\ninfluential_studies_0_05:\n")
    print(x$influential_studies_0_05)
    
    cat("\nweaker_studies_0_05:\n")
    print(x$weaker_studies_0_05)


}
