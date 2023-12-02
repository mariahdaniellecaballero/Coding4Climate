


#-------------------------------------------------------------------------------
# Open Statistical data about land use trend for the 4 regions in study
# US = United States 
# SE = Southeast region 
# TN = Tennesse 
# DC = Davison County
#-------------------------------------------------------------------------------

#----------
# Libraries 
#----------
library(tidyverse)
library(ggplot2)

#-------------------------------------------------------------------------------
# Open Data 
#-------------------------------------------------------------------------------

in_Path <-  '1_Data/'
in_Path <-  'D:/Documents_D/myRepositories/4_Fall_2023/11_Hackaton/1_Data/'
in_File <- 
  
  file_list <-  Sys.glob(paste(in_Path, '*.csv', sep = '') )
file_list


# US Extention

US11 <- read_csv(file_list[4], name_repair = janitor::make_clean_names)
US11 <-  drop_na(US11)

US13 <- read_csv(file_list[8], name_repair = janitor::make_clean_names)
US13 <-  drop_na(US13)

US16 <- read_csv(file_list[12], name_repair = janitor::make_clean_names)
US16 <-  drop_na(US16)

US19 <- read_csv(file_list[16], name_repair = janitor::make_clean_names)
US19 <-  drop_na(US19)

US21 <- read_csv(file_list[20], name_repair = janitor::make_clean_names)
US21 <-  drop_na(US21)


# South East Extention

SE11 <- read_csv(file_list[2], name_repair = janitor::make_clean_names)
SE11 <-  drop_na(SE11)

SE13 <- read_csv(file_list[6], name_repair = janitor::make_clean_names)
SE13 <-  drop_na(SE13)

SE16 <- read_csv(file_list[10], name_repair = janitor::make_clean_names)
SE16 <-  drop_na(SE16)

SE19 <- read_csv(file_list[14], name_repair = janitor::make_clean_names)
SE19 <-  drop_na(SE19)

SE21 <- read_csv(file_list[18], name_repair = janitor::make_clean_names)
SE21 <-  drop_na(SE21)


# TennesseeExtention

TN11 <- read_csv(file_list[3], name_repair = janitor::make_clean_names)
TN11 <-  drop_na(TN11)

TN13 <- read_csv(file_list[7], name_repair = janitor::make_clean_names)
TN13 <-  drop_na(TN13)

TN16 <- read_csv(file_list[11], name_repair = janitor::make_clean_names)
TN16 <-  drop_na(TN16)

TN19 <- read_csv(file_list[15], name_repair = janitor::make_clean_names)
TN19 <-  drop_na(TN19)

TN21 <- read_csv(file_list[19], name_repair = janitor::make_clean_names)
TN21 <-  drop_na(TN21)

# Davison County Extention

DC11 <- read_csv(file_list[1], name_repair = janitor::make_clean_names)
DC11 <-  drop_na(DC11)

DC13 <- read_csv(file_list[5], name_repair = janitor::make_clean_names)
DC13 <-  drop_na(DC13)

DC16 <- read_csv(file_list[9], name_repair = janitor::make_clean_names)
DC16 <-  drop_na(DC16)

DC19 <- read_csv(file_list[13], name_repair = janitor::make_clean_names)
DC19 <-  drop_na(DC19)

DC21 <- read_csv(file_list[17], name_repair = janitor::make_clean_names)
DC21 <-  drop_na(DC21)



#-------------------------------------------------------------------------------
# Condensing data 
#-------------------------------------------------------------------------------


# Create organized US to plot 

US_df <-  data.frame(Year = c(), 
                     Open_Water = c(),
                     Perennial_Snow_Ice = c(),
                     Developed_Open_Space = c(),
                     Developed_Low_Intensity = c(),
                     Developed_Medium_Intensity = c(),
                     Developed_High_Intensity = c(),
                     Barren_Land = c(),
                     Deciduous_Forest = c(),
                     Evergreen_Forest = c(),
                     Mixed_Forest = c(),
                     Shrub_Scrub = c(),
                     Herbaceous = c(),
                     Hay_Pasture = c(), 
                     Cultivated_Crops = c(),
                     Woody_Wetlands = c(),
                     Emergent_Herbaceous_Wetlands = c(), 
                     total_water = c(), 
                     total_developed = c(), 
                     total_forest = c(), 
                     total_agricultural = c(), 
                     total_wetland = c(), 
                     total_area = c())

