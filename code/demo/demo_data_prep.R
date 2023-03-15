# Demo data prep

library(here)

source(paste0(here(),"/code/config.R"))
source(paste0(here(),"/code/demo/demo_config.R"))

df_myes = read.csv(paste0(project_root,
          "/code/demo/demo_data/local-government-districts-by-single-year-of-age-and-gender-mid-2001-to-mid-2019.csv")) %>%
  rename(lgd2014name = Geo_Name, lgd2014 = Geo_Code)

names(df_myes) = tolower(names(df_myes))


#### Creating variables for use in code and Rmd ####
earliest_year = min(df_myes$mid_year_ending)
latest_year = max(df_myes$mid_year_ending)

ni_earliest_total = df_myes %>%
  filter(mid_year_ending == earliest_year &  gender != "All persons" &  age != "All persons")  %>% 
  summarise(sum(population_estimate)) / 1000000

ni_latest_total = df_myes %>%
  filter(mid_year_ending == latest_year &  gender != "All persons" &  age != "All persons")  %>% 
  summarise(sum(population_estimate))/ 1000000

ni_earliest_latest_change = (ni_latest_total/ni_earliest_total - 1) * 100

#### General data frames for tables and charts ####

# adding age groups
df_myes <- mutate(df_myes,
                  age_group = case_when(age <= 24 ~ "0-24",
                                        age >= 25 & age <= 44 ~ "25-44",
                                        age >= 45 & age <= 64 ~ "45-64",
                                        age >= 65 ~ "65plus"))

# create df of annual population totals for NI (ni_pop_total) and average for lgd (lgd_pop_mean)
# filter for All persons, group by year and use these to calculate annual figs
df_annual_pop_tot <-  df_myes %>% filter(gender == "All persons")%>% 
  group_by(mid_year_ending) %>%
  summarise(ni_pop_total = sum(population_estimate),
            lgd_pop_mean = mean(population_estimate))

# pop by year and gender
df_mye_year_gender <- df_myes %>%
  filter(gender != "All persons") %>%
  group_by(mid_year_ending, gender) %>%
  summarize(mye_pop = sum(population_estimate))

# pop by year and gender with added total col
df_mye_year_gender_t = df_myes %>%
  group_by(mid_year_ending, gender) %>%
  summarise(ni_pop_total = sum(population_estimate))%>%
  pivot_wider(names_from = gender, values_from = ni_pop_total)

df_mye_year_gender_t =  df_mye_year_gender_t[c(1, 3, 4, 2)]

#### Latest year data frames for tables and charts ####

# latest year by gender
df_latest_year_gender <- filter(df_mye_year_gender, mid_year_ending == latest_year)

# latest_year pop by age group and gender
df_mye_latest_year_agegroup_gender <- df_myes %>% filter(mid_year_ending == latest_year & gender != "All persons") %>%
  group_by(age_group, gender) %>%
  summarize(pop_total = sum(population_estimate))

# add pct col
df_latest_year_agegroup_gender_pct <- df_mye_latest_year_agegroup_gender %>%
  group_by(age_group) %>%
  mutate(pop_pct = (pop_total/sum(pop_total)*100)) %>% 
  select(- pop_total)

df_latest_year_agegroup_gender_pct <- pivot_wider(df_latest_year_agegroup_gender_pct,
                                                  names_from = gender,
                                                  values_from = pop_pct)

# latest year by age group only
df_mye_latest_year_agegroup <- df_myes %>%
  filter(mid_year_ending == latest_year & gender == "All persons") %>%
  group_by(age_group) %>%
  summarize(agegroup_total = sum(population_estimate)) %>%
  mutate(age_group = gsub("-", " to ", age_group))

# latest_year tot pop by LGD
df_mye_latest_year_lgd <- df_myes %>%
  filter(mid_year_ending == latest_year & gender == "All persons") %>%
  group_by(lgd2014name) %>%
  summarize(lgd_pop_total = sum(population_estimate))

