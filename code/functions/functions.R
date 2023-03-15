# check list of packages and install if needed before loading
# if package already installed will be loaded
f_install_and_load_packages <- function(packages) {
  installed_packages <- rownames(installed.packages())
  packages_to_install <- packages[!packages %in% installed_packages]
  
  if (length(packages_to_install) > 0) {
    message(paste0("Installing packages: ", paste(packages_to_install, collapse = ", ")))
    install.packages(packages_to_install)
  } else {
    message("All packages already installed.")
  }
  
  # load all packages, whether newly installed or not
  for (pkg in packages) {
    library(pkg, character.only = TRUE, quietly = TRUE)
  }
}


f_round_n <- function (x, digits=0) 
{
  posneg = sign(x)
  z = abs(x)*10^digits
  z = z + 0.5 #+ sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^digits
  z = z*posneg
  return(z)
}


f_round_pct <- function(input,digits=1) {
  if (f_round_n(input,digits) == 0){
    
    output = f_round_n(input,digits+1)
  } else {
    output = f_round_n(input,digits) } 
  return(output)
}

# excel rounding to 1 decimal place
f_round_1dp <- function (x, digits=1) 
{
  posneg = sign(x)
  z = abs(x)*10^digits
  z = z + 0.5 #+ sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^digits
  z = z*posneg
  return(z)
}

f_word_vector <- function(input) {
  words <- vector(mode="character", length=6)
  words <- c("[[invalid f_word_vector]]","[[invalid f_word_vector]]","[[invalid f_word_vector]]","[[invalid f_word_vector]]","[[invalid f_word_vector]]","[[invalid f_word_vector]]")
  words <- case_when(input < 0 ~ c("decrease", "a decrease", "decreasing", "decreased", "lower", "below", "less","down"),
                     input == 0 ~ c("!!NO CHANGE IN VALUE!!"),
                     input > 0 ~ c("increase", "an increase", "increasing", "increased", "higher", "above", "more","up"),
                     TRUE ~ c("[[invalid value]]"))
  return(words)
}

##### calculations used in RTI #####
f_calc_n_diff<- function(current_val, previous_val){
  as.numeric(current_val) - as.numeric(previous_val) #does this need to be rounded
}

f_calc_pct_diff<- function(current_val, previous_val){
  f_round_pct((as.numeric(current_val) / as.numeric(previous_val)) * 100)
}


##### calculations for redundancy data only  ####


f_fix_lgdnames <- function (lgdname) {
  
  case_when(lgdname == "BELFAST" ~ "Belfast",
            lgdname == "Armagh, Banbridge and Craigavon" ~ "Armagh City, Banbridge and Craigavon",
            lgdname == "Derry and Strabane" ~ "Derry City and Strabane",
            lgdname == "North Down and Ards" ~ "Ards and North Down",
            TRUE ~ lgdname )  }  



# replace 9999 with [d] and add thousand separator for spreadsheets
f_format_disc_ss <- function (fig) {
  
  case_when(fig == -9999 ~ '[d]',
            fig != 9998 ~ prettyNum(fig, big.mark = ","),
            TRUE ~ "OOPS") }