US_list <-  list(US11, US13, US16, US19, US21)
years <- list(2011,2013,2016,2019,2021)

for (iY in 1:length(US_list)){
  
  new_row <-  data.frame(Year = years[[iY]], 
                         Open_Water = filter(US_list[[iY]], nlcd_land_cover_class == 'Open Water')[[3]],
                         Perennial_Snow_Ice = filter(US_list[[iY]], nlcd_land_cover_class == 'Perennial Snow/Ice')[[3]],
                         Developed_Open_Space = filter(US_list[[iY]], nlcd_land_cover_class == 'Developed, Open Space')[[3]],
                         Developed_Low_Intensity = filter(US_list[[iY]], nlcd_land_cover_class == 'Developed, Low Intensity')[[3]],
                         Developed_Medium_Intensity = filter(US_list[[iY]], nlcd_land_cover_class == 'Developed, Medium Intensity')[[3]],
                         Developed_High_Intensity = filter(US_list[[iY]], nlcd_land_cover_class == 'Developed, High Intensity')[[3]],
                         Barren_Land = filter(US_list[[iY]], nlcd_land_cover_class == 'Barren Land')[[3]],
                         Deciduous_Forest = filter(US_list[[iY]], nlcd_land_cover_class == 'Deciduous Forest')[[3]],
                         Evergreen_Forest = filter(US_list[[iY]], nlcd_land_cover_class == 'Evergreen Forest')[[3]],
                         Mixed_Forest = filter(US_list[[iY]], nlcd_land_cover_class == 'Mixed Forest')[[3]],
                         Shrub_Scrub = filter(US_list[[iY]], nlcd_land_cover_class == 'Shrub/Scrub')[[3]],
                         Herbaceous = filter(US_list[[iY]], nlcd_land_cover_class == 'Herbaceous')[[3]],
                         Hay_Pasture = filter(US_list[[iY]], nlcd_land_cover_class == 'Hay/Pasture')[[3]],
                         Cultivated_Crops = filter(US_list[[iY]], nlcd_land_cover_class == 'Cultivated Crops')[[3]],
                         Woody_Wetlands = filter(US_list[[iY]], nlcd_land_cover_class == 'Woody Wetlands')[[3]],
                         Emergent_Herbaceous_Wetlands = filter(US_list[[iY]], nlcd_land_cover_class == 'Emergent Herbaceous Wetlands')[[3]])
  
  
  new_row$total_water = (new_row$Open_Water+ new_row$Perennial_Snow_Ice)
  new_row$total_developed = (new_row$Developed_Open_Space + new_row$Developed_Low_Intensity + new_row$Developed_Medium_Intensity +  new_row$Developed_High_Intensity)
  new_row$total_forest = (new_row$Deciduous_Forest + new_row$Evergreen_Forest + new_row$Mixed_Forest) 
  new_row$total_agricultural = (new_row$Hay_Pasture + new_row$Cultivated_Crops) 
  
  #Percentages 
  new_row$total_count <-(new_row$Open_Water+ new_row$Developed_Open_Space+ new_row$Developed_Low_Intensity+ 
                           new_row$Developed_Medium_Intensity+ new_row$Developed_High_Intensity+ new_row$Barren_Land+ 
                           new_row$Deciduous_Forest+ new_row$Evergreen_Forest+ new_row$Mixed_Forest+ new_row$Shrub_Scrub+ 
                           new_row$Herbaceous+  new_row$Hay_Pasture+ new_row$Cultivated_Crops+ new_row$Woody_Wetlands+  
                           new_row$Emergent_Herbaceous_Wetlands+ new_row$Perennial_Snow_Ice)  
  
  new_row$perc_water <-  (new_row$total_water / new_row$total_count)*100
  new_row$perc_developed <- (new_row$total_developed / new_row$total_count )*100
  new_row$perc_forest <- (new_row$total_forest / new_row$total_count)*100
  new_row$perc_agricultural <- (new_row$total_agricultural / new_row$total_count)*100
  new_row$perc_others <-  ((new_row$Barren_Land + new_row$Shrub_Scrub +  new_row$Herbaceous 
                            + new_row$Woody_Wetlands + new_row$Emergent_Herbaceous_Wetlands) / new_row$total_count)*100
  
  # Add row to df 
  US_df <- rbind(US_df , new_row)
}

