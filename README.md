# RAP Skeleton

## :newspaper: Aim
The aim of the RAP Skeleton is to bring together the things Tech Lab has learned through its Reproducible Analytical Pipeline (RAP) projects into a reusable template. This will allow us to get started on projects more quickly and reuse (or make reusable) code developed for customers.

## :raising_hand: Audience
Initially Tech Lab itself expects to be the primary customer but we hope experienced R users who have already published reports using R/RMarkdown can make use of it too. Unfortunately we can only guarantee support for customers as defined in our project scopes.

## :thumbsup: What the RAP Skeleton is 

:white_check_mark: A template to help Tech Lab with future RAP projects  
:white_check_mark: A foundation for users to independently start building their RAP  
:white_check_mark: A template for 'light touch' RAP customers to start their project with  
:white_check_mark: A place for users to reference one way of doing things  
:white_check_mark: A product that will change over time  

## :thumbsdown: What the RAP Skeleton is not 

:x: Fully documented  
:x: A complete reference for good practice R / accessibility / programming / project management etc.  
:x: The only way to produce a RAP / HTML / spreadsheets etc.

## :question: What's new

- Configuration now found in `code/config.R`  
- Data processing now found in `code/data_prep.R`  
- Spreadsheet now found in `code/excel_tables.R`  
- Function to create and embed Excel/CSV per chart/table (see `code/functions/make_tables.R`)  
- Departmental colours/logos baked in  
- Project structure changes (dedicated folders for code, data, outputs)  
- Various additions to `code/functions/` folder (for reference and untested outside of the projects they were made for)  
- Pre-release warning coded (see `prerelease` option in Rmd YAML)  
- Notification for mobile users that some charts may not be optimised for mobile viewing

## :rocket: Roadmap