# latest_year pop by LGD and age group
df_mye_latest_year_lgd_agegroup <- df_myes %>%
  filter(mid_year_ending == latest_year & gender == "All persons") %>%
  group_by(lgd2014name, age_group) %>%
  summarize(lgd_agegroup_tot = sum(population_estimate))

# latest_year pop of under 25s by LGD
df_mye_latest_year_under25_lgd <- df_myes %>% 
  filter(mid_year_ending == latest_year & gender == "All persons" & age_group == "0-24") %>%
  group_by(lgd2014name) %>%
  summarize(under25_pop = sum(population_estimate))    

#latest_year pop of over 65s by LGD
df_mye_latest_year_over65_lgd <- df_myes %>% 
  filter(mid_year_ending == latest_year & gender == "All persons" & age_group == "65plus") %>%
  group_by(lgd2014name) %>%
  summarize(over65_pop = sum(population_estimate))

# latest_year pop by LGD
df_mye_latest_year_lgd <- df_myes %>% filter(mid_year_ending == latest_year & gender == "All persons") %>%
  group_by(lgd2014name) %>%
  summarize(lgd_pop_total = sum(population_estimate))

# previous year pop by LGD
df_mye_previous_year_lgd <- df_myes %>% filter(mid_year_ending == (latest_year - 1) & gender == "All persons") %>%
  group_by(lgd2014name) %>%
  summarize(lgd_pop_2018 = sum(population_estimate))

# join latest and previous years lgd pop dfs
df_mye_latest_previous_lgd <- df_mye_latest_year_lgd %>% inner_join(df_mye_previous_year_lgd) %>%
  mutate(change = lgd_pop_total - lgd_pop_2018) %>%
  mutate(pct_change = f_round_1dp((lgd_pop_total - lgd_pop_2018)/lgd_pop_2018*100))

# tidy column names for html
df_t4_html <- df_mye_latest_previous_lgd %>%
  rename("LGD" = lgd2014name,
         "2019 population" = lgd_pop_total,
         "2018 population" = lgd_pop_2018,
         "Change" = change,
         "Change (%)" = pct_change)

# latest year by LGD and 5-year age groups
df_mye_latest_5yr_age_lgd <- df_myes %>%
  filter(mid_year_ending == latest_year & gender == "All persons") %>%
  group_by(lgd2014name, age_groups(age, split_at = "fives")) %>%
  summarise(population_latest = sum(population_estimate)) %>% 
  rename(age_group_5 = "age_groups(age, split_at = \"fives\")")

# latest_year young rate rounded to 1dp using excel rounding function
df_mye_latest_year_youthrate <- df_mye_latest_year_under25_lgd %>%
  inner_join(df_mye_latest_year_lgd) %>%
  mutate(youthrate = f_round_n(under25_pop/lgd_pop_total *100, digits =1))

# latest_year elderly rate rounded to 1dp using excel rounding function
df_mye_latest_year_elderlyrate <- df_mye_latest_year_over65_lgd %>%
  inner_join(df_mye_latest_year_lgd) %>%
  mutate(elderlyrate = f_round_n(over65_pop/lgd_pop_total *100, digits =1))

# latest_year pop by age (single year) and gender
df_mye_latest_year_age_gender <- df_myes %>%
  filter(mid_year_ending == latest_year & gender != "All persons") %>%
  group_by(age, gender) %>%
  summarize(pop_latest_year = sum(population_estimate))

# latest year pop split, over or under 65, by gender 
df_mye_latest_over_under_65 <- df_myes %>%
  filter(mid_year_ending == latest_year & gender != "All persons") %>%
  mutate(age_65split = case_when(age <= 64 ~ "under 65",
                                 age >= 65 ~ "65 plus")) %>% 
  group_by(age_65split, gender) %>% 
  summarize(pop = sum(population_estimate)) %>% 
  pivot_wider(names_from = gender, values_from = pop)
  
  

#### Earliest year data frames for tables and charts ####

# earliest year by gender
df_earliest_year_gender <- filter(df_mye_year_gender, mid_year_ending == earliest_year)