US_df 

# Create organized SE to plot 

SE_df <-  data.frame(Year = c(), 
                     Open_Water = c(),
                     Perennial_Snow_Ice = c(),
                     Developed_Open_Space = c(),
                     Developed_Low_Intensity = c(),
                     Developed_Medium_Intensity = c(),
                     Developed_High_Intensity = c(),
                     Barren_Land = c(),
                     Deciduous_Forest = c(),
                     Evergreen_Forest = c(),
                     Mixed_Forest = c(),
                     Shrub_Scrub = c(),
                     Herbaceous = c(),
                     Hay_Pasture = c(), 
                     Cultivated_Crops = c(),
                     Woody_Wetlands = c(),
                     Emergent_Herbaceous_Wetlands = c(), 
                     total_water = c(), 
                     total_developed = c(), 
                     total_forest = c(), 
                     total_agricultural = c(), 
                     total_wetland = c(), 
                     total_area = c())

US_list <-  list(SE11, SE13, SE16, SE19, SE21)
years <- list(2011,2013,2016,2019,2021)

#iY = 1

for (iY in 1:length(US_list)){
  
  new_row <-  data.frame(Year = years[[iY]], 
                         Open_Water = filter(US_list[[iY]], nlcd_land == 'Open Water')[[3]],
                         Developed_Open_Space = filter(US_list[[iY]], nlcd_land == 'Developed, Open Space')[[3]],
                         Developed_Low_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, Low Intensity')[[3]],
                         Developed_Medium_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, Medium Intensity')[[3]],
                         Developed_High_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, High Intensity')[[3]],
                         Barren_Land = filter(US_list[[iY]], nlcd_land == 'Barren Land')[[3]],
                         Deciduous_Forest = filter(US_list[[iY]], nlcd_land == 'Deciduous Forest')[[3]],
                         Evergreen_Forest = filter(US_list[[iY]], nlcd_land == 'Evergreen Forest')[[3]],
                         Mixed_Forest = filter(US_list[[iY]], nlcd_land == 'Mixed Forest')[[3]],
                         Shrub_Scrub = filter(US_list[[iY]], nlcd_land == 'Shrub/Scrub')[[3]],
                         Herbaceous = filter(US_list[[iY]], nlcd_land == 'Herbaceous')[[3]],
                         Hay_Pasture = filter(US_list[[iY]], nlcd_land == 'Hay/Pasture')[[3]],
                         Cultivated_Crops = filter(US_list[[iY]], nlcd_land == 'Cultivated Crops')[[3]],
                         Woody_Wetlands = filter(US_list[[iY]], nlcd_land == 'Woody Wetlands')[[3]],
                         Emergent_Herbaceous_Wetlands = filter(US_list[[iY]], nlcd_land == 'Emergent Herbaceous Wetlands')[[3]])
  
  
  new_row$total_water = (new_row$Open_Water)
  new_row$total_developed = (new_row$Developed_Open_Space + new_row$Developed_Low_Intensity + new_row$Developed_Medium_Intensity +  new_row$Developed_High_Intensity)
  new_row$total_forest = (new_row$Deciduous_Forest + new_row$Evergreen_Forest + new_row$Mixed_Forest) 
  new_row$total_agricultural = (new_row$Hay_Pasture + new_row$Cultivated_Crops) 
  
  #Percentages 
  new_row$total_count <-(new_row$Open_Water+ new_row$Developed_Open_Space+ new_row$Developed_Low_Intensity+ 
                           new_row$Developed_Medium_Intensity+ new_row$Developed_High_Intensity+ new_row$Barren_Land+ 
                           new_row$Deciduous_Forest+ new_row$Evergreen_Forest+ new_row$Mixed_Forest+ new_row$Shrub_Scrub+ 
                           new_row$Herbaceous+  new_row$Hay_Pasture+ new_row$Cultivated_Crops+ new_row$Woody_Wetlands+  
                           new_row$Emergent_Herbaceous_Wetlands)  
  
  new_row$perc_water <-  (new_row$total_water / new_row$total_count)*100
  new_row$perc_developed <- (new_row$total_developed / new_row$total_count )*100
  new_row$perc_forest <- (new_row$total_forest / new_row$total_count)*100
  new_row$perc_agricultural <- (new_row$total_agricultural / new_row$total_count)*100
  new_row$perc_others <-  ((new_row$Barren_Land + new_row$Shrub_Scrub +  new_row$Herbaceous 
                            + new_row$Woody_Wetlands + new_row$Emergent_Herbaceous_Wetlands) / new_row$total_count)*100
  
  # Add row to df 
  SE_df <- rbind(SE_df , new_row)
}

