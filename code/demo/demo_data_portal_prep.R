library(here)

source(
  here(
    "code",
    "demo",
    "demo_config.R"
  )
)

df_myes <- read.csv(
  here(
    "code",
    "demo",
    "demo_data",
    paste0(
      "local-government-districts-by-single-year-of-age-and-gender-",
      "mid-2001-to-mid-2022.csv"
    )
  )
) |>
  rename(
    lgd2014name = Geo_Name,
    lgd2014 = Geo_Code
  )

names(df_myes) <- tolower(
  names(df_myes)
)

df_mye_dp <- df_myes |>
  select(
    -lgd2014name
  ) |>
  rename(
    "TLIST(A1)" = mid_year_ending,
    LGD2014 = lgd2014,
    Sex = gender,
    Age = age,
    VALUE = population_estimate
  ) |>
  mutate(
    Sex = case_when(
      Sex == "All persons" ~ "All",
      Sex == "Females" ~ "1",
      Sex == "Males" ~ "2"
    )
  ) |>
  mutate(
    Age = as.character(Age) # Convert entire column to character
  ) |>
  mutate(
    Age = case_when(
      Age == "90" ~ "90+",
      TRUE ~ Age # keep other values unchanged
    )
  )

# 1. Add NI totals by Age
ni_by_age <- df_mye_dp |>
  group_by(
    `TLIST(A1)`,
    Sex,
    Age
  ) |>
  summarise(
    VALUE = sum(
      VALUE,
      na.rm = TRUE
    ),
    .groups = "drop"
  ) |>
  mutate(
    LGD2014 = "N92000002"
  )

# 2. Add NI totals across all ages
ni_all_ages <- df_mye_dp |>
  group_by(
    `TLIST(A1)`,
    Sex
  ) |>
  summarise(
    VALUE = sum(
      VALUE,
      na.rm = TRUE
    ),
    .groups = "drop"
  ) |>
  mutate(
    Age = "All",
    LGD2014 = "N92000002"
  )

# 3. Add "All ages" rows for each LGD2014 as well
lgd_all_ages <- df_mye_dp |>
  group_by(
    `TLIST(A1)`,
    LGD2014,
    Sex
  ) |>
  summarise(
    VALUE = sum(
      VALUE,
      na.rm = TRUE
    ),
    .groups = "drop"
  ) |>
  mutate(
    Age = "All"
  )

# Combine everything
df_mye_dp <- bind_rows(
  df_mye_dp,
  ni_by_age,
  ni_all_ages,
  lgd_all_ages
)

# Define desired ordering for Age and Sex
age_levels <- df_mye_dp |>
  distinct(
    Age
  ) |>
  mutate(
    ord = case_when(
      Age == "All" ~ 9999L,
      Age == "90+" ~ 999L,
      TRUE ~ suppressWarnings(
        as.integer(Age)
      )
    )
  ) |>
  arrange(
    ord
  ) |>
  pull(
    Age
  )

sex_levels <- c(
  "All",
  "1",
  "2"
)

df_mye_dp <- df_mye_dp |>
  # Add STATISTIC column
  mutate(
    STATISTIC = "MYE",
    Age = factor(
      Age,
      levels = age_levels,
      ordered = TRUE
    ),
    Sex = factor(
      Sex,
      levels = sex_levels,
      ordered = TRUE
    )
  ) |>
  # Reorder columns
  select(
    STATISTIC,
    `TLIST(A1)`,
    LGD2014,
    Age,
    Sex,
    VALUE
  ) |>
  # Sort by grouping to enforce the Age and Sex orders
  arrange(
    `TLIST(A1)`,
    LGD2014,
    Sex,
    Age
  )
