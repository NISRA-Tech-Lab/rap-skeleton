# Demo data prep

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

df_jbo <- read.csv(
  here(
    "code",
    "demo",
    "demo_data",
    "JBO-vacancies-data.csv"
  )
)

df_coc <- read_excel(
  here(
    "code",
    "demo",
    "demo_data",
    paste0(
      "local-government-districts-components-of-population-change-",
      "mid-2001-to-mid-2023.xlsx"
    )
  ),
  "Flat"
)

#### Creating variables for use in code and Rmd ####

earliest_year <- min(
  df_myes$mid_year_ending
)

latest_year <- max(
  df_myes$mid_year_ending
)

prev_year <- latest_year - 1

latest_fin_year <- paste0(
  latest_year - 1,
  "/",
  latest_year
)

prev_fin_year <- paste0(
  prev_year - 1,
  "/",
  prev_year
)

ni_earliest_total <- df_myes |>
  filter(
    mid_year_ending == earliest_year,
    gender != "All persons",
    age != "All persons"
  ) |>
  summarise(
    population = sum(
      population_estimate
    )
  ) |>
  pull(
    population
  ) /
  1000000

ni_latest_total <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender != "All persons",
    age != "All persons"
  ) |>
  summarise(
    population = sum(
      population_estimate
    )
  ) |>
  pull(
    population
  ) /
  1000000

ni_earliest_latest_change <-
  (ni_latest_total / ni_earliest_total - 1) * 100


#### General data frames for tables and charts ####

# adding age groups
df_myes <- df_myes |>
  mutate(
    age_group = case_when(
      age <= 24 ~ "0-24",
      age >= 25 & age <= 44 ~ "25-44",
      age >= 45 & age <= 64 ~ "45-64",
      age >= 65 ~ "65 plus"
    ),
    age_grp_5 = case_when(
      age <= 24 ~ "0-24",
      age >= 25 & age <= 44 ~ "25-44",
      age >= 45 & age <= 64 ~ "45-64",
      age >= 65 & age <= 84 ~ "65-84",
      age >= 85 ~ "85 plus"
    )
  )

# create df of annual population totals for NI (ni_pop_total) and average for
# lgd (lgd_pop_mean), filter for All persons, group by year and use these to
# calculate annual figs
df_annual_pop_tot <- df_myes |>
  filter(
    gender == "All persons"
  ) |>
  group_by(
    mid_year_ending
  ) |>
  summarise(
    ni_pop_total = sum(
      population_estimate
    ),
    lgd_pop_mean = mean(
      population_estimate
    )
  )

# pop by year and gender
df_mye_year_gender <- df_myes |>
  filter(
    gender != "All persons"
  ) |>
  group_by(
    mid_year_ending,
    gender
  ) |>
  summarise(
    mye_pop = sum(
      population_estimate
    )
  )

# pop by year and gender with added total col
df_mye_year_gender_t <- df_myes |>
  group_by(
    mid_year_ending,
    gender
  ) |>
  summarise(
    ni_pop_total = sum(
      population_estimate
    )
  ) |>
  pivot_wider(
    names_from = gender,
    values_from = ni_pop_total
  )

df_mye_year_gender_t <- df_mye_year_gender_t[
  c(
    1,
    3,
    4,
    2
  )
]


#### Latest year data frames for tables and charts ####

# latest year by gender
df_latest_year_gender <- filter(
  df_mye_year_gender,
  mid_year_ending == latest_year
)

# latest_year pop by age group and gender
df_mye_latest_year_agegrp_gend <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender != "All persons"
  ) |>
  group_by(
    age_group,
    gender
  ) |>
  summarise(
    pop_total = sum(
      population_estimate
    )
  )

# latest_year pop with 5 age groups and gender
df_mye_ltst_yr_5_age_grps_sex <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender != "All persons"
  ) |>
  group_by(
    age_grp_5,
    gender
  ) |>
  summarise(
    pop_total = sum(
      population_estimate
    )
  )

# add pct col
df_latest_year_agegrp_gend_pct <-
  df_mye_latest_year_agegrp_gend |>
  group_by(
    age_group
  ) |>
  mutate(
    pop_pct = pop_total / sum(pop_total) * 100
  ) |>
  select(
    -pop_total
  )

df_latest_year_agegrp_gend_pct <-
  pivot_wider(
    df_latest_year_agegrp_gend_pct,
    names_from = gender,
    values_from = pop_pct
  )

# latest year by age group only
df_mye_latest_year_agegroup <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons"
  ) |>
  group_by(
    age_group
  ) |>
  summarise(
    agegroup_total = sum(
      population_estimate
    )
  ) |>
  mutate(
    age_group = gsub(
      "-",
      " to ",
      age_group
    )
  )

