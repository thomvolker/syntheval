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

  if (test) {

    util_value <- .utility_pmse_logistic(df_combined)

    ref_values <- vapply(1:500, \(i) {
      df_combined |>
        permute_df_combined() |>
        .utility_pmse_logistic()
      }, FUN.VALUE = numeric(1))

    ref_dist <- ecdf(ref_values)
    return(list(value = util_value, pval = ref_dist(util_value)))
  }

  return(.utility_pmse_logistic(df_combined))
}

.utility_pmse_logistic <- function(df_combined) {
  fit <- glm(`__Z__` ~ ., family = "binomial", df_combined)
  prd <- predict(fit, type = "response")
  n_syn <- sum(df_combined[["__Z__"]])
  N <- nrow(df_combined)
  return(c(crossprod(prd-(n_syn/N))))
}