SE_df 


# Create organized TN to plot 

TN_df <-  data.frame(Year = c(), 
                     Open_Water = c(),
                     Perennial_Snow_Ice = c(),
                     Developed_Open_Space = c(),
                     Developed_Low_Intensity = c(),
                     Developed_Medium_Intensity = c(),
                     Developed_High_Intensity = c(),
                     Barren_Land = c(),
                     Deciduous_Forest = c(),
                     Evergreen_Forest = c(),
                     Mixed_Forest = c(),
                     Shrub_Scrub = c(),
                     Herbaceous = c(),
                     Hay_Pasture = c(), 
                     Cultivated_Crops = c(),
                     Woody_Wetlands = c(),
                     Emergent_Herbaceous_Wetlands = c(), 
                     total_water = c(), 
                     total_developed = c(), 
                     total_forest = c(), 
                     total_agricultural = c(), 
                     total_wetland = c(), 
                     total_area = c())

US_list <-  list(TN11, TN13, TN16, TN19, TN21)
years <- list(2011,2013,2016,2019,2021)

for (iY in 1:length(US_list)){
  
  new_row <-  data.frame(Year = years[[iY]], 
                         Open_Water = filter(US_list[[iY]], nlcd_land == 'Open Water')[[3]],
                         Developed_Open_Space = filter(US_list[[iY]], nlcd_land == 'Developed, Open Space')[[3]],
                         Developed_Low_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, Low Intensity')[[3]],
                         Developed_Medium_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, Medium Intensity')[[3]],
                         Developed_High_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, High Intensity')[[3]],
                         Barren_Land = filter(US_list[[iY]], nlcd_land == 'Barren Land')[[3]],
                         Deciduous_Forest = filter(US_list[[iY]], nlcd_land == 'Deciduous Forest')[[3]],
                         Evergreen_Forest = filter(US_list[[iY]], nlcd_land == 'Evergreen Forest')[[3]],
                         Mixed_Forest = filter(US_list[[iY]], nlcd_land == 'Mixed Forest')[[3]],
                         Shrub_Scrub = filter(US_list[[iY]], nlcd_land == 'Shrub/Scrub')[[3]],
                         Herbaceous = filter(US_list[[iY]], nlcd_land == 'Herbaceous')[[3]],
                         Hay_Pasture = filter(US_list[[iY]], nlcd_land == 'Hay/Pasture')[[3]],
                         Cultivated_Crops = filter(US_list[[iY]], nlcd_land == 'Cultivated Crops')[[3]],
                         Woody_Wetlands = filter(US_list[[iY]], nlcd_land == 'Woody Wetlands')[[3]],
                         Emergent_Herbaceous_Wetlands = filter(US_list[[iY]], nlcd_land == 'Emergent Herbaceous Wetlands')[[3]])
  
  
  
  new_row$total_water = (new_row$Open_Water)
  new_row$total_developed = (new_row$Developed_Open_Space + new_row$Developed_Low_Intensity + new_row$Developed_Medium_Intensity +  new_row$Developed_High_Intensity)
  new_row$total_forest = (new_row$Deciduous_Forest + new_row$Evergreen_Forest + new_row$Mixed_Forest) 
  new_row$total_agricultural = (new_row$Hay_Pasture + new_row$Cultivated_Crops) 
  
  #Percentages 
  new_row$total_count <-(new_row$Open_Water+ new_row$Developed_Open_Space+ new_row$Developed_Low_Intensity+ 
                           new_row$Developed_Medium_Intensity+ new_row$Developed_High_Intensity+ new_row$Barren_Land+ 
                           new_row$Deciduous_Forest+ new_row$Evergreen_Forest+ new_row$Mixed_Forest+ new_row$Shrub_Scrub+ 
                           new_row$Herbaceous+  new_row$Hay_Pasture+ new_row$Cultivated_Crops+ new_row$Woody_Wetlands+  
                           new_row$Emergent_Herbaceous_Wetlands)  
  
  new_row$perc_water <-  (new_row$total_water / new_row$total_count)*100
  new_row$perc_developed <- (new_row$total_developed / new_row$total_count )*100
  new_row$perc_forest <- (new_row$total_forest / new_row$total_count)*100
  new_row$perc_agricultural <- (new_row$total_agricultural / new_row$total_count)*100
  new_row$perc_others <-  ((new_row$Barren_Land + new_row$Shrub_Scrub +  new_row$Herbaceous 
                            + new_row$Woody_Wetlands + new_row$Emergent_Herbaceous_Wetlands) / new_row$total_count)*100
  # Add row to df 
  TN_df <- rbind(TN_df , new_row)
}

