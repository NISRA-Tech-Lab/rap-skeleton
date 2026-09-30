# ##############################################################################
# f_footer.R
# Generates a standardised NISRA footer with links to tools, corporate pages,
# social media icons, and legal/accessibility information.
# ##############################################################################

f_footer <- function() {
  fb_path <- here::here(
    "data",
    "images",
    "facebook-brands-solid-full.svg"
  )

  tw_path <- here::here(
    "data",
    "images",
    "x-twitter-brands-solid-full.svg"
  )

  yt_path <- here::here(
    "data",
    "images",
    "youtube-brands-solid-full.svg"
  )

  li_path <- here::here(
    "data",
    "images",
    "linkedin-in-brands-solid-full.svg"
  )

  ig_path <- here::here(
    "data",
    "images",
    "instagram-brands-solid-full.svg"
  )

  facebook_src <- knitr::image_uri(fb_path)
  twitter_src <- knitr::image_uri(tw_path)
  youtube_src <- knitr::image_uri(yt_path)
  linkedin_src <- knitr::image_uri(li_path)
  instagram_src <- knitr::image_uri(ig_path)

  linkedin_url <- paste0(
    "https://www.linkedin.com/company/",
    "northern-ireland-statistics-and-research-agency/"
  )

  accessibility_url <- paste0(
    "https://datavis.nisra.gov.uk/dissemination/",
    "accessibility-statement-visualisations.html"
  )

  htmltools::HTML(
    sprintf(
      '
<footer class="nisra-footer">
  <div class="footer-container">
    <div class="footer-row">

      <div class="footer-col">
        <h3
          style="
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            margin-top: 0;
          "
        >
          Data Tools
        </h3>

        <ul class="footer-list">
          <li>
            <a href="https://explore.nisra.gov.uk/local-stats/">
              Local Statistics Explorer
            </a>
          </li>
          <li>
            <a href="https://data.nisra.gov.uk">
              Data Portal
            </a>
          </li>
          <li>
            <a href="https://build.nisra.gov.uk/en/">
              Census Flexible Table Builder
            </a>
          </li>
        </ul>
      </div>

      <div class="footer-col">
        <h3
          style="
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            margin-top: 0;
          "
        >
          Corporate
        </h3>

        <ul class="footer-list">
          <li>
            <a href="https://www.nisra.gov.uk/">
              NISRA Website
            </a>
          </li>
          <li>
            <a href="https://www.nisra.gov.uk/about-us/careers">
              Careers
            </a>
          </li>
          <li>
            <a href="https://www.nisra.gov.uk/contact">
              Contact
            </a>
          </li>
        </ul>
      </div>

      <div class="footer-col">
        <h3
          style="
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            margin-top: 0;
          "
        >
          Follow NISRA
        </h3>

        <ul class="footer-social">
          <li>
            <a href="https://www.facebook.com/nisra.gov.uk">
              <img
                src="%s"
                alt="NISRA Facebook"
                role="img"
                class="img"
              />
            </a>
          </li>

          <li>
            <a href="https://x.com/NISRA/">
              <img
                src="%s"
                alt="NISRA X"
                role="img"
                class="img"
              />
            </a>
          </li>

          <li>
            <a href="https://www.youtube.com/user/nisrastats">
              <img
                src="%s"
                alt="NISRA YouTube"
                role="img"
                class="img"
              />
            </a>
          </li>

          <li>
            <a href="%s">
              <img
                src="%s"
                alt="NISRA LinkedIn"
                role="img"
                class="img"
              />
            </a>
          </li>

          <li>
            <a href="https://www.instagram.com/nisra.gov.uk/">
              <img
                src="%s"
                alt="NISRA Instagram"
                role="img"
                class="img-50"
              />
            </a>
          </li>
        </ul>
      </div>
    </div>

    <ul class="footer-links">
      <li>
        <a href="https://www.nisra.gov.uk/crown-copyright">
          © Crown Copyright
        </a>
      </li>
      <li>|</li>

      <li>
        <a href="https://www.nisra.gov.uk/terms-and-conditions">
          Terms and conditions
        </a>
      </li>
      <li>|</li>

      <li>
        <a href="https://www.nisra.gov.uk/cookies">
          Cookies
        </a>
      </li>
      <li>|</li>

      <li>
        <a href="https://www.nisra.gov.uk/nisra-privacy-notice">
          Privacy
        </a>
      </li>
      <li>|</li>

      <li>
        <a href="%s">
          Accessibility Statement
        </a>
      </li>
    </ul>
  </div>
</footer>
',
      facebook_src,
      twitter_src,
      youtube_src,
      linkedin_url,
      linkedin_src,
      instagram_src,
      accessibility_url
    )
  )
}