# earliest_year tot pop by LGD
df_mye_earliest_pop_lgd <- df_myes %>%
  filter(mid_year_ending == earliest_year & gender == "All persons") %>%
  group_by(lgd2014name)%>%
  summarize(earliest_pop = sum(population_estimate))

# earliest_year pop of under 25s by LGD
df_mye_earliest_under25_lgd <- df_myes %>%
  filter(mid_year_ending == earliest_year & gender == "All persons" & age_group == "0-24") %>%
  group_by(lgd2014name) %>%
  summarize(under25_pop = sum(population_estimate))

# join 2 earliest year dfs and calculate youth as percentage
df_mye_earliest_youthrate <- df_mye_earliest_under25_lgd %>%
  inner_join(df_mye_earliest_pop_lgd) %>%
  mutate(earliest_youthrate = f_round_1dp(under25_pop/earliest_pop*100))

#### Excel data frame creation ####

# tidy for spreadsheets
df_t1_ss <- pivot_wider(df_mye_latest_year_agegroup_gender, names_from = age_group, values_from = pop_total)
names(df_t1_ss) <- c("Sex", "0 to 24", "25 to 44", "45 to 64", "65 plus")

# tidy column names for spreadsheet
df_t2_ss <- df_mye_latest_year_youthrate
names(df_t2_ss) <- c("LGD", "Population under 25", "Total population", "Youth rate (%) [note 1]")

# tidy for spreadsheets
df_t3a_ss <- df_mye_latest_year_youthrate %>%
  rename("LGD" = lgd2014name, "Young people in LGD" = under25_pop,
         "Total population of LGD" = lgd_pop_total, "Young people as percentage" = youthrate)

# tidy for spreadsheets
df_t3b_ss <- df_mye_latest_year_elderlyrate %>%
  rename("LGD" = lgd2014name, "Elderly people in LGD" = over65_pop,
         "Total population of LGD" = lgd_pop_total, "Elderly people as percentage" = elderlyrate)

#### Chart download buttons data frame creation ####

# modify df for fig1 chart download buttons
df_fig1_xls <- select(df_annual_pop_tot, mid_year_ending, ni_pop_total) %>%
  rename("Mid year ending" = mid_year_ending, "NI population total" = ni_pop_total)

fig1_title <- paste0("Figure 1: Northern Ireland mid year population estimate (total) between ", earliest_year," and ", latest_year)

# modify df for fig2 chart download buttons
df_fig2_xls <- select(df_mye_year_gender_t, -"All persons") %>%
  rename("Mid year ending" = mid_year_ending)

# modify df for fig3 downloads
df_fig3_xls <- pivot_wider(df_mye_latest_5yr_age_lgd, names_from = age_group_5, values_from = population_latest) %>%
  rename(LGD = lgd2014name)  

colnames(df_fig3_xls) <- gsub("-", " to ", colnames(df_fig3_xls))

# modify df for figs 4 and 5 chart downloads
df_fig4_5_xls <- select(df_mye_latest_year_youthrate, lgd2014name, youthrate)%>%
  rename("LGD" = lgd2014name, "Youth rate (%)" = youthrate)

# fig 6 download
df_fig6_xls <- pivot_wider(df_mye_latest_year_agegroup_gender, names_from = gender, values_from = pop_total) %>%
  mutate(age_group = gsub("-", " to ", age_group)) %>%
  rename("Age group" = age_group)

# tidy names for chart download
df_fig7_xls <- bind_rows(df_latest_year_gender, df_earliest_year_gender) %>%
  rename("Mid year ending" = mid_year_ending,
         "Gender" = gender,
         "Population" = mye_pop)

# construct df for treemap fig 8
df_fig8 <- df_mye_latest_year_agegroup_gender %>%
  filter(gender == "Females") %>%
  ungroup()

ni_female_latest_tot <- sum(df_fig8$pop_total)

df_fig8 <- df_fig8 %>%
  add_row(age_group = "", gender = "NI", pop_total = ni_female_latest_tot)