TN_df

# Create organized DF to plot 

DC_df <-  data.frame(Year = c(), 
                     Open_Water = c(),
                     Perennial_Snow_Ice = c(),
                     Developed_Open_Space = c(),
                     Developed_Low_Intensity = c(),
                     Developed_Medium_Intensity = c(),
                     Developed_High_Intensity = c(),
                     Barren_Land = c(),
                     Deciduous_Forest = c(),
                     Evergreen_Forest = c(),
                     Mixed_Forest = c(),
                     Shrub_Scrub = c(),
                     Herbaceous = c(),
                     Hay_Pasture = c(), 
                     Cultivated_Crops = c(),
                     Woody_Wetlands = c(),
                     Emergent_Herbaceous_Wetlands = c(), 
                     total_water = c(), 
                     total_developed = c(), 
                     total_forest = c(), 
                     total_agricultural = c(), 
                     total_wetland = c(), 
                     total_area = c())

US_list <-  list(DC11, DC13, DC16, DC19, DC21)
years <- list(2011,2013,2016,2019,2021)

for (iY in 1:length(US_list)){
  
  new_row <-  data.frame(Year = years[[iY]], 
                         Open_Water = filter(US_list[[iY]], nlcd_land == 'Open Water')[[3]],
                         Developed_Open_Space = filter(US_list[[iY]], nlcd_land == 'Developed, Open Space')[[3]],
                         Developed_Low_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, Low Intensity')[[3]],
                         Developed_Medium_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, Medium Intensity')[[3]],
                         Developed_High_Intensity = filter(US_list[[iY]], nlcd_land == 'Developed, High Intensity')[[3]],
                         Barren_Land = filter(US_list[[iY]], nlcd_land == 'Barren Land')[[3]],
                         Deciduous_Forest = filter(US_list[[iY]], nlcd_land == 'Deciduous Forest')[[3]],
                         Evergreen_Forest = filter(US_list[[iY]], nlcd_land == 'Evergreen Forest')[[3]],
                         Mixed_Forest = filter(US_list[[iY]], nlcd_land == 'Mixed Forest')[[3]],
                         Shrub_Scrub = filter(US_list[[iY]], nlcd_land == 'Shrub/Scrub')[[3]],
                         Herbaceous = filter(US_list[[iY]], nlcd_land == 'Herbaceous')[[3]],
                         Hay_Pasture = filter(US_list[[iY]], nlcd_land == 'Hay/Pasture')[[3]],
                         Cultivated_Crops = filter(US_list[[iY]], nlcd_land == 'Cultivated Crops')[[3]],
                         Woody_Wetlands = filter(US_list[[iY]], nlcd_land == 'Woody Wetlands')[[3]],
                         Emergent_Herbaceous_Wetlands = filter(US_list[[iY]], nlcd_land == 'Emergent Herbaceous Wetlands')[[3]])
  
  
  
  new_row$total_water = (new_row$Open_Water)
  new_row$total_developed = (new_row$Developed_Open_Space + new_row$Developed_Low_Intensity + new_row$Developed_Medium_Intensity +  new_row$Developed_High_Intensity)
  new_row$total_forest = (new_row$Deciduous_Forest + new_row$Evergreen_Forest + new_row$Mixed_Forest) 
  new_row$total_agricultural = (new_row$Hay_Pasture + new_row$Cultivated_Crops) 
  
  #Percentages 
  new_row$total_count <-(new_row$Open_Water+ new_row$Developed_Open_Space+ new_row$Developed_Low_Intensity+ 
                           new_row$Developed_Medium_Intensity+ new_row$Developed_High_Intensity+ new_row$Barren_Land+ 
                           new_row$Deciduous_Forest+ new_row$Evergreen_Forest+ new_row$Mixed_Forest+ new_row$Shrub_Scrub+ 
                           new_row$Herbaceous+  new_row$Hay_Pasture+ new_row$Cultivated_Crops+ new_row$Woody_Wetlands+  
                           new_row$Emergent_Herbaceous_Wetlands)  
  
  new_row$perc_water <-  (new_row$total_water / new_row$total_count)*100
  new_row$perc_developed <- (new_row$total_developed / new_row$total_count )*100
  new_row$perc_forest <- (new_row$total_forest / new_row$total_count)*100
  new_row$perc_agricultural <- (new_row$total_agricultural / new_row$total_count)*100
  new_row$perc_others <-  ((new_row$Barren_Land + new_row$Shrub_Scrub +  new_row$Herbaceous 
                            + new_row$Woody_Wetlands + new_row$Emergent_Herbaceous_Wetlands) / new_row$total_count)*100  
  # Add row to df 
  DC_df <- rbind(DC_df , new_row)
}

