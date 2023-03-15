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

## :bell: Getting started

### FOR RENV USERS ONLY !!! Renv - package management - getting started

Renv is package management tool for R that support reproducible code over time - it keeps a record of packages and package versions. When you first start/download a project with renv, you need to run a few commands but after that it is fairly hands off.

- Download this project and open the `rap-skeleton.Rproj` file
- A message about `Bootstrapping renv` might appear. If you get `Error in bootstrap` at the end, run `renv::init()` (if this fails, run `install.packages(renv)` in the Terminal to install or click the yellow banner in Rstudio to install renv if that appears)
- You should be presented with some options - select option `1` for `Restore the project from the lockfile`. This will begin downloading and installing the specific versions of packages that it was built with.
- If some packages fail, try running `renv::restore()` again
- If they continue to fail, try running `renv::install(packagename)`
- If that doesn't work, try running `install.packages(packagename)` and then running `renv::restore()`
- If you get a warning `renv 0.16.0 was loaded from project library, but this project is configured to use renv 0.17.0.`, it should be safe to run the command it lists to update to the requested version.
- Once this completes without error, the result of `renv::status()` should be `* The project is already synchronized with the lockfile.`

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
| Create your spreadsheets | Edit and run `code/excel_tables.R` to create your tables<sup>1</sup> |
| Update title | Edit `title` in YAML |
| Update look and feel<sup>2</sup> | Edit `nicstheme` in YAML to your department |
| Update publication metadata | See `code/config.R` |
| Write your report | Edit `code/report.Rmd` to add a table/chart<sup>1</sup> and some explanatory text |
| HTML output | Knit `code/report.Rmd` |
| Check your outputs | Review HTML and Excel outputs in `outputs/` folder

<sup>1</sup> The dataframes created in `code/data_prep.R` are included and available in both `code/report.Rmd` and `code/excel_tables.R` automatically  
<sup>2</sup> Changes to department colour 'highlight' and logo only

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