![five-stages](https://user-images.githubusercontent.com/85889714/226331135-e0b45758-cdfc-43f1-800f-368391cd87d6.png)

## :bell: Getting started

### renv

#### What is renv?

Renv is a tool that supports reproducibility in R projects. See [their website](https://rstudio.github.io/renv/index.html) for more details. 

#### Why are we moving to renv?

Renv supports the reproducibility of projects both over time (so a project from 2 years ago is more likely to work because you can get the exact packages it was built with) and between users (if you have code problem and your colleague doesn't, you can usually rule out package version differences as the cause). It also helped us solve problems with repository issues that were presenting randomly within and between users.

#### Is renv perfect?

No. renv introduces issues itself, but we feel these are more manageable and easier to pinpoint than alternatives. The main issue we have found is when a package updates and a user is forced to build an older version from source - with `sf`/`terra` in particular this requires updates to Rtools (a program installed alongside R to help building packages). Newer versions of Rtools seem to work with newer packages, but break building very old versions of packages. We're still exploring this area.

#### renv setup

- Download/clone this project and open the project (`rap-skeleton.Rproj`) 
- To install and configure renv for this project, run `source("renv/activate.R")`  
- Disable the MRAN repository using `options(renv.config.mran.enabled = FALSE)` (it won't return any results if it works)
- Tell renv to download and install the packages this projects needs with `renv::restore()` and then press 'y' to accept

#### renv setup summary

- Open project 
- `source("renv/activate.R")` 
- `options(renv.config.mran.enabled = FALSE)` 
- `renv::restore()` and press 'y' to accept

#### renv troubleshooting

`terra` `sf` `-lblosc` `-lkea` `-lsz1` related
rspatial packages might give errors while building from source. Go to [CRAN](https://cran.r-project.org/web/packages/sf/index.html) and find out the latest version[^1] of the troublesome package. Tell renv to use that version using `renvv::record()`. For example, if the latest version of sf is `1.0-12` you would run `renv::record("sf@1.0-12")` and then run `renv::restore()` 
</details>

`mran` `aws` related
e.g. `failed to retrieve 'https://rstudio-buildtools.s3.amazonaws.com/renv/mran/packages.rds' [error code 22]`, re-run `options(renv.config.mran.enabled = FALSE)` (sometimes it re-enables itself) 

`curl` errors / IT security team contact</summary>
When running renv, IT may contact you regarding `curl` being run on your machine. Reference i305810 is related.

[^1]: If a package has been updated recently, CRAN might not be serving the binary - drop the release version down 1 notch until you can get renv to give a binary of that package. For example, on 19/03/2023, `sf` was updated to `1.0-12`. The renv.lock file asks for 1.0-10 but it is only available from source. `1.0-12` is the latest version, but the `r-release` (i.e. the current stable version of R (4.2 at the moment)) binary is listed as `1.0-.11`. Therefore, we need to ask renv for that version with `renv::record("sf@1.0-11")`. CRAN might start serving `1.0-12` as the `r-release` binary in the future.

### Setting up a new repo with the rap-skeleton

#### Set up a blank repo
- Open Rstudio and close down existing projects
- Create an empty directory for your project e.g. `Desktop\01-doj-newpublication`
- In Rstudio, open `Terminal` tab and move into the created directory. `cd` will bring you to `C:\Users\123456`. From there, `cd Desktop` will you into the desktop and finally cd `01-doj-newpublication` will enter the new directory
- In Github.com, create a new repository
  - `Repository name` should be the same as the folder you created e.g. `01-doj-newpublication`
  - Make it Private
- Copy the code under `…or create a new repository on the command line`
  ```
  echo "# 01-doj-newpublication" >> README.md   # Creates a README file for you
  git init                                      # Initialises this folder (e.g. 01-doj-newpublication) as a Git folder
  git add README.md                             # Adds README as a file you will commit
  git commit -m "first commit"                  # Adds a commit message
  git branch -M main # Creates                  # Renames the current branch to main
  git remote add origin https://github.com/ddntl/01-doj-newpublication.git # Links your folder to your Github.com repo
  git push -u origin main                       # Pushes your file to the main branch
  ```
- Paste the code into the `Terminal` tab in Rstudio
- A popup will appear. Click `Sign in with your browser`. A tab will open in your browser and authenticate you. **If you get an error here, try running `git push -u origin main` again**
- If you refresh your repo on Github.com, you should now see the README file

### Add rap-skeleton to your new repo
- Download the latest release as a ZIP file from the [latest releases page](https://github.com/NISRA-Tech-Lab/rap-skeleton/releases)
- Extract and copy the contents of the ZIP file e.g. the code/data/renv etc. folders and files
- Paste them into the repo you created in the last steps e.g. `01-doj-newpublication` - optionally overwrite the README when asked
- In Rstudio's `Terminal`, run 
  - `git add .` to stage all the files. **Ignore the warnings about LF and CRLF.**
  - `git -m "initial upload"` to add a commit message
  - `git push` to push them up to the remote repository
- Your files are now on the github repo and you can now begin development
- It is recommended that you modify the README and rename the Rproj file to something appropriate for your project
- - **You need to close down Rstudio and re-open the Rproj file once it is set up to get Rstudio to show the `Git` tab**

### Key files and folders

| Skeleton/Demo | File | Purpose  |
| --- | --- | --- |
| Skeleton | `code/report.Rmd` | RMarkdown report |
| Skeleton | `code/excel_tables.R` | Produce spreadsheet output |
| Skeleton | `code/data_prep.R` | Data prep for report & spreadsheets |
| Skeleton | `code/config.R` | Configuration file for everything |
| Skeleton | `data/` | Store your raw data files here |
| Skeleton | `outputs/` | HTML and Excel outputs will be saved here |
|  |  |  |
| Demo  | `code/demo/demo_report.Rmd`  | Demo RMarkdown report  |
| Demo  | `code/demo/demo_excel_tables.R`  | Produce demo spreadsheet output  |
| Demo  | `code/demo/demo_data_prep.R`  | Data prep for demo report & demo spreadsheets  |
| Demo  | `code/demo/demo_config.R`  | Configuration for demo only  |
| Demo  | `code/demo/demo_data/`  | Raw data for the demo is stored here |
| Demo  | `code/demo/demo_outputs/` | Demo HTML and Excel outputs will be saved here |

### Example workflows

#### Starting a new publication

| Task | Actions | 
| --- | --- |
| Add your raw data | Place your input data in `data/` folder |
| Process your data | Edit `code/data_prep.R` to create your data frames |
| Create your spreadsheets | Edit and run `code/excel_tables.R` to create your tables[^2] |
| Update title | Edit `title` in YAML |
| Update look and feel[^3] | Edit `nicstheme` in YAML to your department |
| Update publication metadata | See `code/config.R` |
| Write your report | Edit `code/report.Rmd` to add a table/chart[^2] and some explanatory text |
| HTML output | Knit `code/report.Rmd` |
| Check your outputs | Review HTML and Excel outputs in `outputs/` folder

[^2]: The dataframes created in `code/data_prep.R` are included and available in both `code/report.Rmd` and `code/excel_tables.R` automatically  
[^3]: Changes to department colour 'highlight' and logo only

#### Updating an existing projects

| Area | Actions | Benefit |
| --- | --- | --- |
| Charts | Review demo HTML output, use source code tabs to re-use code | Some additions since Accessibility Exemplar |
| Structure | Consider placing outputs, input data, functions etc. in folders, having separate configuration and data processing files etc. | Easier to update and maintain |
| Sub-reports | Review `code/demo/demo_report.Rmd` for `child` chunks that import sub-sections | Allow multiple users / can work on new section while others being reviewed |
| Something else | For other issues or advice, refer to the R Teams Channel for assistance | Tap into experience across agency, code sharing |

#### Create a simple page in HTML

| Task | Actions | 
| --- | --- |
| New document | Install R/Rstudio, [download the skeleton](https://github.com/NISRA-Tech-Lab/rap-skeleton/releases), unzip, open `code/report.Rmd` |
| Word processing | Refer to the [Rmarkdown cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf) and [Definitive Guide](https://bookdown.org/yihui/rmarkdown/) |
| Save to HTML | Click `Knit` at the top of your Rmd file in Rstudio |

## :mega: How to provide feedback

For the initial roll-out to Tech Lab (Group 1) and volunteer testers across NISRA, we would greatly appreciate feedback. Make sure you can run the code (let us know if you have issues) and answer as many of the questions below as you can. **Copy the questions and send us an email, thanks!**

### Testing the Rmd and spreadsheet code works for you

- Run skeleton
  - report (HTML) `code/report.Rmd`
  - spreadsheets (Excel) `code/excel_tables.R`
- Run demo
  - report (HTML) `code/demo/demo_report.Rmd`
  - spreadsheets (Excel) `code/demo/demo_excel_tables.R`

### Questions

1. Do you think the RAP Skeleton could assist you in meeting your RAP objectives? If so, how?
1. Have you produced any part of a publication using R before?
1. Have you used the Accessiblity Exemplar before?
1. Are you using Git for any of your work currently?
1. Feedback on the structure `e.g. file locations, use of sub-section Rmds`
1. Feedback on the demo `e.g. 'source code' tabs, types of charts relevant to your publications, accessibility notes`
1. Any other feedback `e.g. is this better/worse than Accessibility Exemplar`
