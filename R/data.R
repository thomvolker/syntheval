#' Example birthweight data
#'
#' This dataset contains information on newborn babies and their parents.
#'
#' \describe{
#'   \item{length}{Length of baby (cm)}
#'   \item{birthweight}{Weight of baby (kg)}
#'   \item{headcirumference}{Head Circumference}
#'   \item{gestation}{Gestation (weeks)}
#'   \item{motherage}{Maternal age}
#'   \item{mnocig}{Number of cigarettes smoked per day by mother}
#'   \item{mheight}{Mothers height (cm)}
#'   \item{mppwt}{Mothers pre-pregnancy weight (kg)}
#'   \item{fage}{Father's age}
#'   \item{fedyrs}{Father’s years in education}
#'   \item{fnocig}{Number of cigarettes smoked per day by father}
#'   \item{fweight}{Father's weight (kg)}
#' }
#'
#' @seealso [birthwt_ind], [birthwt_dep]
#'
#' @source <https://www.sheffield.ac.uk/mash/statistics/datasets>
"birthwt"


#' Independent synthetic birthweight data
#'
#' Synthetic version of birthwt data, without column relationships.
#' Generated with synthpop, using method = parametric and a diagonal
#' predictor matrix.
#'
#' @seealso [birthwt], [birthwt_dep]
"birthwt_ind"


#' Dependent synthetic birthweight data
#'
#' Synthetic version of birthwt data, with column relationships
#' Generated with synthpop, using method = CART
#'
#' @seealso [birthwt], [birthwt_ind]
"birthwt_dep"
