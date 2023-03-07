#' pMSE metric using random forest
#'
#' @param df_syn synthesized data frame
#' @param df_orig original data frame
#'
#' @return pmse value
#'
#' @examples
#'  # bad
#'  utility_pmse_rf(birthwt_ind, birthwt)
#'
#'  # good
#'  utility_pmse_rf(birthwt_dep, birthwt)
#'
utility_pmse_rf <- function(df_syn, df_orig, test = FALSE, ...) {
  check_df_compatibility(df_syn, df_orig)
  df_combined <- create_combined_df(df_syn, df_orig)
  util_value <- .utility_pmse_rf(df_combined, ...)

  if (test) {
    ref_dist <- permutation_distribution(df_combined, .utility_pmse_rf, ...)
    return(list(value = util_value, pval = 1 - ref_dist(util_value), ref_dist = ref_dist))
  }

  return(util_value)
}

.utility_pmse_rf <- function(df_combined, ...) {
  fit <- ranger(`__Z__` ~ ., df_combined, write.forest = TRUE, probability = TRUE, ...)
  prd <- predict(fit, df_combined, type = "response")$predictions[,1]
  n_syn <- table(df_combined[["__Z__"]])["synthetic"]
  N <- nrow(df_combined)
  return(c(crossprod(prd-(n_syn/N))))
}
