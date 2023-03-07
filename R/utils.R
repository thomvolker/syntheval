#' create syn_df
#'
#' syn_df is a data frame with
#'
#' @param df_syn synthesized data frame
#' @param df_orig original data frame
#'
#' @keywords internal
create_combined_df <- function(df_syn, df_orig) {
  df_syn$`__Z__` <- factor("synthetic", levels = c("synthetic", "original"))
  df_orig$`__Z__` <- factor("original", levels = c("synthetic", "original"))

  rbind(df_syn, df_orig)
}

#' check that df_syn and df_ori are compatible
#'
#' syn_df is a data frame with
#'
#' @param df_syn synthesized data frame
#' @param df_orig original data frame
#'
#' @keywords internal
check_df_compatibility <- function(df_syn, df_orig) {
  stopifnot(colnames(df_syn) == colnames(df_orig))
  invisible(TRUE)
}

#' First version of permute df
#'
#' @keywords internal
permute_df_combined <- function(df_combined) {
  df_combined[["__Z__"]] <- sample(df_combined[["__Z__"]])
  return(df_combined)
}

#' Permutation test function
#'
#' @importFrom pbapply pbvapply
#'
#' @keywords internal
permutation_distribution <- function(df_combined, utility_fun, n_permutations = 500, ...) {
  cat("   Performing permutation test...\n")

  # get reference values
  ref_values <- pbvapply(
    X = seq_len(n_permutations),
    FUN = function(i__) utility_fun(permute_df_combined(df_combined), ...),
    FUN.VALUE = numeric(1)
  )

  cat("\n")

  # return ecdf
  return(ecdf(ref_values))
}