# modify for download buttons
df_fig8_xls <- df_fig8 %>%
  rename("Age group" = age_group,
         "Gender" = gender,
         "Population total" = pop_total)

# fig 9 download
fig9_xls <- df_mye_latest_year_agegroup %>% 
  mutate(agegrp_pct = f_round_1dp((agegroup_total / sum(agegroup_total)*100))) %>%
  rename("Age group" = age_group, "Age group total" = agegroup_total, "Age group percent" = agegrp_pct)

#### Mini charts data frame creation for Key Points ####

#total pop for earliest year for mini chart
df_mini_population_earliest <- df_myes %>%
  filter(mid_year_ending == earliest_year & gender != "All persons") %>%
  group_by(mid_year_ending) %>%
  summarise(earliest_year = sum(population_estimate)) %>% rename(ni_pop_total = earliest_year) %>%
  ungroup()

#total pop for latest year for mini chart
df_mini_population_latest <- df_myes %>%
  filter(mid_year_ending == latest_year & gender != "All persons") %>%
  group_by(mid_year_ending) %>%
  summarise(latest_year = sum(population_estimate)) %>% rename(ni_pop_total = latest_year) %>%
  ungroup()

#combining earliest and latest total pop in one df
df_mini_population <- rbind(df_mini_population_earliest, df_mini_population_latest)

# creating the chart
minichart_population <- ggplot(df_mini_population,
                               aes(mid_year_ending, ni_pop_total)) +
  geom_bar(stat = "identity", # creates bar chart
           fill = c(ons_blue, ons_green)) + # colours for bars
  ggtitle("NI Population") +
  xlab("") + 
  ylab("") +
  # creates chart title and removes x and y axis labels 
  geom_text(aes(label = format(ni_pop_total, big.mark = ",")), color = c("white", "black"),
            vjust = 1.5, size = 6) +
  # adds value labels to the bars and sets colours so they meet contrast requirements
  scale_x_continuous(breaks = df_mini_population$mid_year_ending) +
  scale_y_continuous(expand = c(0,0))+ # starts y axis at 0
  theme_bw()+
  # removes gridlines, borders, y axis labels and markers and centres plot title
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        text = element_text(size = 14),
        axis.line.x = element_line(color = "black", linewidth = 0.5, linetype = "solid"),
        axis.line.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.title = element_text(hjust = 0.5))

# save as png to import into report
ggsave(paste0(images_source_root_demo, "mini_population.png"), plot = minichart_population, width = 6, height = 4)


#### Read Maps in ####

# Simplified shapefile of NI councils. 

df_lgd_map <-
  st_read(paste0(project_root,"/code/demo/demo_data/maps/Simplified OSNI Map Loughs Removed.shp"), quiet = TRUE) %>%
  rename(lgd2014name  = LGDNAME, lgd2014 = LGDCode) 

#### Create LGD data for maps ####

df_lgd_young = df_myes %>%
  filter(mid_year_ending == latest_year &  gender == "All persons") %>%
  mutate(under_25 = case_when(age < 25 ~ population_estimate * 1,
                              age >= 25 ~ 0)) %>%
  group_by(lgd2014, lgd2014name) %>%
  summarise(lgd_young = sum(under_25),
            lgd_total = sum(population_estimate)) %>%
  mutate(lgd_young_perc = round(lgd_young / lgd_total * 100, 1)) %>%
  ungroup()

df_map_data <- merge(df_lgd_map, df_lgd_young) %>%
  mutate(
    lgd2014name_short = case_when(
      lgd2014name == "Antrim and Newtownabbey" ~ "AN",
      lgd2014name == "Ards and North Down" ~ "AND",
      lgd2014name == "Belfast" ~ "B",
      TRUE ~ lgd2014name),
    map_label = str_wrap(paste0(
      lgd2014name_short, ": ", lgd_young_perc, "%"), 15),
    map_label_value_only = paste0(lgd_young_perc, "%")) %>%
  select(lgd2014name_short,
         lgd2014name,
         lgd_young_perc,
         map_label,
         map_label_value_only)