DC_df 



#------------------------------------------------------------------------------
# Develop PLOTS
#------------------------------------------------------------------------------


library(dplyr)
library(showtext)

# US
#------------------------------------------------------------------------------

land_extention = 'United States'

df_2 <- US_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2$check <-  df_2$perc_water+ df_2$perc_developed+ df_2$perc_forest+ df_2$perc_agricultural+ df_2$perc_others
df_2
df_2 <- US_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2 <- df_2 %>%
  rename(Water = perc_water, Developed  = perc_developed, Forest = perc_forest, Agricultural = perc_agricultural, Others = perc_others)

df_long <- gather(df_2, key = "LandUse", value = "value", -Year)

print(df_long)


# Load font 
#------------------------------------------------------------------------------

font_path <- "D:/Documents_D/myRepositories/4_Fall_2023/11_Hackaton/1_Data/avenir_7CuzX/Avenir/Avenir Regular/Avenir Regular.ttf"  # 
font_add("Avenir", regular = font_path)
showtext_auto()


# Plot
#------------------------------------------------------------------------------
ggplot(df_long, aes(x = Year, y = value, fill = LandUse)) +
  geom_area(position = "stack", alpha = 0.7) +
  labs(title = land_extention,
       x = "Year",
       y = "Land Percentage (%)") +
  scale_fill_manual(values = c("Developed" = "#9E681C", "Water" = "#8DBEB3",
                               "Forest" = "#6CA335", "Agricultural" = "#B2AE20", 
                               "Others" = '#77AD8C')) +
  theme_minimal(base_size =  15) +
  scale_x_continuous(breaks = seq(2011, 2021, by = 2))+
  scale_y_continuous(breaks = seq(0, 100, by = 10))+
  theme(text = element_text(family = "Avenir"))


library(dplyr)
library(showtext)

# SE
#------------------------------------------------------------------------------
land_extention = 'Southeast Region' 

df_2 <- SE_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2$check <-  df_2$perc_water+ df_2$perc_developed+ df_2$perc_forest+ df_2$perc_agricultural+ df_2$perc_others
df_2
df_2 <- US_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2 <- df_2 %>%
  rename(Water = perc_water, Developed  = perc_developed, Forest = perc_forest, Agricultural = perc_agricultural, Others = perc_others)

df_long <- gather(df_2, key = "LandUse", value = "value", -Year)

print(df_long)


# Load font 
#------------------------------------------------------------------------------

