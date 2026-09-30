# ##############################################################################
# f_banner.R
# Creates HTML banner header for statistical reports with department logos and
# NISRA branding based on department
# #############################################################################

departmental_links <- c(
  dof = "https://www.finance-ni.gov.uk/",
  teo = "https://www.executiveoffice-ni.gov.uk/",
  daera = "https://www.daera-ni.gov.uk/",
  dfc = "https://www.communities-ni.gov.uk/",
  de = "https://www.education-ni.gov.uk/",
  dfe = "https://www.economy-ni.gov.uk/",
  dfi = "https://www.infrastructure-ni.gov.uk/",
  doh = "https://www.health-ni.gov.uk/",
  doj = "https://www.justice-ni.gov.uk/",
  bso = "https://bso.hscni.net/",
  adr = paste0(
    "https://www.adruk.org/about-us/",
    "working-as-a-partnership-is-fundamental-to-the-success-of-adr-uk/",
    "adr-northern-ireland/"
  )
)

if (
  exists("nics_theme") &&
    nics_theme %in% names(departmental_links)
) {
  departmental_link <- unname(
    departmental_links[nics_theme]
  )
} else {
  departmental_link <- NULL
}

f_banner <- function(
  title,
  subtitle = ""
) {
  div(
    div(
      style = paste0(
        "background-color: var(--nics-banner-borderline-colour-2); ",
        "height: 9px; ",
        "width: 100%;"
      )
    ),
    div(
      style = paste0(
        "background-color: var(--nics-banner-borderline-colour-1); ",
        "padding: 10px"
      ),
      div(
        class = "grid mtb",
        if (statistic_type == "as") {
          div(
            style = paste0(
              "display: flex; ",
              "justify-content: space-between; ",
              "align-items: center;"
            ),
            # Position nisra logo to the left
            div(
              style = paste0(
                "flex: 1; ",
                "display: flex; ",
                "justify-content: flex-start;"
              ),
              a(
                href = "https://nisra.gov.uk",
                img(
                  src = nisra_logo,
                  alt = "NISRA logo",
                  width = "220px"
                )
              )
            ),
            div(
              style = paste0(
                "flex: 1; ",
                "display: flex; ",
                "justify-content: center;"
              ),
              img(
                src = acc_official_stats,
                alt = nat_alt,
                width = "100px"
              )
            ),
            # Position the department logo to the right
            div(
              style = paste0(
                "flex: 1; ",
                "display: flex; ",
                "justify-content: flex-end;"
              ),
              a(
                href = departmental_link,
                img(
                  src = dep_logo,
                  alt = dep_alt,
                  width = "200px"
                )
              )
            )
          )
        } else {
          # If the national statistics logo isn't present space between
          # department and nisra logo
          div(
            style = paste0(
              "display: flex; ",
              "justify-content: space-between; ",
              "align-items: center;"
            ),
            a(
              href = "https://nisra.gov.uk",
              img(
                src = nisra_logo,
                alt = "NISRA homepage",
                width = "220px"
              )
            ),
            a(
              href = departmental_link,
              img(
                src = dep_logo,
                alt = dep_alt,
                width = "200px"
              )
            )
          )
        }
      ),
      div(
        style = paste0(
          "display: flex; ",
          "justify-content: center; ",
          "text-align: center;"
        ),
        h1(
          style = "color: #ffffff; font-size: 30px;",
          class = "toc-ignore",
          title
        )
      ),
      div(
        style = paste0(
          "font-size: 18px; ",
          "color: #ffffff; ",
          "display: flex; ",
          "justify-content: center; ",
          "text-align: center;"
        ),
        subtitle
      )
    ),
    div(
      style = paste0(
        "background-color: var(--nics-banner-borderline-colour-3); ",
        "height: 10px; ",
        "width: 100%;"
      )
    )
  )
}