# latest year in 5 age groups for pie chart
df_mye_latest_5_agegroups <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons"
  ) |>
  group_by(
    age_grp_5
  ) |>
  summarise(
    agegroup_total = sum(
      population_estimate
    )
  ) |>
  mutate(
    age_group = gsub(
      "-",
      " to ",
      age_grp_5
    )
  )

# latest_year tot pop by LGD
df_mye_latest_year_lgd <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    lgd_pop_total = sum(
      population_estimate
    )
  )

# latest_year pop by LGD and age group
df_mye_latest_year_lgd_agegrp <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name,
    age_group
  ) |>
  summarise(
    lgd_agegroup_tot = sum(
      population_estimate
    )
  )

# latest_year pop of under 25s by LGD
df_mye_latest_year_under25_lgd <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons",
    age_group == "0-24"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    under25_pop = sum(
      population_estimate
    )
  )

# latest_year pop of over 65s by LGD
df_mye_latest_year_over65_lgd <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons",
    age_group == "65plus"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    over65_pop = sum(
      population_estimate
    )
  )

# previous year pop by LGD
df_mye_previous_year_lgd <- df_myes |>
  filter(
    mid_year_ending == latest_year - 1,
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    lgd_pop_2021 = sum(
      population_estimate
    )
  )

# Join latest and previous years lgd pop dfs
# This code includes a rounding function called 'round_half_up'. This is the
# same as Excel rounding (i.e. values of .5 are rounded up). If you want to
# use the other form of rounding (odd number are rounded up, even numbers are
# rounded down),  use the R 'round' base function instead.
df_mye_latest_previous_lgd <- df_mye_latest_year_lgd |>
  inner_join(
    df_mye_previous_year_lgd
  ) |>
  mutate(
    change = lgd_pop_total - lgd_pop_2021
  ) |>
  mutate(
    pct_change = round_half_up(
      (lgd_pop_total - lgd_pop_2021) /
        lgd_pop_2021 * 100,
      1
    )
  )

# tidy column names for html
df_t4_html <- df_mye_latest_previous_lgd |>
  rename(
    "LGD" = lgd2014name,
    "2022 population" = lgd_pop_total,
    "2021 population" = lgd_pop_2021,
    "Change" = change,
    "Change (%)" = pct_change
  )

# latest year by LGD and 5-year age groups
df_mye_latest_5yr_age_lgd <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name,
    age_groups(
      age,
      split_at = "fives"
    )
  ) |>
  summarise(
    population_latest = sum(
      population_estimate
    )
  ) |>
  rename(
    age_group_5 = "age_groups(age, split_at = \"fives\")"
  )

# latest_year young rate rounded to 1dp using excel rounding function
df_mye_latest_year_youthrate <-
  df_mye_latest_year_under25_lgd |>
  inner_join(
    df_mye_latest_year_lgd
  ) |>
  mutate(
    youthrate = round_half_up(
      under25_pop / lgd_pop_total * 100,
      1
    )
  )

# latest_year elderly rate rounded to 1dp using excel rounding function
df_mye_latest_year_elderlyrate <-
  df_mye_latest_year_over65_lgd |>
  inner_join(
    df_mye_latest_year_lgd
  ) |>
  mutate(
    elderlyrate = round_half_up(
      over65_pop / lgd_pop_total * 100,
      1
    )
  )

# latest_year pop by age (single year) and gender
df_mye_latest_year_age_gender <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender != "All persons"
  ) |>
  group_by(
    age,
    gender
  ) |>
  summarise(
    pop_latest_year = sum(
      population_estimate
    )
  )

# latest year pop split, over or under 65, by gender
df_mye_latest_over_under_65 <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender != "All persons"
  ) |>
  mutate(
    age_65split = case_when(
      age <= 64 ~ "under 65",
      age >= 65 ~ "65 plus"
    )
  ) |>
  group_by(
    age_65split,
    gender
  ) |>
  summarise(
    pop = sum(
      population_estimate
    )
  ) |>
  pivot_wider(
    names_from = gender,
    values_from = pop
  )


#### Earliest year data frames for tables and charts ####

# earliest year by gender
df_earliest_year_gender <- filter(
  df_mye_year_gender,
  mid_year_ending == earliest_year
)

# earliest_year tot pop by LGD
df_mye_earliest_pop_lgd <- df_myes |>
  filter(
    mid_year_ending == earliest_year,
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    earliest_pop = sum(
      population_estimate
    )
  )

# earliest_year pop of under 25s by LGD
df_mye_earliest_under25_lgd <- df_myes |>
  filter(
    mid_year_ending == earliest_year,
    gender == "All persons",
    age_group == "0-24"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    under25_pop = sum(
      population_estimate
    )
  )

