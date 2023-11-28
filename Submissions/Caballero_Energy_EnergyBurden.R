# Load data
CEJST <- read_excel("Desktop/Hack-a-thon/CEJST_data.xlsx") %>% 
          dplyr::select(`Census tract 2010 ID`: `State/Territory`, `Energy burden`) %>% 
          filter(`Energy burden` < 100)


national_summary <- CEJST %>% 
                   summarise(avg_eb = mean(`Energy burden`, na.rm = TRUE),
                             med_eb = median(`Energy burden`, na.rm = TRUE), 
                             min_eb = min(`Energy burden`, na.rm = TRUE), 
                             max_eb = max(`Energy burden`, na.rm = TRUE), 
                             unit = "United States")

SE_summary <- CEJST %>%
              filter(`State/Territory` %in% c("Alabama", "Florida", "Georgia", "Kentucky", 
                                 "Mississippi", "North Carolina", "South Carolina", 
                                 "Tennessee")) %>% 
              summarise(avg_eb = mean(`Energy burden`, na.rm = TRUE),
                        med_eb = median(`Energy burden`, na.rm = TRUE), 
                        min_eb = min(`Energy burden`, na.rm = TRUE), 
                        max_eb = max(`Energy burden`, na.rm = TRUE),
                        unit = "Southeastern Region")

TN_summary <- CEJST %>%
              filter(`State/Territory` == "Tennessee") %>% 
              summarise(avg_eb = mean(`Energy burden`, na.rm = TRUE),
                        med_eb = median(`Energy burden`, na.rm = TRUE), 
                        min_eb = min(`Energy burden`, na.rm = TRUE), 
                        max_eb = max(`Energy burden`, na.rm = TRUE), 
                        unit = "Tennessee")

Nashville_summary <- CEJST %>% 
                      filter(`State/Territory` == "Tennessee") %>% 
                      filter(`County Name` == "Davidson County") %>% 
                      summarise(avg_eb = mean(`Energy burden`, na.rm = TRUE),
                                med_eb = median(`Energy burden`, na.rm = TRUE), 
                                min_eb = min(`Energy burden`, na.rm = TRUE), 
                                max_eb = max(`Energy burden`, na.rm = TRUE), 
                                unit = "Davidson County, TN")
## bind 
df <- national_summary %>% 
      bind_rows(SE_summary) %>% 
      bind_rows(TN_summary) %>% 
      bind_rows(Nashville_summary) %>% 
      mutate(unit = factor(unit, levels = c("Davidson County, TN", "Tennessee", 
                                            "Southeastern Region", "United States")))

## formattable 
customGreen0 = "#D6EBC2"

customGreen = "#5A8B2D"

customRed = "#9E681C"

temp <- df %>% 
        select(unit, min_eb, med_eb, avg_eb, max_eb) %>% 
        rename("Geography" = "unit",  
               "Minimum Energy Burden" = "min_eb", 
               "Median Energy Burden" = "med_eb", 
               "Average Energy Burden" = "avg_eb",
               "Maximum Energy Burden" = "max_eb") %>% 
        mutate(`Percent Difference from National Average` = round((`Average Energy Burden`-2.77)/2.77*100,2), 
               `Average Energy Burden` = round(`Average Energy Burden`, 2)) %>% 
        mutate(`Percent Difference from National Average` = 
                 ifelse(`Percent Difference from National Average` == 0.18, "--", 
                        `Percent Difference from National Average`))

avg_formatter <- 
  formatter("span", 
            style = `Percent Difference from National Average` ~ style(
              font.weight = "bold", 
              color = ifelse(`Percent Difference from National Average` > 0, customRed, 
                             ifelse(`Percent Difference from National Average` < 0, customGreen, "black"))))

formattable(temp, align =c("l","c","c", "c", "c", "r"), list(
  `Geography` = formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
  `Minimum Energy Burden`= color_tile(customGreen, customGreen0),
  `Median Energy Burden`= color_tile(customGreen, customGreen0),
  `Average Energy Burden`= color_tile(customGreen, customGreen0),
  `Maximum Energy Burden`= color_tile(customGreen, customGreen0),
  `Percent Difference from National Average` = avg_formatter
), 
table.attr = 'style="font-size: 18px; font-family: Avenir";\"')

df %>%
  ggplot(aes(x = avg_eb, y = unit, label = avg_eb)) +
  geom_errorbarh(aes(xmin = min_eb, xmax = max_eb)) +
  geom_point(color = "#8DBEB3", size = 3) +
  scale_x_continuous(labels = scales::percent_format(scale = 1),
                     breaks = c(10, 20, 30, 40, 50, 60, 70)) + 
  theme_bw() + 
  theme(text=element_text(size=16,  family="Avenir"))+
  labs(title = "Average Energy Burden",
       subtitle = "2020 Low-income Energy Affordability Data Tool",
       y = "",
       x = "Energy Burden (bars represent minimum and maximum)")