## code to prepare `birthwt` dataset goes here
birthwt <- synthpop.extract::Birthweight[,c(-1, -6, -15, -16)]
names(birthwt) <- tolower(names(birthwt))

usethis::use_data(birthwt, overwrite = TRUE)

set.seed(45)
birthwt_ind <- synthpop::syn(birthwt, method = "parametric", predictor.matrix = diag(ncol(birthwt)))$syn
usethis::use_data(birthwt_ind, overwrite = TRUE)

birthwt_dep <- synthpop::syn(birthwt, method = "cart")$syn
usethis::use_data(birthwt_dep, overwrite = TRUE)