# join 2 earliest year dfs and calculate youth as percentage
df_mye_earliest_youthrate <- df_mye_earliest_under25_lgd |>
  inner_join(
    df_mye_earliest_pop_lgd
  ) |>
  mutate(
    earliest_youthrate = round_half_up(
      under25_pop / earliest_pop * 100,
      1
    )
  )


#### Excel data frame creation ####

# tidy for spreadsheets
df_t1_ss <- pivot_wider(
  df_mye_latest_year_agegrp_gend,
  names_from = age_group,
  values_from = pop_total
)

names(df_t1_ss) <- c(
  "Sex",
  "0 to 24",
  "25 to 44",
  "45 to 64",
  "65 plus"
)

# tidy column names for spreadsheet
df_t2_ss <- df_mye_latest_year_youthrate

names(df_t2_ss) <- c(
  "LGD",
  "Population under 25",
  "Total population",
  "Youth rate (%) [note 1]"
)

# tidy for spreadsheets
df_t3a_ss <- df_mye_latest_year_youthrate |>
  rename(
    "LGD" = lgd2014name,
    "Young people in LGD" = under25_pop,
    "Total population of LGD" = lgd_pop_total,
    "Young people as percentage" = youthrate
  )

# tidy for spreadsheets
df_t3b_ss <- df_mye_latest_year_elderlyrate |>
  rename(
    "LGD" = lgd2014name,
    "Elderly people in LGD" = over65_pop,
    "Total population of LGD" = lgd_pop_total,
    "Elderly people as percentage" = elderlyrate
  )


#### Chart download buttons data frame creation ####

# modify df for fig1 chart download buttons
df_fig1_xls <- df_annual_pop_tot |>
  select(
    mid_year_ending,
    ni_pop_total
  ) |>
  rename(
    "Mid year ending" = mid_year_ending,
    "NI population total" = ni_pop_total
  )

fig1_title <- paste0(
  "Figure 1: Northern Ireland mid year population estimate ",
  "(total) between ",
  earliest_year,
  " and ",
  latest_year
)

# modify df for fig2 chart download buttons
df_fig2_xls <- df_mye_year_gender_t |>
  select(
    -"All persons"
  ) |>
  rename(
    "Mid year ending" = mid_year_ending
  )

# modify df for fig3 downloads
df_fig3_xls <- pivot_wider(
  df_mye_latest_5yr_age_lgd,
  names_from = age_group_5,
  values_from = population_latest
) |>
  rename(
    LGD = lgd2014name
  )

colnames(df_fig3_xls) <- gsub(
  "-",
  " to ",
  colnames(df_fig3_xls)
)

# modify df for figs 4 and 5 chart downloads
df_fig4_5_xls <- df_mye_latest_year_youthrate |>
  select(
    lgd2014name,
    youthrate
  ) |>
  rename(
    "LGD" = lgd2014name,
    "Youth rate (%)" = youthrate
  )

# fig 6 download
df_fig6_xls <- pivot_wider(
  df_mye_latest_year_agegrp_gend,
  names_from = gender,
  values_from = pop_total
) |>
  mutate(
    age_group = gsub(
      "-",
      " to ",
      age_group
    )
  ) |>
  rename(
    "Age group" = age_group
  )

fig_15_data <- as.data.frame(
  state.x77
) |>
  tibble::rownames_to_column(
    "Local Government District"
  ) |>
  mutate(
    `Natural Change (births minus deaths)` = round(
      (`Life Exp` - 70) * 10,
      1
    ),
    `Net Migration & Other Changes` = round(
      (Income - mean(Income)) / 100,
      1
    ),
    `Total Percentage Change` =
      `Natural Change (births minus deaths)` + `Net Migration & Other Changes`
  ) |>
  arrange(
    `Total Percentage Change`
  )

fig_15_data_filtered <- fig_15_data |>
  slice_head(
    n = 5
  ) |>
  bind_rows(
    slice_tail(
      fig_15_data,
      n = 5
    )
  )

# tidy names for chart download
df_fig8_xls <- bind_rows(
  df_latest_year_gender,
  df_earliest_year_gender
) |>
  rename(
    "Mid year ending" = mid_year_ending,
    "Gender" = gender,
    "Population" = mye_pop
  )

# fig 7 for download
df_fig7_xls <- df_mye_latest_5_agegroups |>
  select(
    age_group,
    agegroup_total
  ) |>
  rename(
    "Age Group" = age_group,
    "Population" = agegroup_total
  )

# construct df for basic treemap fig 9
df_fig9 <- df_mye_ltst_yr_5_age_grps_sex |>
  filter(
    gender == "Females"
  ) |>
  ungroup()

ni_female_latest_tot <- sum(
  df_fig9$pop_total
)

df_fig9 <- df_fig9 |>
  add_row(
    age_grp_5 = "",
    gender = "NI",
    pop_total = ni_female_latest_tot
  )