font_path <- "D:/Documents_D/myRepositories/4_Fall_2023/11_Hackaton/1_Data/avenir_7CuzX/Avenir/Avenir Regular/Avenir Regular.ttf"  # 
font_add("Avenir", regular = font_path)
showtext_auto()


# Plot
#------------------------------------------------------------------------------
ggplot(df_long, aes(x = Year, y = value, fill = LandUse)) +
  geom_area(position = "stack", alpha = 0.7) +
  labs(title = land_extention,
       x = "Year",
       y = "Land Percentage (%)") +
  scale_fill_manual(values = c("Developed" = "#9E681C", "Water" = "#8DBEB3",
                               "Forest" = "#6CA335", "Agricultural" = "#B2AE20", 
                               "Others" = '#77AD8C')) +
  theme_minimal(base_size =  15) +
  scale_x_continuous(breaks = seq(2011, 2021, by = 2))+
  scale_y_continuous(breaks = seq(0, 100, by = 10))+
  theme(text = element_text(family = "Avenir"))


library(dplyr)
library(showtext)

# SE
#------------------------------------------------------------------------------
land_extention = 'Tennessee' 

df_2 <- TN_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2$check <-  df_2$perc_water+ df_2$perc_developed+ df_2$perc_forest+ df_2$perc_agricultural+ df_2$perc_others
df_2
df_2 <- US_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2 <- df_2 %>%
  rename(Water = perc_water, Developed  = perc_developed, Forest = perc_forest, Agricultural = perc_agricultural, Others = perc_others)

df_long <- gather(df_2, key = "LandUse", value = "value", -Year)

print(df_long)


# Load font 
#------------------------------------------------------------------------------

font_path <- "D:/Documents_D/myRepositories/4_Fall_2023/11_Hackaton/1_Data/avenir_7CuzX/Avenir/Avenir Regular/Avenir Regular.ttf"  # 
font_add("Avenir", regular = font_path)
showtext_auto()


# Plot
#------------------------------------------------------------------------------
ggplot(df_long, aes(x = Year, y = value, fill = LandUse)) +
  geom_area(position = "stack", alpha = 0.7) +
  labs(title = land_extention,
       x = "Year",
       y = "Land Percentage (%)") +
  scale_fill_manual(values = c("Developed" = "#9E681C", "Water" = "#8DBEB3",
                               "Forest" = "#6CA335", "Agricultural" = "#B2AE20", 
                               "Others" = '#77AD8C')) +
  theme_minimal(base_size =  15) +
  scale_x_continuous(breaks = seq(2011, 2021, by = 2))+
  scale_y_continuous(breaks = seq(0, 100, by = 10))+
  theme(text = element_text(family = "Avenir"))



library(dplyr)
library(showtext)

# SE
#------------------------------------------------------------------------------
land_extention = 'Davison County' 

df_2 <- DC_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2$check <-  df_2$perc_water+ df_2$perc_developed+ df_2$perc_forest+ df_2$perc_agricultural+ df_2$perc_others
df_2
df_2 <- US_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

df_2 <- df_2 %>%
  rename(Water = perc_water, Developed  = perc_developed, Forest = perc_forest, Agricultural = perc_agricultural, Others = perc_others)

df_long <- gather(df_2, key = "LandUse", value = "value", -Year)

print(df_long)


# Load font 
#------------------------------------------------------------------------------

font_path <- "D:/Documents_D/myRepositories/4_Fall_2023/11_Hackaton/1_Data/avenir_7CuzX/Avenir/Avenir Regular/Avenir Regular.ttf"  # 
font_add("Avenir", regular = font_path)
showtext_auto()


# Plot
#------------------------------------------------------------------------------
ggplot(df_long, aes(x = Year, y = value, fill = LandUse)) +
  geom_area(position = "stack", alpha = 0.7) +
  labs(title = land_extention,
       x = "Year",
       y = "Land Percentage (%)") +
  scale_fill_manual(values = c("Developed" = "#9E681C", "Water" = "#8DBEB3",
                               "Forest" = "#6CA335", "Agricultural" = "#B2AE20", 
                               "Others" = '#77AD8C')) +
  theme_minimal(base_size =  15 ) +
  scale_x_continuous(breaks = seq(2011, 2021, by = 2))+
  scale_y_continuous(breaks = seq(0, 100, by = 10))+
  theme(text = element_text(family = "Avenir"))






