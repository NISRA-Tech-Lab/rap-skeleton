# RAP Skeleton

## What is the RAP Skeleton?

The [RAP Skeleton](https://github.com/NISRA-Tech-Lab/rap-skeleton) is a reusable
template for RAP projects. It uses the R programming language, following the
[tidyverse style guide](https://style.tidyverse.org/), to create HTML
statistical publications.

The RAP Skeleton is maintained as a template repository on the
[NISRA Tech Lab GitHub](https://github.com/NISRA-Tech-Lab) organisation. New
projects can be created directly from this template and cloned to a local
computer for development in RStudio. Instructions for setting up a new project
are provided below.

The RAP Skeleton contains both a skeleton template for users to adapt for their
own publications and a completed demo report containing worked examples.

Users updating an existing project to RAP Skeleton V4.0.0 should refer to the
`Updating to RAP Skeleton V4` section of this README.

<details open>
  <summary><strong>What's New in v4.0.0?</strong></summary>

#### 🧰 General review and update
The RAP Skeleton underwent review and any unused or out of date parts of the
code have been removed. The demo report also underwent accessibility testing and
any issues found have been remedied.

#### 🧪 R 4.6.1 compatibility
All packages have been updated so the RAP Skeleton is fully compatible with R
version 4.6.1; Use renv::restore to ensure all packages are synchronized. In
addition all packages have been added to TLCRAN.

#### 📝 New Quality Assessment (QA) report template 
A new QA report template, `qa_report.Rmd`, has been added to the code folder.
This provides a skeleton QA report that teams can populate with their own
quality assurance checks, tables and information.

A completed example, `demo_qa_report.Rmd`, is also included in the demo folder.
This contains example QA tables, statistics and information to demonstrate how
the template can be used to quality assure data and outputs.

#### 🎨 Branding
The branding of the RAP Skeleton has been updated to include the current NISRA
branding standards, including changes to the header colours, borderline,
chart/table/map titles, footer and other elements of the demo report. The RAP
Skeleton is now aligned with the
[nisra-branding GitHub repository](https://github.com/NISRA-Tech-Lab/nisra-branding)
which contains the source code for branding and will be used for future branding
updates.

#### 🔎 New tinyknit package 
The `tinyknit` package has been added to the list of packages included in the RAP
Skeleton. It provides an alternative method for knitting R Markdown reports and
can produce smaller HTML output files than the standard knitting process.

See the `tinyknit usage guide` section at the bottom of this README for
instructions and examples on how to use the package.

#### 📄 New f_responsive_annotations() function
A new, simplified function has been added to improve the responsive resizing of
annotations on Plotly charts. The function adjusts annotation text size based on
the width of the chart, helping annotations remain readable when the chart is
displayed at different widths.

Examples of how f_responsive_annotations() can be applied to Plotly charts are
included in Figure 1, Figure 5 and Figure 14 of the demo report.

#### 🌐 Improvements to User Experience (UX) and Accessibility
Specific elements of the RAP Skeleton, including the footer, cookie banner,
tabsets and accordions, have been refined to improve the user experience and
accessibility.

The CSS file, which controls the styling of HTML elements, has also been updated
and reorganised. Clear headings have been added throughout the file to make it
easier for users to navigate, understand and modify the styling of their
reports.

#### 📊 Download buttons updated
Download buttons have been updated into one dropdown button that aligns with
NISRA's accessible colour palette. A third download option has also been added,
allowing users to download maps and charts as PNG files.

#### 📝 Improvements to content design and writing
The RAP Skeleton demo report has been rewritten using clearer and more
straightforward language. These changes follow accessible content design
principles and aim to make the information easier for a wide range of users to
read and understand.

#### 🏗️ Improvements to code formatting and readability
The existing code within the RAP Skeleton has undergone maintenance to improve
consistency, readability and maintainability. The `styler` and `lintr` packages
have been used to identify formatting issues and help align the code with the
[tidyverse style guide](https://style.tidyverse.org/).

#### 📑 Improvements to the f_worksheet() function
The `f_worksheet()` function has been simplified and made more flexible so it
can now handle both single-table and multi-table worksheets more consistently.
The contents page logic, table titles, hyperlinks, NA styling and Excel
formatting have also been improved to reduce duplication and make the output
easier to maintain.

The function has also been updated to use clearer style names and more robust
row and column handling, making it easier to reuse across different publication
workbooks.

#### ➕ New chart additions
A new `ggplotly` chart has been added as the second tab on Figure 4 of the demo
report. The chart is created using `ggplot2` and converted to an interactive
Plotly chart using `ggplotly()`. See the
[ggplotly documentation](https://plotly.com/ggplot2/getting-started/)
for more information.

</details>

<details>
  <summary><strong>Setting up the RAP Skeleton</strong></summary>
  
It is recommended that new RAP Skeleton projects are created using the RAP
Skeleton template on GitHub. This creates a repository for your publication that
can then be cloned to your computer and opened in RStudio.

Using this approach means that version control is available from the beginning
of the project and provides a shared location for the code used to produce the
publication.

#### Before you start

Before creating a RAP Skeleton project:

  1.  Install **Git for Windows** from the IT Assist Store if it is not already
  installed on your computer.
  2.  Create a GitHub account using your work email address if you do not
  already have one.
  3.  Ensure that you have access to the appropriate GitHub organisation for
  your branch or team.
  4.  Ensure that the required version of R is installed. RAP Skeleton V4
  requires **R 4.6.1** for package installation. This version of R is available
  from the IT Assist Store.

#### Configure Git

If this is the first time you have used Git on your computer, open a Terminal
and configure your Git username and email address:

```         
git config --global http.sslVerify false
git config --global user.name "YourUsername"
git config --global user.email "firstname.lastname@nisra.gov.uk"
```

Replace the example username and email address with the details associated with
your GitHub account.

This configuration normally only needs to be completed once on each computer.

#### Create a repository from the RAP Skeleton template

  1.	Open the **RAP Skeleton** repository on GitHub.
  2.	Select **Use this template** button near the top-right of the repository
  page.
  3.  Select **Create a new repository**.
  4.	Select the appropriate GitHub organisation for your branch or team as the
  repository owner.
  5.	Enter an appropriate repository name for your publication, following any
  naming conventions used by your team. For example: `01-doj-newpublication`.
  6.	Select the appropriate repository visibility.
  7.  Select **Create repository**.

GitHub will create a new repository containing the RAP Skeleton files. Your new
publication repository is independent of the original RAP Skeleton repository.
The changes made to the RAP Skeleton in the future will not automatically be
applied to your publication repository. 

#### Clone the repository into RStudio

Once the new repository has been created:

  1.	On the GitHub page for your new repository, select the green Code button.
  2.  Copy the repository URL.
  3.  Open RStudio.
  4.  Select **File > New Project > Version Control > Git**.
  5.  Paste the copied URL into the **Repository URL** field.
  6.  Choose the location on your computer where you want the project folder to
  be created.
  7.  Select **Create Project**.

RStudio will clone the GitHub repository to your computer and open it as a
project.

You now have:

  -   a repository on GitHub containing the shared version of your publication
  code; and
  -   a local copy of the repository on your computer where you can develop and
  run the publication.

Changes made locally are not automatically sent to GitHub. They must be
committed and pushed when you are ready to share them. See
**Working with Git and GitHub** later in this guide for further information.

#### Next steps

Once the repository has been cloned and opened in RStudio:

  1.  Familiarise yourself with the RAP Skeleton folder structure.
  2.  Set up the project's `renv` environment and restore the required packages.
  3.  Run the demo report to check that the RAP Skeleton is working correctly.
  4.  Begin adapting the template for your publication.

The following sections of this guide explain each of these steps in more detail.

</details>

<details>
  <summary><strong>Understanding the RAP Skeleton folder structure</strong></summary>

Once the repository has been cloned and opened in RStudio, you can view the
files and folders contained within your RAP Skeleton project.

Note:

-   `rap-skeleton.Rproj` ("your repository name"/rap-skeleton.Rproj) is the main
R project file for the RAP Skeleton. Always open this file first when working on
any element of your report.

-   `report.Rmd` (code/report.Rmd) is the main R Markdown file used to produce
your HTML report.

-   `demo_report.Rmd` (code/demo/demo_report.Rmd) is the R Markdown file used to
produce the demo HTML report.

-   Everything relating to the demo report is stored inside the `demo` folder
(`code/demo/`). The entire `demo` folder can be deleted if it
is no longer required.

The following table lists the main RAP Skeleton files and folders and explains
their purpose:

| Skeleton/Demo | Folder/File                     | Purpose                                                                                                         |
|------------------------|------------------------|------------------------|
| Skeleton      | `code/report.Rmd`               | Main R Markdown template used to produce the HTML report                                                        |
| Skeleton      | `code/excel_tables.R`           | Script used to produce the Excel output                                                                         |
| Skeleton      | `code/data_prep.R`              | Data preparation for the report and Excel outputs                                                               |
| Skeleton      | `code/qa_report.Rmd`            | Skeleton QA report that teams can populate with their own quality assurance checks, tables and information      |
| Skeleton      | `code/config.R`                 | Main configuration file for the RAP Skeleton; also read into `demo_config.R`                                    |
| Skeleton      | `code/meta.html`                | HTML containing metadata that is included through the YAML of `report.Rmd` to support search engine optimisation|
| Skeleton      | `code/style.css`                | Stylesheet used to control the appearance of HTML elements within the reports                                   |
| Skeleton      | `code/annotation.js`            | JavaScript used to add, edit and save annotations within the HTML report                                        |             
| Skeleton      | `code/consent_head.html`        | Initialises Google Consent Mode v2 and Google Tag Manager before other analytics code                           |
| Skeleton      | `code/cookie_banner.html`       | Manages the NISRA cookie consent banner, stores the user's preference and updates analytics consent             |
| Skeleton      | `code/functions/`               | Contains reusable R functions used throughout the RAP Skeleton to create and format report and Excel outputs    |
| Skeleton      | `data/`                         | Location for storing raw data files where appropriate. Data can alternatively be read from external sources such as a shared drive or SQL server |
| Skeleton      | `outputs/`                      | Location where HTML and Excel outputs are saved. The folder is created automatically by the RAP Skeleton if it does not already exist            |
| Skeleton      | `.gitignore`                    | Specifies files and folders that Git should ignore and therefore not track in the GitHub repository             |
|               |                                 |                                                                                                                 |
| Demo          | `code/demo/demo_report.Rmd`     | R Markdown file used to produce the demo HTML report                                                            |
| Demo          | `code/demo/demo_excel_tables.R` | Original script used to produce the demo Excel output                                                           |
| Demo          | `code/demo/demo_excel_tables_new.R` | Updated script used to produce the demo Excel output using the `f_worksheet()` function                     |
| Demo          | `code/demo/demo_data_prep.R`    | Data preparation for the demo report, Excel outputs and QA report                                               |
| Demo          | `code/demo/demo_data_portal_prep.R`| Data preparation for uploading data to the NISRA Data Portal                                                 |
| Demo          | `code/demo/demo_config.R`       | Configuration settings specific to the demo                                                                     |
| Demo          | `code/demo/demo_data/`          | Location of the raw data used by the demo                                                                       |
| Demo          | `code/demo/demo_outputs/`       | Location where demo HTML and Excel outputs are saved                                                            |
| Demo          | `code/demo/demo_qa_report.Rmd`  | Completed example QA report containing example quality assurance checks, tables and information                 |
</details>

<details>
  <summary><strong>Demo Report</strong></summary>
  
A demo HTML report is included within the RAP Skeleton project. The demo can be
used to:

-   View, explore and interact with an example HTML report.

-   Understand the file structure and set-up used to organise and produce an
HTML report. The demo provides examples of the `report.Rmd`, `config.R`,
`data_prep.R` and `excel_tables.R` files. These files are prefixed with `demo_`
in the demo folder (for example, `demo_config.R`).

-   Explore the separate `demo_qa_report.Rmd`, which provides a completed
example of how the `qa_report.Rmd` template can be used to document quality
assurance checks, tables and information.

-   Get inspiration for your own HTML report by viewing examples of different
report elements and exploring the R code used to create them.

-   Learn more about digital accessibility requirements and how they can be
considered when developing an HTML report.

To view the latest demo HTML report locally, first knit the `demo_report.Rmd`
file. Instructions for doing this are provided later in this README.

Alternatively, you can view a pre-knitted version of the demo report here:
[demo_report.html](https://datavis.nisra.gov.uk/techlab/drpvze/RAP-demo-report.html)

</details>

<details>
  <summary><strong>Skeleton template</strong></summary>

The RAP Skeleton template provides the starting point for users to create their
own HTML report. Users can get started by loading their data and adapting the
`config.R` and `data_prep.R` files before knitting the `report.Rmd` file. The
`excel_tables.R` file can be adapted separately to produce accompanying Excel
outputs.

Users can write their entire report within the main `report.Rmd` file or divide
it into separate chapters using child `.Rmd` files. Child `.Rmd` files are
called from the main `report.Rmd` file and knitted together to produce a single
HTML report.

The RAP Skeleton template contains only the main `report.Rmd` file by default.
However, the demo report shows how multiple child `.Rmd` files can be used to
organise a report into separate chapters.

For instructions on using this approach, see the
`Implementing child .Rmd files as individual chapters` section later in this
README.

</details>

<details>
  <summary><strong>Renv</strong></summary>

#### Initial setup

`renv` is a package dependency management tool for R. It records the versions of
R packages used by a project in a lockfile, allowing other users to install the
same package versions and helping to make the project reproducible over time.

The RAP Skeleton is already configured to use `renv`. When you open the 
`rap-skeleton.Rproj` file, `renv` should activate automatically.

When opening the project for the first time, you may see a message in the
console similar to:

```         
# Bootstrapping renv 1.2.3 ---------------------------------------------------
- Downloading renv ... OK
- Installing renv  ... OK

- Project 'C:/.../Desktop/rap-skeleton-dev' loaded. [renv 1.2.3]
- One or more packages recorded in the lockfile are not installed.
- Use `renv::status()` for more details.
```

Next open the `renv_setup.R` script and follow the steps under `renv::restore()`
and `renv::status()`. `renv::restore()` installs the package versions recorded
in the project's lockfile, while `renv::status()` can be used to check that the
project library and lockfile are consistent.

Once this process has completed successfully, the packages required by the RAP
Skeleton should be available within the project.

When setting up `renv`, you may see messages in the console similar to:

```         
renv was unable to query available packages from the following repositories: 
- # file:////pr-clus-vfpdfp/DOF_NISRA_R_Packages/production/src/contrib --------
```

These messages do not affect the setup of the RAP Skeleton and can be ignored.

#### Help and Troubleshooting

If the steps above do not work as expected or you receive error messages, see
the `renv` troubleshooting guidance in our
[R Documentation](https://datavis.nisra.gov.uk/techlab/drpvze/r.html#renv_troubleshooting)

For further information about `renv`, visit the
[renv website.](https://rstudio.github.io/renv/index.html)

#### Continuing development within Renv

This version of the RAP Skeleton uses the internal Tech Lab package repository,
TLCRAN, as part of the package setup.

If you continue developing your project and need to add or update packages,
follow the instructions under `renv::install()` and `renv::snapshot()` in the
`renv_setup.R` script. These steps explain how to install packages and record
the updated package versions in the project's lockfile.

#### Git and renv

`renv` works well alongside Git because each user can work with their own local
copy of the project while sharing the same `renv.lock` file. This allows each
user to recreate the required package environment on their own computer.

If Git is not being used, each user should still work from their own local copy
of the project rather than running the same `renv` project directly from a
shared drive. A central shared copy can be maintained separately, with changes
copied to each user's local version as the project develops.

</details>

<details>
  <summary><strong>Using the RAP Skeleton</strong></summary>

After setting up the RAP Skeleton project, familiarising yourself with the
folder structure and setting up `renv`, you can either:

-   Knit and explore the demo HTML report; or

-   Start creating your own HTML report using the RAP Skeleton template.

First-time users are encouraged to knit the demo report before creating their
own report. This provides an opportunity to explore an example HTML report, see
how different elements work and consider which features may be useful for your
own publication.

#### Knitting the Demo

Knitting the `demo_report.Rmd` file will produce the demo HTML report. Follow
these steps:

-   Open the `demo_report.Rmd` by selecting it from the **Files** tab in
RStudio (`code/demo/demo_report.Rmd`).

-   Select **Knit** at the top of the `demo_report.Rmd` window or use the
keyboard shortcut `Ctrl+Shift+K`.

When knitting is complete, the demo HTML report should open in RStudio. A copy
will also be saved in the `demo_outputs` folder (`code/demo/demo_outputs/`).

The same process can be used to knit the demo QA report, `demo_qa_report.Rmd`
(`code/demo/demo_qa_report.Rmd`).

#### Creating an HTML report with the RAP Skeleton template

Before creating your own report, familiarise yourself with the files and folders
included in the RAP Skeleton. There is no single workflow that must be followed;
however, the steps below provide an example that may be suitable for many
reports.

-   This step is optional, rename the following file to something appropriate
for your publication:

    -   `rap-skeleton.Rproj` - the R project file.

-   Store any raw data required by the project in an appropriate location. The
`data` folder can be used for data that is suitable for storing locally within
the project. Alternatively, data can be read from external sources such as a
shared drive or SQL server. Sensitive or restricted data should not be committed
to GitHub.

-   Open the `.Rproj` file (previously named `rap-skeleton.Rproj`). This will
open the project in RStudio.

-   Open  `config.R` and update the configuration and publication metadata
required for your report. This includes variables such as:

    -   `nics_theme` - select the appropriate departmental theme. Available
    options include "teo", "daera", "dfc", "de", "dfe", "dof", "dfi", "doh",
    "doj", "bso" and "adr". The selected theme determines the departmental
    branding applied to the report.

    -   `prerelease` (default = FALSE) - If set to "TRUE" the pre-release
    warning messages will display.

    -   `bilingual` (default = TRUE) - Default setting of "TRUE" will cause
    NISRA logo to display both English and Irish. Set to "FALSE" if not
    required.

    -   `current_year`

    -   `title`

    -   `subtitle`

    -   `statistic_type`

    -   `pub_date`

    -   `next_pub_date`

    -   `header_publisher`

    -   `lead_statistician`

    -   `header_telephone`

    -   `header_email`

-   Open `data_prep.R` to prepare the data required for your publication.

    -   Read in your data. The RAP Skeleton provides examples for importing
    common data sources.

    -   Process your data and create the data frames and other objects required
    by the report.

-   Open `report.Rmd` and update the report title in the YAML.

-   Add the content of your report to `report.Rmd`. If required, divide the
report into separate chapters using child `.Rmd` files.

-   Knit `report.Rmd` to create the HTML report.

-   If your publication requires accompanying Excel tables, open
`excel_tables.R` and add the tables required for your publication. The reusable
Excel functions included in the `functions` folder can be used to help create
and consistently format these outputs.

-   Review the completed HTML and Excel outputs in the `outputs` folder. This
folder will be created automatically if it does not already exist.

Before publishing, refer to the Dissemination Branch guidance on
[accessibility](https://nicsonline.sharepoint.com/sites/TM-DOF-NISRATEAM/SitePages/DISSEMINATION%20Accessibility.aspx?csf=1&web=1&share=ERUVgIGLxlZHrhT2Qx2TYNwBR9Wz9sVOdzU6s5szFWfKsA&e=pLQycg&CID=8717807a-fbf7-4382-addd-b996ed43e60c)
and publishing through the
[Datavis server](https://nicsonline.sharepoint.com/sites/TM-DOF-NISRATEAM/SitePages/DISSEMINATION%20Datavis.aspx?csf=1&web=1&share=EReyP93ozeFEozbNJWq3P_kBHxQDUBduy8sGFc335Sx3OA&e=QKW2re&CID=b3035e06-e924-4a4d-b53e-6d44cc99d466).

</details>

<details>
  <summary><strong>Implementing child .Rmd files as individual chapters</strong></summary>

The entire report can be written within `report.Rmd`, or it can be divided into
separate chapters using child `.Rmd` files. Child files can help make larger
reports easier to organise, edit and maintain. Separating Rmd files makes
development easier across teams. This is because different sections of 
the report can be worked on by multiple individuals and reduce the 
likelihood of merge conflicts by working in different files.

The demo report provides examples of this approach. To create a new chapter
using a child .Rmd file:

-   Using File Explorer, copy one of the child `.Rmd` files from the `demo`
folder, for example `02_introduction.Rmd`, into the folder containing your main
`report.Rmd` file.

-   Rename the copied file to something appropriate for your chapter.

-   Open the child `.Rmd` file within your R project and edit the title in the
YAML.

-  If you intend to knit the child `.Rmd` file independently, update any YAML
settings that still refer to the demo, such as `output_dir`.

-   Check the set-up chunk and ensure that the correct `config.R` and
`data_prep.R` files are sourced, along with any other files required by the
chapter.

-   Add the content, R code, tables and charts required for the chapter.

-   Save the child `.Rmd` file and open the main `report.Rmd` file.

To include the child file within `report.Rmd`:

-   Add an `h2` (`##`) heading for the chapter in the appropriate location.

-   Add an R code chunk beneath the heading.

-   Give the code chunk a meaningful name, for example
`introduction_sub_report`.

-   Set the chunk's child option to the name of the child .Rmd file, for
example: `child="02_introduction.Rmd"`

Example:

![](data/images/child.png)

-   Knit `report.Rmd` and check that the chapter appears correctly in the
completed HTML report.

</details>

<details>
  <summary><strong>Creating Excel tables</strong></summary>

The RAP Skeleton contains an R script called `excel_tables.R`, which can be used
to create an accompanying Excel workbook for your HTML report. By default, the
completed workbook is saved in the `outputs` folder.

The recommended approach is to use the reusable `f_worksheet()` function to
create and format worksheets. A worked example is provided in
`code/demo/demo_excel_tables_new.R`.

To create an Excel workbook using `excel_tables.R`, follow the steps below.

-   Configure the workbook metadata so that it matches your publication. Update
fields such as:
   
    - `creator` - branch or team responsible for the publication.
    - `title` – full publication title, which appears in the Excel file
    properties.
    - `subject` – a short description of the publication.
    - `category` – a broad publication category, for example "Population" or
    "Labour Market".

-   Update the text displayed on the Introduction sheet:

    - Update the publication title.
    - Update the short description explaining what the workbook contains.
    - `pub_date_words_dmy` is created in `config.R` and displays the publication
    date in words.
    - Replace the example contact details with the appropriate contact name,
    team, address, telephone number and email address.
    - Leave "PUBLICATION LINK" and "BQR LINK" in place. These are placeholders
    used by the script to position the relevant hyperlinks.

-   Update the publication and background quality report hyperlinks:

    - Set `pub_link` to the URL of the published report.
    - Set `names(pub_link)` to the text that should be displayed for the
    publication link.
    - Set `bqr_link` to the URL of the Background Quality Report, or equivalent
    quality information.
    - Set `names(bqr_link)` to the text that should be displayed for the quality
    report link.
    - ⚠️ Keep `class(pub_link) <- "hyperlink"` and
    `class(bqr_link) <- "hyperlink"` so that Excel recognises them as
    hyperlinks.

-   Set up the Contents sheet:

    - Update the publication title in the `writeData()` block that creates the
    Contents sheet so that it matches your publication.
    - Leave "Table of Contents" unchanged unless you want to use a different
    heading.
    - `cr <- 3` is the row counter used by `f_worksheet()` to add table names
    and hyperlinks to the Contents sheet automatically. Leave this value
    unchanged.
    - When using `f_worksheet()`, table links are added to the Contents sheet
    automatically as each worksheet is created.

-   Add worksheets using `f_worksheet()`:

    - The template contains commented examples showing how to create worksheets
    containing either a single table or multiple sub-tables.
    - Copy and adapt the relevant example, replacing the placeholder titles,
    descriptions, notes and data frame names with those required for your
    publication.
    - `f_worksheet()` automatically creates the worksheet, applies consistent
    formatting and adds hyperlinks to the Contents sheet.
    - For worksheets containing multiple sub-tables, such as Table 3a and Table
    3b, add each table as a separate item within the `tables` list.
    
-   Set the output filename:

    - Update `xl_template_filename` to give the workbook an appropriate
    filename.
    - By default, the workbook is saved in the `outputs` folder. Update the path
    only if the workbook needs to be saved elsewhere.
    
For a complete worked example using `f_worksheet()`, see 
`code/demo/demo_excel_tables_new.R`.

For more information on the `f_worksheet()` function, see the
**"How to use the `f_worksheet()` function"** section of this README.

The older `code/demo/demo_excel_tables.R` example demonstrates the alternative
`f_single_excel()` approach and is retained for reference.

</details>

<details>
  <summary><strong>Working with Git and GitHub</strong></summary>

If you created your project using the RAP Skeleton GitHub template, your local
RStudio project is connected to the publication repository on GitHub.

Git tracks changes made to the files within the repository, while GitHub
provides a shared location where those changes can be stored and reviewed by
other members of your team.

#### Before starting work

If other people are also working on the repository, it is good practice to pull
the latest changes from GitHub before starting work.

In RStudio, select **Pull** from the Git pane.

Alternatively, run the following command in the RStudio Terminal:

`git pull`

This retrieves changes that have been pushed to the current branch on GitHub and
integrates them into your local copy.

#### Making and reviewing changes

Work on the project normally in RStudio. Git will identify files that have been
added, modified or deleted.

You can view these changes in the Git pane in RStudio.

Before committing changes:

  1.  Save your files.
  2.  Review the files that Git identifies as changed.
  3.  Check that the project still runs as expected.
  4.  Run any appropriate quality assurance checks.
  5.  Run `styler` and `lintr` where appropriate to check the formatting of R
  code.

Avoid committing files containing sensitive or restricted data, passwords,
credentials or other information that should not be stored in GitHub.

#### Committing changes

A commit records a set of changes in the Git history of the project.

Using the RStudio Git pane:

  1.  Select the files you want to include in the commit.
  2.  Select **Commit**.
  3.  Review the changes shown in the commit window.
  4.  Enter a short, meaningful commit message describing the change.
  5.  Select **Commit**.

Alternatively, changes can be committed using the RStudio Terminal:

`git add -A`
`git commit -m "Update publication charts"`

Use commit messages that explain what has changed rather than vague descriptions
such as `"changes"` or `"update"`.

#### Pushing changes to GitHub

A commit initially exists only in your local repository. To send your committed
changes to GitHub, select **Push** from the Git pane in RStudio.

Alternatively, run:

`git push`

Once the push is complete, the committed changes will be available in the
corresponding branch of the GitHub repository.

#### Using branches

For substantial changes, it is recommended that you create a separate branch
rather than working directly on `main`.

Branches allow changes to be developed and tested separately from the main
version of the publication.

For example, a branch could be created for:

  -   updating publication content;
  -   adding or changing charts;
  -   updating branding;
  -   changing data processing;
  -   upgrading to a new RAP Skeleton version; or
  -   developing a new feature.

Use a short, descriptive branch name, for example:

`update-publication-content`

or:

`update-nisra-branding`

Once the work on the branch is complete:

  1.  Commit the changes.
  2.  Push the branch to GitHub.
  3.  Open a pull request on GitHub.
  4.  Review and test the changes.
  5.  Merge the pull request into `main` once the changes have been approved.

After the branch has been merged, switch back to `main` and pull the latest
version before beginning further work.

#### Working collaboratively

When several people work on the same publication repository:

  -   pull the latest changes before starting work;
  -   use separate branches for substantial pieces of work;
  -   make regular, meaningful commits;
  -   push your work to GitHub so that it is available to the rest of the team;
  -   use pull requests to review changes before merging them into `main`; and
  -   avoid having multiple people make substantial changes to the same files at
  the same time where possible.

If Git identifies conflicting changes to the same part of a file, these will
need to be reviewed and resolved before the changes can be merged.

#### Using Pull Requests

When several people work on a project, pull requests can be an important tool
for reviewing and implementing changes from different GitHub branches. Pull 
requests help by highlighting which parts of the code have been added to and 
modified. This makes it easier for reviewers to view the changes being made to
the codebase.

To create a pull request from a branch:

  - Click `Pull request`.
  - Then click the green button in the top right `New pull request`.
  - In the branch dropdown select your branch from the list of branches.
  - Then click the button `Create pull request`.
  
You can request specific contributors to review the changes. This helps to
streamline code review and makes it easier to identify and resolve issues before
changes are merged into `main`.

#### Working on an existing publication repository

If a publication repository already exists on GitHub, **do not create another**
**repository from the RAP Skeleton template**.

Instead, clone the existing publication repository.

  1.  Open the existing repository on GitHub.
  2.  Select the green **Code** button and copy the repository URL.
  3.  Open RStudio.
  4.  Select **File > New Project > Version Control > Git**.
  5.  Paste the repository URL into the **Repository URL** field.
  6.  Choose where the project should be stored locally.
  7.  Select **Create Project**.

RStudio will create a local copy of the existing repository and connect it to
the same GitHub repository used by the rest of the team.

After cloning an existing RAP Skeleton project, run:

`renv::restore()`

to install the package versions recorded in the project's `renv.lock` file.

#### Keeping your project up to date

GitHub template repositories are used to create independent repositories.
Updates made to the main RAP Skeleton repository are therefore
**not automatically applied** to publication repositories that were previously
created from it.

When a new version of the RAP Skeleton is released, follow the **Updating to**
**RAP Skeleton V4** guidance in this README rather than creating a new
publication repository.

</details>

<details>
  <summary><strong>Tidyverse style guide</strong></summary>

The tidyverse style guide provides a set of conventions for writing consistent,
readable and maintainable R code. The RAP Skeleton includes two packages that
can help apply and check these conventions:

-   [styler](https://styler.r-lib.org/) can automatically reformat R code to
follow tidyverse styling conventions. It can be applied to selected code,
individual files or entire projects and includes useful RStudio add-ins.

-   [lintr](https://github.com/r-lib/lintr) performs automated checks on R code
and identifies potential style, consistency and other code issues.

Both packages are included in the RAP Skeleton's renv lockfile and are loaded
through `config.R`.

#### Using styler

`styler` can automatically reformat many elements of your R code. To format the
file currently open in RStudio:

1.  Select **Addins** from the RStudio toolbar.
2.  Select **Style active file**.

Review the changes after running `styler` to make sure the code still appears as
expected.

Some issues identified by `lintr`, such as lines that exceed the configured
maximum length, may require manual changes and will not necessarily be corrected
by `styler`.

#### Using lintr

It is recommended that you run `lintr` before committing changes to GitHub. To
check the R files within the project, run the following command in the RStudio
Console:

```
lintr::lint_dir()
```

`lintr` will return any issues it identifies, including the relevant filename
and line number. Use this information to review and correct the code where
appropriate.

Run `lintr` after using `styler`, as `styler` does not automatically resolve
every issue that `lintr` may identify.

</details>

<details>
  <summary><strong>HTML Meta Tags for Search Engine Optimisation (SEO)</strong></summary>

The `meta.html` file contains metadata that provides search engines with
information about the content of the HTML report.

Update the description and keywords in `meta.html` so that they accurately
describe the subject of your publication, for example hospital waiting lists or
education statistics. This can help search engines understand and categorise the
content of the report.

</details>

<details>
  <summary><strong>Accessibility & Best Practices</strong></summary>

Accessibility should be considered throughout the development of an HTML report.
The RAP Skeleton includes accessible features and examples, but users should
also review their own content, charts, images and other additions.

- Follow a logical heading structure, for example **h1 > h2 > h3**, without
skipping heading levels.

- Provide appropriate `alt` text for images and infographics. Decorative images
should use empty alt text (`alt=""`). Avoid redundant phrases such as
`"Image of..."`.

- Use headings to identify sections and structure content rather than using
heading styles purely for visual formatting.

- Do not use bold text as a substitute for headings. Use the appropriate heading
level for headings and reserve bold or emphasised text for content that requires
additional importance or emphasis.

- Use colour combinations with sufficient contrast between text, graphical
elements and their backgrounds. Do not rely on colour alone to communicate
information.

- Use descriptive link text that explains the purpose or destination of the
link. For example, the
[NISRA Accessibility Statement](https://datavis.nisra.gov.uk/dissemination/accessibility-statement-visualisations.html)
is included in the footer of the RAP Skeleton.
 
- Avoid using images of text where real HTML text can be used instead.

- Ensure that content follows a logical reading order. Where more complex
layouts are used, check that the reading order remains meaningful when accessed
using assistive technology.

- Use appropriate HTML landmarks to identify the main areas of the page, such as
`<main>`, `<header>`, `<nav>` and `<footer>`, where applicable. See
`demo_report.Rmd` for examples.

- Include an accessibility contact or route for users to report accessibility
issues. See the bottom of `demo_report.Rmd` for an example.

#### Image requirements for accessibility

Images within HTML reports should be implemented so that their content and
purpose are accessible to users of assistive technology.

-   Informative images should have concise and meaningful `alt` text that
communicates their purpose or important content.
-   Decorative images should use empty alt text: `alt=""`. This allows screen
readers to ignore images that do not add meaningful information.
-   Avoid phrases such as `"Image of"` or `"Picture of"` in alt text, as screen
readers already identify the element as an image. For example, use
`alt="Joe Bloggs"` rather than `alt="Image of Joe Bloggs"`.

Examples:

For a decorative .svg image:

``` html
<img src="../images/decorative.svg" alt="">
```

For an informative .png image:

``` html
<img src="../images/nisra-logo.png" alt="NISRA logo">
```

Both PNG and SVG images can be used accessibly when implemented correctly.
However, SVG files containing text or complex information should be carefully
tested with assistive technology. If an SVG cannot be made sufficiently
accessible, consider providing the information as HTML text or using an
alternative image format with appropriate text alternatives.

</details>

<details>
  <summary><strong>Updating to RAP Skeleton V4</strong></summary>

The file structure of RAP Skeleton V4 is similar to previous versions and the
overall workflow remains largely unchanged. It is recommended that reports
created using previous versions are updated to V4.

Rather than manually adding individual V4 features to an older version of the
RAP Skeleton, use V4 as the new base and move your project-specific code and
content into it. This helps ensure that your project receives the latest
template, branding, accessibility and code improvements.

The steps below explain how to update an existing project while retaining its
existing Git history where applicable.

You will:

- Download the updated RAP Skeleton

- Move your project-specific code into the updated template.

- Replace the contents of your existing Git project with the updated template
while retaining the existing `.git` directory.

- Restore packages and commit the updated code.

#### 1. Before You Start

  1.  If your project is stored on GitHub:
    -   Open the existing project in RStudio.
    -   Commit any outstanding changes.
    -   Push the changes to GitHub.
    -   It is recommended that you create a new branch for the update, for
    example `rap-skeleton-v4-update`.

  2.  Close RStudio before replacing or moving project files.

  3.  Identify your existing project folder.
    -   If the project uses Git, this is the folder containing the hidden `.git`
    directory and usually a `.Rproj` file.
  
  4.  **⚠️ If your project uses Git, make sure hidden items are visible in**
  **File Explorer before continuing**.
      -    In File Explorer, select **View > Show > Hidden items**. The exact
      menu may vary depending on your version of Windows. Ensure this is set to 
      "Show hidden folders, files, or drives". 
      -    The `.git` folder is particularly important because it contains the
      Git information and history associated with your existing project.

#### 2. Download RAP Skeleton V4

  1. Go to the RAP Skeleton repository on GitHub.
  2. Download the latest V4 release as a **ZIP file** (via the green dropdown
  button labelled **Code** → **Download ZIP** or via the latest release).
  3. Extract the ZIP to a separate location on your computer (e.g.
  `C:/Users/.../rap-skeleton-4.0/`).

For the purposes of the instructions below, the extracted folder is referred to
as `rap-skeleton-4.0`.

Keep this folder separate from your existing project while preparing the update.

#### 3. Add your project-specific content to RAP Skeleton V4

Use the files in `rap-skeleton-4.0` as the new base for your project and
transfer the project-specific content from your existing version.

This may include:

-   Update the new V4 `config.R` with the configuration and publication metadata
required for your project.

-   Add any additional packages required by your project. Install packages
within the `renv` project as appropriate using `renv::install("pkg_name")` and
use `renv::snapshot()` to record the required package versions in `renv.lock`.

-   Copy any additional project-specific functions into the functions folder.
Take care not to overwrite updated V4 functions with older versions unless the
function contains changes that your publication specifically requires.

-   Copy any project-specific images into the appropriate `images` folder.

-   Transfer your data loading, processing and preparation code into the new V4
`data_prep.R`. V4 uses `here()` to construct project-relative file paths. For
example:

```
source(
  here(
    "code",
    "config.R"
  )
)
```
This avoids relying on working-directory-specific paths and makes file
references more consistent throughout the project.

-   Transfer the content of your existing report into the new V4 `report.Rmd`.

-   If your existing report uses child `.Rmd` files, copy these into the
appropriate project folder and check that they are called correctly from the new
V4 `report.Rmd`.

-   Transfer any other project-specific scripts, data or supporting files that
are still required.

When this process is complete, `rap-skeleton-4.0` should contain the updated V4
template together with the content and code specific to your publication.

#### 4. If storing your code on GitHub Replace Your Existing Git Project with the RAP Skeleton

If your project is stored on GitHub, retain the existing project folder so that
its `.git` directory and Git history are preserved.

For these instructions, the existing Git-connected project folder is referred to
as `YOUR_PROJECT`.

  1. Ensure that RStudio is closed.
  2. Open the `YOUR_PROJECT` folder in File Explorer.
  3. Delete the old RAP Skeleton files and folders that are being replaced, but
  **do not delete the `.git` folder**.
  You can also retain `.Rproj.user` if required, although this contains local
  RStudio project state rather than project source code.
  4. Open the prepared `rap-skeleton-4.0` folder from Step 3.
  5. Copy the updated files and folders **from `rap-skeleton-4.0` into**
  **`YOUR_PROJECT`**.
  6.  Rename the new `.Rproj` file within `YOUR_PROJECT` if required so that it
  uses an appropriate name for your project.

Your `YOUR_PROJECT` folder should now contain the V4 RAP Skeleton and your
project-specific content while retaining the existing `.git` directory and Git
history.

#### 5. Open the project and restore packages

  1. Open the project using the `.Rproj` file within `YOUR_PROJECT`.
  2. Ensure that you are using the required version of R for RAP Skeleton V4.
  **(R version 4.6.1)**
  3. Restore the package versions recorded in the V4 `renv.lock` file:
    
      - `renv::restore()`
    
  4.  If your project requires additional packages that are not included in the
  V4 lockfile, install these packages and then run:
  
      - `renv::snapshot()`

  5. Test the updated project thoroughly. This should include:
      - sourcing the main scripts;
      - running the required data preparation;
      - knitting the HTML report;
      - producing any accompanying Excel outputs;
      - checking that required packages load correctly; and
      - reviewing the completed outputs for any unexpected changes.

#### 6. Commit and push the V4 update

  1. If your project is stored on GitHub, review the changes carefully before
  committing them.
  2. You can use the Git pane in RStudio or the Terminal.
  3. To stage all changes:

      - Run this command in your Terminal in RStudio `git add -A`.
      **Or**
      - Manually stage changes in your Git pane

  4. Commit the changes with a clear message, for example:

      -  Run this command in your Terminal in RStudio
      `git commit -m "Update project to RAP Skeleton V4"`
       **Or**
      - Manually commit your changes through the button in RStudio and add an
      appropriate message.

  5. Push the changes to GitHub:
  
      - Run this command in your Terminal in RStudio `git push`
      **Or**
      - Manually push your changes through the button in RStudio.

  6. If the update was completed on a separate branch, open a pull request and
  review the changes before merging them into the main branch.

Once these steps are complete, your existing project will use RAP Skeleton V4
while retaining its existing Git history and project-specific content.

</details>

<details>
  <summary><strong>Updating from the Accessibility Template Exemplar</strong></summary>

The previously released Accessibility Template Exemplar has been superseded by
the RAP Skeleton. It is recommended that reports created using the Accessibility
Template Exemplar are updated to RAP Skeleton V4.

Follow the guidance in the **Updating to RAP Skeleton V4** section above to move
your existing project into the latest version of the RAP Skeleton. When
transferring content from the Accessibility Template Exemplar, also consider the
following:

-   Update the new `config.R` file with the configuration and publication
metadata required for your report.

-   If your existing project uses additional R packages that are not included in
RAP Skeleton V4, install these packages within the new `renv` environment and
use `renv::snapshot()` to record them in the project's `renv.lock` file.

-   Copy any additional functions created specifically for your publication into
the `functions` folder. Do not overwrite updated RAP Skeleton functions with
older versions from the Accessibility Template Exemplar unless your project
requires specific custom changes.

-   The header and footer in the RAP Skeleton are created using reusable
functions, with publication information and branding controlled through
`config.R`. Do not copy the old header and footer HTML from the Accessibility
Template Exemplar.

-   The Accessibility Template Exemplar included HTML code for elements such as
download buttons, page banners, the pre-release message and other report
features. These features are already incorporated into the RAP Skeleton and the
old HTML code should not be copied across.

-   Transfer your data loading, processing and preparation code into the new
`data_prep.R`. Unlike the Accessibility Template Exemplar, data preparation does
not need to be contained within R Markdown code chunks.

-   Transfer the publication content into the new `report.Rmd`. For larger
reports, content can also be organised into separate chapters using child
`.Rmd` files.

-   Review the completed HTML report after migration to ensure that the content,
styling, accessibility features and interactive elements continue to work as
expected.

If your existing project is stored on GitHub, follow the Git-specific steps in
the **Updating to RAP Skeleton V4** section to retain the project's existing Git
history while completing the update.

</details>

<details>
  <summary><strong>How to use the `f_worksheet()` function</strong></summary>

The `f_worksheet()` function simplifies the creation of Excel outputs by
automating much of the worksheet formatting, table placement and Contents sheet
setup that previously had to be coded manually.

A complete worked example is available in `code/demo/demo_excel_tables_new.R`.

This guide explains the main changes and how to use the new approach.

---

#### Overview of What’s Changed

| Feature | Old Workflow | New Workflow (`f_worksheet()`) |
|----------|---------------|--------------------------------|
| **Workbook creation** | Workbook and worksheets created manually | Workbook is created once and individual table worksheets are created by `f_worksheet()` |
| **Formatting** | Styles, row heights and column widths applied manually to each worksheet | Standard worksheet and table formatting is applied automatically|
| **Contents page** | Table names and hyperlinks added manually | Table entries and hyperlinks are added automatically when each `f_worksheet()` call is run |
| **Multiple tables per sheet** | Each table positioned and formatted manually | Multiple tables can be supplied within the `tables` list |
| **Notes** | Notes manually positioned and formatted | Notes supplied with each table are inserted automatically before the relevant table |
| **Missing values** | Styling handled manually | Missing values are identified and styled automatically |
| **Reusability** | Repeated `writeData()`, `writeDataTable()` and `addStyle()` code | Each worksheet can be created using a shorter, reusable function call |

---

#### Step-by-Step Guide

##### 1. Load and prepare the data

The data preparation process remains the same. Source the required data
preparation script before creating the workbook.

For example:

```r
library(here)

source(
  here(
    "code",
    "demo",
    "demo_data_prep.R"
  )
)
```
##### 2. Create the workbook

Create the workbook once and provide the metadata appropriate to your
publication:

```r
wb <- createWorkbook(
  creator = "NISRA Tech Lab",
  title = "Mid-year population statistics for Northern Ireland 2022",
  subject = "Mid-year population statistics for Northern Ireland",
  category = "Population"
)
```
Then apply base formatting (unchanged):

``` r
modifyBaseFont(
  wb,
  fontSize = 12,
  fontName = "Arial"
)
```

##### 3. Create the Introduction sheet

The Introduction sheet is created separately from `f_worksheet()` and should
contain the information required for your publication, including the publication
title, description, publication date, quality information and contact details.

The template includes `"PUBLICATION LINK"` and `"BQR LINK"` placeholders. Leave
these in the `intro_text` vector because they are used to identify the rows
where the hyperlinks should be written.

For example:

```r
intro_text <- c(
  "Mid-year population statistics for Northern Ireland 2022",
  "The following tables contain population and demography statistics for Northern Ireland...",
  "Linked report (and infographics):",
  "PUBLICATION LINK",
  "Published:",
  pub_date_words_dmy,
  "Quality Information:",
  "BQR LINK",
  "Contact Information:",
  "Joe Bloggs\nTechnology and Support Lab, NISRA\nColby House\nStranmillis Court\nBelfast, BT9 5RR\n\nTelephone: 028 1234 5678\nE-mail: techlab@nisra.gov.uk"
)
```

The publication and quality report hyperlinks are then created separately using
`pub_link` and `bqr_link`.

##### 4. Create the Contents sheet

Create the Contents worksheet before adding the individual table worksheets:

```r
addWorksheet(
  wb,
  sheetName = "Contents"
  )

writeData(
  wb,
  "Contents",
  x = c(
    "Mid-year population statistics for Northern Ireland 2022",
    "Table of Contents"
  )
)
```
The row counter:

`cr <- 3`

must also be set once before the first call to `f_worksheet()`.

Leave this value unchanged. `f_worksheet()` updates the counter automatically as
table entries and hyperlinks are added to the Contents sheet.

##### 5. Create worksheets using `f_worksheet()`

Each worksheet can now be created with a single call to `f_worksheet()`.

###### Example: One table per worksheet
```r
f_worksheet(
  wb,
  sheet_name = "Table_1",
  contents = paste0(
    "Table 1: Northern Ireland mid-year population estimates ",
    "by age group and sex, 2022"
  ),
  title = paste0(
    "Table 1: Northern Ireland mid-year population estimates ",
    "by age group and sex, 2022"
  ),
  outlining = paste0(
    "outlining mid-year population estimates by age group ",
    "and sex"
  ),
  tables = list(
    list(
      data = df_t1_ss,
      title = paste0(
        "Table 1: Northern Ireland mid-year population estimates ",
        "by age group and sex, 2022"
      ),
      note = paste0(
        "Notes: The estimates are produced using a variety of ",
        "data sources and statistical models"
      )
    )
  )
)
```

For a worksheet containing one table, `f_worksheet()` adds the worksheet
information, table, notes, formatting and Contents sheet hyperlink
automatically.

###### Example: multiple tables on one worksheet

If a worksheet contains more than one table, add each table as a separate item
within the tables list:

```r
f_worksheet(
  wb,
  sheet_name = "Table_3",
  contents = "Table 3: Population of under 25s and over 65s by LGD 2022",
  title = "Table 3: Population of under 25s and over 65s by LGD 2022",
  outlining = paste0(
    "outlining mid-year estimates of population aged under 25s ",
    "and over 65 by LGD"
  ),
  tables = list(
    list(
      data = df_t3a_ss,
      title = paste0(
        "Table 3a: Population of young people by LGD in ",
        "Northern Ireland 2022"
      ),
      note = c(
        "Notes:",
        paste0(
          "The estimates are produced using a variety of data ",
          "sources and statistical models"
        ),
        "Population aged under 25 on survey date",
        paste0(
          "Youthrate is percentage of under 25s rounded to ",
          "1 decimal place"
        )
      )
    ),
    list(
      data = df_t3b_ss,
      title = "Table 3b: Population of elderly people by LGD in NI",
      note = paste0(
        "Notes: The estimates are produced using a variety of ",
        "data sources and statistical models"
      )
    )
  )
)
```

When multiple tables are supplied, `f_worksheet()` automatically:

-   adds the worksheet title and description;
-   adds each sub-table title;
-   inserts notes before the relevant table;
-   applies consistent table formatting;
-   spaces the tables vertically;
-   adds the worksheet and sub-table links to the Contents sheet; and
-   formats missing values consistently.

##### 6. Save the workbook

Set an appropriate output filename and save the workbook:
```r
xl_filename <- here(
  "outputs",
  "RAP_template_tables.xlsx"
)

saveWorkbook(
  wb,
  xl_filename,
  overwrite = TRUE
)
```
##### Key benefits of `f_worksheet()`

-   **Automatic Contents sheet updates** – table names and hyperlinks are added
as worksheets are created.
-   **Consistent formatting** – worksheet titles, table headers, numeric cells,
row heights and column widths are formatted consistently.
-   **Simpler maintenance** – new worksheets can be added using short, reusable
function calls rather than repeated formatting code.
-   **Fewer hard-coded cell references** – worksheet positioning and Contents
links are calculated automatically.
-   **Support for single and multiple tables** – the same function can be used
for both layouts.
-   **Improved handling of notes and missing values** – notes and NA cells are
handled within the function.

For a complete example, see `code/demo/demo_excel_tables_new.R`. 

</details>

<details> 

  <summary><strong>How to use the `f_responsive_annotations()` function</strong></summary>
  
The `f_responsive_annotations()` function improves the readability of
annotations and axis labels on responsive Plotly charts.

The function checks the width of the chart and automatically adjusts the font
size of annotations and axis labels. This helps prevent text from becoming too
large or cluttered when a chart is displayed at a smaller size, for example on
a smaller screen or when the browser window is resized.

#### Using the function
  
After defining the annotations and layout for your Plotly chart, pipe the chart
into `f_responsive_annotations()`.

``` 
annotations = list(
      year1_lab,
      year2_lab,
      note_1,
      yaxistitle,
      note_2
    )
  ) |>
  # To add the broken axis symbol pipe the function "fn_break_axis" with
  # "linecolor" matching the colour given above. This function is a NISRA
  # created function that can be found in the functions folder.
  fn_break_axis(
    linecolor = "#000000",
    ref_line = vline(2009)
  ) |>
  # Adjust annotation and axis text sizes when the chart is resized
  f_responsive_annotations()

```
The function uses different font sizes depending on the width of the chart and
runs again when the browser window is resized.

#### Testing the function

To check that the function is working:

-   Knit the report and open the HTML output in a web browser.
-   Resize the browser window so that the Plotly chart becomes narrower or
wider.
-   Check that the annotation and axis label text adjusts as the chart width
changes.
-   Check that annotations remain readable and do not become unnecessarily
cluttered at smaller chart sizes.

Examples of `f_responsive_annotations()` can be found in Figures 1, 5 and 14 in
the `05_charts.Rmd` file of the demo report.

</details>

<details>

<summary><strong>tinyknit usage guide</strong></summary>

`tinyknit` provides an alternative way to knit R Markdown reports and can
produce smaller HTML output files than a standard self-contained render. This
can make completed reports easier to store, share and publish.

#### Setup 

The `tinyknit` package is included in the RAP Skeleton. If you need to install
it manually, it can be installed from the NISRA Tech Lab GitHub repository
using:

`renv::install("NISRA-Tech-Lab/tinyknit")`

If the package is added to an existing project, also add `library(tinyknit)` to
`config.R` and run:

`renv::snapshot()`

to record the package in the project's `renv.lock` file.

#### Using tinyknit

To knit a report using `tinyknit`:

  1.  Open the required `.Rmd` file in RStudio.
  2.  Select **Addins** from the RStudio toolbar.
  3.  Select the `tinyknit` option.

`tinyknit` will then:

  1.  Create a temporary `_tiny.Rmd` version of the report.
  2.  Render the temporary file to HTML.
  3.  Process the report dependencies to reduce the final HTML file size.
  4.  Save the completed output in a `<parent-folder>_outputs/` folder.
  5.  Open the completed report in your web browser.

The final HTML output will be:

  -   timestamped;
  -   smaller than a standard self-contained HTML output; and
  -   suitable for sharing or publishing.

For further information, see the
[tinyknit documentation](https://github.com/NISRA-Tech-Lab/tinyknit)

</details>

<details>
   
<summary><strong>Quality Assessment (QA) Report</strong></summary>
  
### What is the QA Report?

The RAP Skeleton includes a `qa_report.Rmd` template that can be used to
document quality assurance checks carried out on the data used within a
publication.

The template can be adapted to include the checks, tables, statistics and
supporting information appropriate to your publication.

A completed example is provided in `code/demo/demo_qa_report.Rmd` to demonstrate
how a QA report can be structured and the types of checks that can be included.

The demo QA report includes four main sections:

- **Overall Figures** - checks key figures used within the publication.
- **Compare Trends** - compares figures and trends over a specified time period
to help identify unexpected changes.
- **Count by Variables** - provides record counts broken down by selected
variables to help identify unexpected or missing values.
- **Suppression** - identifies where suppression is required or has been applied
to figures within publication tables.

These checks are provided as examples. Users should adapt the QA report and
include any additional quality assurance checks required for their own data and
publication.

</details>