# modify for download buttons
df_fig9_xls <- df_fig9 |>
  rename(
    "Age group" = age_grp_5,
    "Gender" = gender,
    "Population total" = pop_total
  )

# construct df for nested treemap fig 10
df_fig10 <- df_mye_latest_year_agegrp_gend |>
  ungroup()

df_fig10 <- df_fig10[
  order(df_fig10$gender),
] |>
  select(
    2,
    1,
    3
  )

# modify for download buttons
df_fig10_xls <- df_fig10 |>
  rename(
    "Gender" = gender,
    "Age group" = age_group,
    "Population total" = pop_total
  )

# fig 11 download
fig11_xls <- df_mye_latest_year_agegroup |>
  mutate(
    agegrp_pct = round_half_up(
      agegroup_total /
        sum(agegroup_total) * 100,
      1
    )
  ) |>
  rename(
    "Age group" = age_group,
    "Age group total" = agegroup_total,
    "Age group percent" = agegrp_pct
  )


#### Mini charts data frame creation for Key Points ####

# total pop for earliest year for mini chart
df_mini_population_earliest <- df_myes |>
  filter(
    mid_year_ending == earliest_year,
    gender != "All persons"
  ) |>
  group_by(
    mid_year_ending
  ) |>
  summarise(
    earliest_year = sum(
      population_estimate
    )
  ) |>
  rename(
    ni_pop_total = earliest_year
  ) |>
  ungroup()

# total pop for latest year for mini chart
df_mini_population_latest <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender != "All persons"
  ) |>
  group_by(
    mid_year_ending
  ) |>
  summarise(
    latest_year = sum(
      population_estimate
    )
  ) |>
  rename(
    ni_pop_total = latest_year
  ) |>
  ungroup()

# combining earliest and latest total pop in one df
df_mini_population <- rbind(
  df_mini_population_earliest,
  df_mini_population_latest
)

# creating the chart
minichart_population <- ggplot(
  df_mini_population,
  aes(
    mid_year_ending,
    ni_pop_total
  )
) +
  geom_bar(
    stat = "identity", # creates bar chart
    fill = c(
      nisra_navy,
      nisra_blue
    )
  ) + # colours for bars
  ggtitle(
    "NI Population"
  ) +
  xlab(
    ""
  ) +
  ylab(
    ""
  ) +
  # creates chart title and removes x and y axis labels
  geom_text(
    aes(
      label = format(
        ni_pop_total,
        big.mark = ","
      )
    ),
    color = c(
      "white",
      "white"
    ),
    vjust = 1.5,
    size = 6
  ) +
  # adds value labels to the bars and sets colours so they meet contrast
  # requirements
  scale_x_continuous(
    breaks = df_mini_population$mid_year_ending
  ) +
  scale_y_continuous(
    expand = c(
      0,
      0
    )
  ) + # starts y axis at 0
  theme_bw() +
  # removes gridlines, borders, y axis labels and markers and centres plot title
  theme(
    panel.grid = element_blank(),
    panel.border = element_blank(),
    text = element_text(
      size = 14
    ),
    axis.line.x = element_line(
      color = "black",
      linewidth = 0.5,
      linetype = "solid"
    ),
    axis.line.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.title = element_text(
      hjust = 0.5
    )
  )

# save as png to import into report
ggsave(
  here(
    "code",
    "demo",
    "demo_data",
    "images",
    "mini_population.png"
  ),
  plot = minichart_population,
  width = 6,
  height = 4
)

#### Read Maps in ####

# Simplified shapefile of NI councils.

df_lgd_map <- st_read(
  here(
    "code",
    "demo",
    "demo_data",
    "maps",
    "Simplified OSNI Map Loughs Removed.shp"
  ),
  quiet = TRUE
) |>
  rename(
    lgd2014name = LGDNAME,
    lgd2014 = LGDCode
  )


#### Create LGD data for maps ####

df_lgd_young <- df_myes |>
  filter(
    mid_year_ending == latest_year,
    gender == "All persons"
  ) |>
  mutate(
    under_25 = case_when(
      age < 25 ~ population_estimate,
      age >= 25 ~ 0
    )
  ) |>
  group_by(
    lgd2014,
    lgd2014name
  ) |>
  summarise(
    lgd_young = sum(under_25),
    lgd_total = sum(population_estimate)
  ) |>
  mutate(
    lgd_young_perc = round_half_up(
      lgd_young / lgd_total * 100,
      1
    )
  ) |>
  ungroup()