#------------------------------------------------------------------------------
# Plot beautiful table 
#------------------------------------------------------------------------------



# US
#------------------------------------------------------------------------------
land_extention = 'United States' 

df_2 <- US_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

diff_US <-  data.frame(Region = 'United States', 
                       Water = round(df_2[5,2]-df_2[1,2],2), 
                       Developed =round(df_2[5,3]-df_2[1,3],2),
                       Forest =round(df_2[5,4]-df_2[1,4],2),
                       Agricultural =round(df_2[5,5]-df_2[1,5],2),
                       Others =round(df_2[5,6]-df_2[1,6],2))


# SE
#------------------------------------------------------------------------------
land_extention = 'Southeast' 

df_2 <- SE_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

diff_SE <-  data.frame(Region = 'Southeast Region', 
                       Water = round(df_2[5,2]-df_2[1,2],2), 
                       Developed =round(df_2[5,3]-df_2[1,3],2),
                       Forest =round(df_2[5,4]-df_2[1,4],2),
                       Agricultural =round(df_2[5,5]-df_2[1,5],2),
                       Others =round(df_2[5,6]-df_2[1,6],2))

# TN
#------------------------------------------------------------------------------
land_extention = 'Tennessee' 

df_2 <- TN_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

diff_TN <-  data.frame(Region = 'Tennessee', 
                       Water = round(df_2[5,2]-df_2[1,2],2), 
                       Developed =round(df_2[5,3]-df_2[1,3],2),
                       Forest =round(df_2[5,4]-df_2[1,4],2),
                       Agricultural =round(df_2[5,5]-df_2[1,5],2),
                       Others =round(df_2[5,6]-df_2[1,6],2))


# DC
#------------------------------------------------------------------------------
land_extention = 'Davison County' 

df_2 <- DC_df %>% dplyr::select(Year, 
                                perc_water, 
                                perc_developed ,
                                perc_forest, 
                                perc_agricultural,
                                perc_others)

diff_DC <-  data.frame(Region = 'Davison County', 
                       Water = round(df_2[5,2]-df_2[1,2],2), 
                       Developed =round(df_2[5,3]-df_2[1,3],2),
                       Forest =round(df_2[5,4]-df_2[1,4],2),
                       Agricultural =round(df_2[5,5]-df_2[1,5],2),
                       Others =round(df_2[5,6]-df_2[1,6],2))



total_diff_df <-  rbind(diff_US,diff_SE,diff_TN,diff_DC)

total_diff_df

#------------------
# Libraries 
#------------------

library(data.table)
library(dplyr)
library(formattable)
library(tidyr)
library(htmltools)
library(magrittr)
library(knitr)

# Set colors 
#-------------

c1 = '#9E681C'
c2 = '#B2AE20'
c3 = '#6CA335'
c4 = '#77AD8C'
c5 = '#8DBEB3'
c0 = '#FDF8EE' 
c0 = 'white'

# Font Family 
#-----------------

font_path <- "D:/Documents_D/myRepositories/4_Fall_2023/11_Hackaton/1_Data/avenir_7CuzX/Avenir/Avenir Regular/Avenir Regular.ttf"  # 
font_add("Avenir", regular = font_path)
showtext_auto()


# Formattin tbale 
#----------------------

font_formatter <- formatter(
  "span",
  style = x ~ "font-family: 'Avenir', sans-serif; font-weight: bold; color: blue;"
)

Table <-  formattable(total_diff_df, 
                      align = c('c', 'c','c','c','c','c'), 
                      list('Region' = formatter('span', style = x ~ style(font.weight  =  'bold', font.family = "Century Gothic")),
                           'Water' = color_tile(c0,c5),
                           'Developed' = color_tile(c0,c1),
                           'Forest' = color_tile(c0,c3),
                           'Agricultural' = color_tile(c0,c2),
                           'Others' = color_tile(c0,c4)
                      ), 
                      table.attr = 'style="font-size: 18px; font-family: Century Gothic";\"')

Table

