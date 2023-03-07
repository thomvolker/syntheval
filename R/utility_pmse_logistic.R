#' pMSE metric using logistic regression
#'
#' @param df_syn synthesized data frame
#' @param df_orig original data frame
#'
#' @return pmse value
#'
#' @importFrom stats glm
#'
#' @examples
#'  # bad
#'  utility_pmse_logistic(birthwt_ind, birthwt)
#'
#'  # good
#'  utility_pmse_logistic(birthwt_dep, birthwt)
#'
#' @export
utility_pmse_logistic <- function(df_syn, df_orig, test = FALSE) {
  check_df_compatibility(df_syn, df_orig)
  df_combined <- create_combined_df(df_syn, df_orig)
  util_value <- .utility_pmse_logistic(df_combined)

  if (test) {
    ref_dist <- permutation_distribution(df_combined, .utility_pmse_logistic)
    return(list(value = util_value, pval = 1 - ref_dist(util_value), ref_dist = ref_dist))
  }

  return(util_value)
}

.utility_pmse_logistic <- function(df_combined) {
  fit <- glm(`__Z__` ~ ., family = "binomial", df_combined)
  prd <- predict(fit, type = "response")
  n_syn <- table(df_combined[["__Z__"]])["synthetic"]
  N <- nrow(df_combined)
  return(c(crossprod(prd-(n_syn/N))))
}