df_map_data <- merge(
  df_lgd_map,
  df_lgd_young
) |>
  mutate(
    lgd2014name_short = case_when(
      lgd2014name == "Antrim and Newtownabbey" ~ "AN",
      lgd2014name == "Ards and North Down" ~ "AND",
      lgd2014name == "Belfast" ~ "B",
      TRUE ~ lgd2014name
    ),
    map_label = str_wrap(
      paste0(
        lgd2014name_short,
        ": ",
        lgd_young_perc,
        "%"
      ),
      15
    ),
    map_label_value_only = paste0(
      lgd_young_perc,
      "%"
    )
  ) |>
  select(
    lgd2014name_short,
    lgd2014name,
    lgd_young_perc,
    map_label,
    map_label_value_only
  )


# construct df for nested treemap fig 9 - SUT Data

report_data <- loadWorkbook(
  here(
    "code",
    "demo",
    "demo_data",
    "report_data.xlsx"
  )
)

df_sut_report_data <- readWorkbook(
  report_data,
  sheet = "SUTs_report"
)

df_sut_report_data_prev_year <- readWorkbook(
  report_data,
  sheet = "SUTs_report (prev ref year)"
)

fig9_industry <-
  df_sut_report_data$Note.for.reference[215:224]

fig9_industry <- gsub(
  " GVA",
  "",
  fig9_industry
)

fig9_industry_value <- round_half_up(
  as.numeric(
    df_sut_report_data$Value[215:224]
  ),
  1
)

fig9_main <- data.frame(
  fig9_industry,
  fig9_industry_value
) |>
  mutate(
    fig9_industryPercent =
      fig9_industry_value / sum(fig9_industry_value) * 100
  ) |>
  mutate(
    fig9_industryLabel = paste0(
      fig9_industry,
      ": ",
      round_half_up(
        fig9_industryPercent,
        0
      ),
      "%"
    )
  )

fig9_industry <-
  df_sut_report_data$Additional.notes[266:327]

fig9_industry <- gsub(
  " GVA",
  "",
  fig9_industry
)

fig9_sub_industry <-
  df_sut_report_data$Note.for.reference[266:327]

fig9_sub_industry_value <- round_half_up(
  as.numeric(
    df_sut_report_data$Value[266:327]
  ),
  1
)

fig9new <- data.frame(
  fig9_industry,
  fig9_sub_industry,
  fig9_sub_industry_value
) |>
  mutate(
    Percent =
      fig9_sub_industry_value / sum(fig9_sub_industry_value) * 100
  )

industry_labels <- fig9_main |>
  select(
    fig9_industry,
    fig9_industryLabel
  )

fig9 <- fig9new |>
  left_join(
    industry_labels,
    by = "fig9_industry"
  )

tmap_labels_9 <- c(
  "NI Gross Value Added by Industry",
  unique(
    fig9$fig9_industryLabel
  ),
  fig9$fig9_sub_industry
)

tmap_parents_9 <- c(
  "",
  rep(
    "NI Gross Value Added by Industry",
    length(
      unique(
        fig9$fig9_industry
      )
    )
  ),
  fig9$fig9_industryLabel
)

tmap_values_9 <- c(
  rep(
    0,
    length(
      unique(
        fig9$fig9_industry
      )
    ) + 1
  ),
  round_half_up(
    fig9$Percent,
    2
  )
)

tmap_values_9_lab <- c(
  rep(
    0,
    length(
      unique(
        fig9$fig9_industry
      )
    ) - 9
  ),
  round_half_up(
    fig9_main$fig9_industryPercent,
    2
  ),
  round_half_up(
    fig9$Percent,
    2
  )
)

target_labels <- c(
  "Distribution, transport, hotels and restaurants: 21%",
  "Financial and insurance: 4%",
  "Agriculture: 2%",
  "Construction: 8%"
)

tmap_textcolours <- ifelse(
  tmap_labels_9 %in% target_labels |
    tmap_parents_9 %in% target_labels,
  "black",
  "white"
)

industry_labels_dl <- fig9_main |>
  select(
    fig9_industry,
    fig9_industry_value,
    fig9_industryPercent
  )

fig9_dl <- fig9new |>
  left_join(
    industry_labels_dl,
    by = "fig9_industry"
  )

colnames(fig9_dl) <- c(
  "Broad Industry",
  "Industry",
  paste0(
    df_sut_report_data$Value[1],
    " Industry GVA Value (£ million)"
  ),
  paste0(
    df_sut_report_data$Value[1],
    " Industry GVA Percentage"
  ),
  paste0(
    df_sut_report_data$Value[1],
    " Broad Industry GVA Value (£ million)"
  ),
  paste0(
    df_sut_report_data$Value[1],
    " Broad Industry GVA Percentage"
  )
)

fig9_dl <- fig9_dl |>
  select(
    1,
    5,
    6,
    2,
    3,
    4
  )

# highest gva Industry - used to populate Figure 9 title
highest_gva_industry <- as.character(
  fig9_main[
    which.max(
      fig9_main[, 3]
    ),
    1
  ]
)


