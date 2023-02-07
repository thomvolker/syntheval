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
utility_pmse_logistic <- function(df_syn, df_orig) {
  check_df_compatibility(df_syn, df_orig)
  df_combined <- create_combined_df(df_syn, df_orig)

  fit <- glm(`__Z__` ~ ., family = "binomial", df_combined)
  prd <- predict(fit, type = "response")
  n_syn <- nrow(df_syn)
  N <- nrow(df_combined)

  return(c(crossprod(prd-(n_syn/N))))
}
