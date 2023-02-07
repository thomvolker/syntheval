#' create syn_df
#'
#' syn_df is a data frame with
#'
#' @param df_syn synthesized data frame
#' @param df_orig original data frame
#'
#' @keywords internal
create_combined_df <- function(df_syn, df_orig) {
  df_syn$`__Z__` <- TRUE
  df_orig$`__Z__` <- FALSE

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
permute_df_combined <- function(df_combined) {
  df_combined[["__Z__"]] <- sample(df_combined[["__Z__"]])
  return(df_combined)
}