## Structure Report Figure 3 Previous year

fig9_industry_prev <-
  df_sut_report_data_prev_year$Note.for.reference[2:11]

fig9_industry_prev <- gsub(
  " GVA",
  "",
  fig9_industry_prev
)

fig9_industry_value_prev <- round_half_up(
  as.numeric(
    df_sut_report_data_prev_year$Value[2:11]
  ),
  1
)

fig9_mainprev <- data.frame(
  fig9_industry_prev,
  fig9_industry_value_prev
) |>
  mutate(
    fig9_industryPercentprev =
      fig9_industry_value_prev / sum(fig9_industry_value_prev) * 100
  ) |>
  mutate(
    fig9_industryLabelprev = paste0(
      fig9_industry_prev,
      ": ",
      round_half_up(
        fig9_industryPercentprev,
        0
      ),
      "%"
    )
  )

fig9_industry_prev <-
  df_sut_report_data_prev_year$Additional.notes[12:73]

fig9_industry_prev <- gsub(
  " GVA",
  "",
  fig9_industry_prev
)

fig9_sub_industry_prev <-
  df_sut_report_data_prev_year$Note.for.reference[12:73]

fig9_sub_industry_value_prev <- round_half_up(
  as.numeric(
    df_sut_report_data_prev_year$Value[12:73]
  ),
  1
)

fig9newprev <- data.frame(
  fig9_industry_prev,
  fig9_sub_industry_prev,
  fig9_sub_industry_value_prev
) |>
  mutate(
    Percentprev =
      fig9_sub_industry_value_prev / sum(fig9_sub_industry_value_prev) * 100
  )

industry_labels_prev <- fig9_mainprev |>
  select(
    fig9_industry_prev,
    fig9_industryLabelprev
  )

fig9prev <- fig9newprev |>
  left_join(
    industry_labels_prev,
    by = "fig9_industry_prev"
  )

tmap_labels_9prev <- c(
  "NI Gross Value Added by Industry",
  unique(
    fig9prev$fig9_industryLabelprev
  ),
  fig9prev$fig9_sub_industry_prev
)

tmap_parents_9prev <- c(
  "",
  rep(
    "NI Gross Value Added by Industry",
    length(
      unique(
        fig9prev$fig9_industry_prev
      )
    )
  ),
  fig9prev$fig9_industryLabelprev
)

tmap_values_9prev <- c(
  rep(
    0,
    length(
      unique(
        fig9prev$fig9_industry_prev
      )
    ) + 1
  ),
  round_half_up(
    fig9prev$Percentprev,
    2
  )
)

tmap_values_9prev_lab <- c(
  rep(
    0,
    length(
      unique(
        fig9prev$fig9_industry_prev
      )
    ) - 9
  ),
  round_half_up(
    fig9_mainprev$fig9_industryPercentprev,
    2
  ),
  round_half_up(
    fig9prev$Percentprev,
    2
  )
)

industry_labels_prev_dl <- fig9_mainprev |>
  select(
    fig9_industry_prev,
    fig9_industry_value_prev,
    fig9_industryPercentprev
  )

fig9prev_dl <- fig9newprev |>
  left_join(
    industry_labels_prev_dl,
    by = "fig9_industry_prev"
  )

colnames(fig9prev_dl) <- c(
  "Broad Industry",
  "Industry",
  paste0(
    df_sut_report_data$Value[2],
    " Industry GVA Value (£ million)"
  ),
  paste0(
    df_sut_report_data$Value[2],
    " Industry GVA Percentage"
  ),
  paste0(
    df_sut_report_data$Value[2],
    " Broad Industry GVA Value (£ million)"
  ),
  paste0(
    df_sut_report_data$Value[2],
    " Broad Industry GVA Percentage"
  )
)

fig9prev_dl <- fig9prev_dl |>
  select(
    1,
    5,
    6,
    2,
    3,
    4
  )


#### Fig 12 population pyramid data frame creation

fig_12_data <- df_myes |>
  group_by(
    mid_year_ending,
    gender,
    age
  ) |>
  summarise(
    MYE = sum(population_estimate),
    .groups = "drop"
  ) |>
  mutate(
    area_name = "NORTHERN IRELAND"
  ) |>
  select(
    area_name,
    everything()
  ) |>
  filter(
    mid_year_ending %in% c(
      latest_year - 10,
      latest_year
    ),
    gender != "All persons"
  ) |>
  arrange(
    desc(mid_year_ending),
    gender
  ) |>
  mutate(
    MYE = case_when(
      gender == "Females" ~ MYE * -1,
      TRUE ~ MYE
    )
  ) |>
  pivot_wider(
    id_cols = age,
    names_from = c(
      gender,
      mid_year_ending
    ),
    names_sep = " ",
    values_from = MYE
  ) |>
  rename(
    "Age" = age
  )

