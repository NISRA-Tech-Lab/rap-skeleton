#### renv::restore() ----

# To install the packages prescribed by the renv lock file run:
renv::restore()
# Then return 'y' when prompted in the Console
# This process will take anywhere from 30 seconds if you have previously
# installed a lot of the packages to 5/6 minutes for completely fresh instances

# renv doesn't tell you when it has finished restoring - to check, add a simple
# calculation - 2+2 for example, to the Console - if it returns an answer,
# processing is complete


#### renv::status() ----

# To check the status of your renv project run:
renv::status()
# This reports inconsistencies between the project lockfile
# (the required packages) and the currently installed packages

# A message should display telling you:
# 'No issues found -- the project is in a consistent state.' or similar message


#### Troubleshooting ----

# Issues can occur with installation of packages, especially if they are being
# built from source. If you experience issues, please consult the renv
# troubleshooting section of the Tech Lab documentation:
# https://datavis.nisra.gov.uk/techlab/drpvze/r.html#renv_troubleshooting


#### renv::install() and renv::snapshot() ----

# renv::install() ----

# to add the latest version of a package to your project,
# run from here, or from the console:
renv::install("pkg_name")
# to add a specific version of a package to your project,
# run from here, or from the console:
renv::install("pkg_name@pkg_version")

# renv::snapshot() ----

# once you have correctly installed any new packages, you need
# to update the lock file to reflect these additions
# run:
renv::snapshot()
# this will add any newly detected packages and dependencies
# to your projects lockfile
# be sure to push these changes to your remote git repo, if using
# to allow other users to pull these lock file changes

#### incorporating lock file changes from others ----

# if you pull down lockfile changes from a remote repo, run:
renv::status()
# to check what has changed and then run:
renv::restore()
# to incorporate those changes into your local code repo