fig_12_xl <- fig_12_data |>
  mutate(
    across(
      matches("Females"),
      ~ . * -1
    ),
    across(
      -Age,
      ~ . / 1000
    )
  ) |>
  rename_with(
    ~ {
      # Split column names into sex and year
      sex_year <- str_match(
        .,
        "^(Females|Males)\\s+(\\d{4})$"
      )

      sex <- sex_year[, 2]
      year <- sex_year[, 3]

      # Construct new name: Population (Thousands)\n{Sex} mid-{Year}
      paste0(
        "Population (Thousands)\n",
        sex,
        " mid-",
        year
      )
    },
    .cols = -Age
  ) |>
  adorn_totals(
    name = "All Ages"
  )


#### Fig 13 components of change flow chart

pop_ni_current <- df_coc |>
  filter(
    area_name == "NORTHERN IRELAND",
    category == "End population",
    year == latest_fin_year
  ) |>
  pull(
    MYE
  )

pop_ni_last <- df_coc |>
  filter(
    area_name == "NORTHERN IRELAND",
    category == "End population",
    year == prev_fin_year
  ) |>
  pull(
    MYE
  )

pop_ni_current_rounded <- prettyNum(
  round_half_up(
    pop_ni_current / 100
  ) * 100,
  big.mark = ","
)

pop_ni_last_rounded <- prettyNum(
  round_half_up(
    pop_ni_last / 100
  ) * 100,
  big.mark = ","
)

natural_change <- df_coc |>
  filter(
    area_name == "NORTHERN IRELAND",
    year == latest_fin_year,
    category == "Natural Change"
  ) |>
  pull(
    MYE
  )

natural_change_rounded <- prettyNum(
  round_half_up(
    natural_change / 100
  ) * 100,
  big.mark = ","
)

natural_change_sign <- paste0(
  if (natural_change > 0) "+",
  natural_change_rounded
)

net_migration <- df_coc |>
  filter(
    area_name == "NORTHERN IRELAND",
    year == latest_fin_year,
    category == "Total Net"
  ) |>
  pull(
    MYE
  )

net_migration_rounded <- prettyNum(
  round_half_up(
    net_migration / 100
  ) * 100,
  big.mark = ","
)

net_migration_sign <- paste0(
  if (natural_change > 0) "+",
  net_migration_rounded
)

other_changes <- df_coc |>
  filter(
    area_name == "NORTHERN IRELAND",
    year == latest_fin_year,
    category == "Other changes"
  ) |>
  pull(
    MYE
  )

other_changes_rounded <- prettyNum(
  round_half_up(
    abs(other_changes) / 100
  ) * 100,
  big.mark = ","
)

other_changes_sign <- paste0(
  if (other_changes > 0) "+" else "-",
  other_changes_rounded
)


#### Fig 14 population change by age filled line chart

year_minus_four <- latest_year - 4

fig_14_data <- df_myes |>
  filter(
    mid_year_ending %in% year_minus_four:latest_year,
    gender == "All persons"
  ) |>
  select(
    -gender,
    -age,
    -lgd2014,
    -age_group
  ) |>
  group_by(
    mid_year_ending,
    age_grp_5
  ) |>
  summarise(
    MYE = sum(population_estimate),
    .groups = "drop"
  ) |>
  mutate(
    area_name = "NORTHERN IRELAND"
  ) |>
  group_by(
    mid_year_ending
  ) |>
  mutate(
    total_mye_year = sum(MYE)
  ) |>
  mutate(
    pct = MYE / total_mye_year * 100
  ) |>
  ungroup() |>
  select(
    area_name,
    everything()
  ) |>
  arrange(
    age_grp_5
  ) |>
  mutate(
    index = row_number(),
    label = case_when(
      mid_year_ending %in% c(
        2018,
        2022
      ) ~ mid_year_ending,
      TRUE ~ NA
    )
  )

fig_14_data_xl <- fig_14_data |>
  mutate(
    Year = mid_year_ending,
    `Age Group` = case_when(
      age_grp_5 == "85plus" ~ "85 and over",
      TRUE ~ age_grp_5
    ),
    `Proportion of population (%)` = round_half_up(
      pct,
      1
    ),
    .keep = "none"
  )

############################################
########## QA Report Variables #############
############################################

total_records_myes <- nrow(
  df_myes
)

population_est_2001 <- df_myes |>
  filter(
    mid_year_ending == 2001,
    gender == "All persons"
  ) |>
  summarise(
    total_pop_2001 = sum(
      population_estimate
    )
  ) |>
  pull(
    total_pop_2001
  )

population_est_2022 <- df_myes |>
  filter(
    mid_year_ending == 2022,
    gender == "All persons"
  ) |>
  summarise(
    total_pop_2022 = sum(
      population_estimate
    )
  ) |>
  pull(
    total_pop_2022
  )

df_latest_year_age_group_clean <-
  df_mye_latest_year_agegroup |>
  rename(
    Population = agegroup_total,
    `Age group` = age_group
  ) |>
  mutate(
    Population = format(
      Population,
      big.mark = ","
    )
  )

# earliest year by age group only
df_mye_earliest_year_agegroup <- df_myes |>
  filter(
    mid_year_ending == earliest_year,
    gender == "All persons"
  ) |>
  group_by(
    age_group
  ) |>
  summarise(
    agegroup_total = sum(
      population_estimate
    )
  ) |>
  mutate(
    age_group = gsub(
      "-",
      " to ",
      age_group
    )
  ) |>
  rename(
    Population = agegroup_total,
    `Age group` = age_group
  ) |>
  mutate(
    Population = format(
      Population,
      big.mark = ","
    )
  )

df_mye_latest_ldg_cleaned <- df_mye_latest_year_lgd |>
  rename(
    `LGD (2014 name)` = lgd2014name,
    Population = lgd_pop_total
  ) |>
  mutate(
    Population = format(
      Population,
      big.mark = ","
    )
  )

df_mye_earliest_ldg <- df_myes |>
  filter(
    mid_year_ending == earliest_year,
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name
  ) |>
  summarise(
    lgd_pop_total = sum(
      population_estimate
    )
  ) |>
  rename(
    `LGD (2014 name)` = lgd2014name,
    Population = lgd_pop_total
  ) |>
  mutate(
    Population = format(
      Population,
      big.mark = ","
    )
  )

df_latest_year_gender_cleaned <- df_latest_year_gender |>
  ungroup() |>
  select(
    gender,
    mye_pop
  ) |>
  rename(
    Gender = gender,
    Population = mye_pop
  ) |>
  adorn_totals(
    "row",
    name = "Total"
  ) |>
  mutate(
    Population = format(
      Population,
      big.mark = ","
    )
  )

prev_and_current_lgd_breakdown <- df_myes |>
  filter(
    mid_year_ending %in% c(
      latest_year,
      latest_year - 1
    )
  ) |>
  group_by(
    lgd2014name,
    mid_year_ending,
    gender
  ) |>
  summarise(
    lgd_pop_total = sum(
      population_estimate
    ),
    .groups = "drop"
  ) |>
  pivot_wider(
    names_from = mid_year_ending,
    values_from = lgd_pop_total
  ) |>
  rename(
    LGD = lgd2014name
  ) |>
  mutate(
    Change =
      .data[[as.character(
        latest_year
      )]] - .data[[as.character(
        latest_year - 1
      )]],
    `Percentage Change` = round(
      100 *
        (
          .data[[as.character(latest_year)]] -
            .data[[as.character(latest_year - 1)]]
        ) /
        .data[[as.character(latest_year - 1)]],
      1
    )
  ) |>
  mutate(
    across(
      all_of(
        c(
          as.character(latest_year - 1),
          as.character(latest_year),
          "Change"
        )
      ),
      ~ format(
        .x,
        big.mark = ",",
        scientific = FALSE
      )
    )
  )

prev_curr_lgd_breakdown_male <-
  prev_and_current_lgd_breakdown |>
  filter(
    gender == "Males"
  ) |>
  arrange(
    desc(`Percentage Change`)
  ) |>
  head(
    n = 3
  ) |>
  select(
    -gender
  )

prev_curr_lgd_breakdown_female <-
  prev_and_current_lgd_breakdown |>
  filter(
    gender == "Females"
  ) |>
  arrange(
    desc(`Percentage Change`)
  ) |>
  head(
    n = 3
  ) |>
  select(
    -gender
  )

df_mye_curr_prev_population <- df_myes |>
  # Myes only goes up to 2022
  filter(
    mid_year_ending %in% c(
      latest_year,
      latest_year - 1
    ),
    gender == "All persons"
  ) |>
  group_by(
    lgd2014name,
    mid_year_ending
  ) |>
  summarise(
    population_estimate = sum(
      population_estimate,
      na.rm = TRUE
    ),
    .groups = "drop_last"
  ) |>
  pivot_wider(
    names_from = mid_year_ending,
    values_from = population_estimate
  ) |>
  mutate(
    `Percentage Change` = round(
      (
        (
          .data[[as.character(latest_year)]] -
            .data[[as.character(latest_year - 1)]]
        ) /
          .data[[as.character(latest_year - 1)]]
      ) * 100,
      2
    ),
    `Above Threshold` =
      abs(`Percentage Change`) > 0.5,
    across(
      where(is.numeric),
      ~ format(
        .x,
        big.mark = ","
      )
    )
  ) |>
  rename(
    `LGD (2014 name)` = lgd2014name
  )
