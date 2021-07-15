library(tidymodels)
library(textrecipes)
library(janitor)
library(stringr)

# Download archived DWD package from cran and unpack

load("DWD/data/ticdata.rda")

man_file <- read.delim("DWD/man/ticdata.Rd", sep = "\n")[,1]
man_file <-
   man_file[21:106] %>%
   str_remove_all("\\\\") %>%
   str_remove_all("cr$") %>%
   str_remove_all("code\\{") %>%
   str_remove_all("\\}")  %>%
   str_remove_all("1 - 10")  %>%
   str_remove_all("1 - 6")  %>%
   str_remove_all("0 - 1") %>%
   str_trim(side = "right") %>%
   str_split("tab")


orig_names <- map_chr(man_file, ~ .x[3]) %>% str_trim()
new_names <-
   map_chr(man_file, ~ .x[4]) %>%
   str_trim() %>%
   str_replace_all("Number of", "num") %>%
   str_replace_all("Contribution", "contrib") %>%
   str_replace_all("policies", "pol") %>%
   str_replace_all("insurance", "insur") %>%
   str_replace_all("^1", "one") %>%
   str_replace_all("^2", "two") %>%
   str_replace_all("\\.000", "") %>%
   janitor::make_clean_names()

# paste0(new_names, "=", orig_names, collapse = ",\n") %>% cat()

new_data <-
   ticdata %>%
   dplyr::rename(
      customer_subtype=STYPE,
      num_houses=MAANTHUI,
      avg_size_household=MGEMOMV,
      average_age=MGEMLEEF,
      customer_main_type=MOSHOOFD,
      roman_catholic=MGODRK,
      protestant=MGODPR,
      other_religion=MGODOV,
      no_religion=MGODGE,
      married=MRELGE,
      living_together=MRELSA,
      other_relation=MRELOV,
      singles=MFALLEEN,
      household_without_children=MFGEKIND,
      household_with_children=MFWEKIND,
      high_level_education=MOPLHOOG,
      medium_level_education=MOPLMIDD,
      lower_level_education=MOPLLAAG,
      high_status=MBERHOOG,
      entrepreneur=MBERZELF,
      farmer=MBERBOER,
      middle_management=MBERMIDD,
      skilled_labourers=MBERARBG,
      unskilled_labourers=MBERARBO,
      social_class_a=MSKA,
      social_class_b1=MSKB1,
      social_class_b2=MSKB2,
      social_class_c=MSKC,
      social_class_d=MSKD,
      rented_house=MHHUUR,
      home_owners=MHKOOP,
      one_car=MAUT1,
      two_cars=MAUT2,
      no_car=MAUT0,
      national_health_service=MZFONDS,
      private_health_insur=MZPART,
      income_30=MINKM30,
      income_30_45=MINK3045,
      income_45_75=MINK4575,
      income_75_122=MINK7512,
      income_123=MINK123M,
      average_income=MINKGEM,
      purchasing_power_class=MKOOPKLA,
      contrib_private_third_party_insur=PWAPART,
      contrib_third_party_insur_firms=PWABEDR,
      contrib_third_party_insur_agriculture=PWALAND,
      contrib_car_pol=PPERSAUT,
      contrib_delivery_van_pol=PBESAUT,
      contrib_motorcycle_scooter_pol=PMOTSCO,
      # contrib_lorry_pol=PVRAAUT,
      contrib_trailer_pol=PAANHANG,
      contrib_tractor_pol=PTRACTOR,
      contrib_agricultural_machines_pol=PWERKT,
      contrib_moped_pol=PBROM,
      contrib_life_insurs=PLEVEN,
      contrib_private_accident_insur_pol=PPERSONG,
      contrib_family_accidents_insur_pol=PGEZONG,
      contrib_disability_insur_pol=PWAOREG,
      contrib_fire_pol=PBRAND,
      contrib_surfboard_pol=PZEILPL,
      contrib_boat_pol=PPLEZIER,
      contrib_bicycle_pol=PFIETS,
      contrib_property_insur_pol=PINBOED,
      contrib_social_security_insur_pol=PBYSTAND,
      num_private_third_party_insur_1_12=AWAPART,
      num_third_party_insur_firms=AWABEDR,
      num_third_party_insur_agriculture=AWALAND,
      num_car_pol=APERSAUT,
      num_delivery_van_pol=ABESAUT,
      num_motorcycle_scooter_pol=AMOTSCO,
      num_lorry_pol=AVRAAUT,
      num_trailer_pol=AAANHANG,
      num_tractor_pol=ATRACTOR,
      num_agricultural_machines_pol=AWERKT,
      num_moped_pol=ABROM,
      num_life_insurs=ALEVEN,
      num_private_accident_insur_pol=APERSONG,
      num_family_accidents_insur_pol=AGEZONG,
      num_disability_insur_pol=AWAOREG,
      num_fire_pol=ABRAND,
      num_surfboard_pol=AZEILPL,
      num_boat_pol=APLEZIER,
      num_bicycle_pol=AFIETS,
      num_property_insur_pol=AINBOED,
      num_social_security_insur_pol=ABYSTAND,
      num_mobile_home_pol=CARAVAN
   )


better_range_lvls <- function(x) {
   lvls <- levels(x)
   orig_lvls <- lvls
   lvls <- str_remove_all(lvls, "^f ")
   lvls <- str_remove_all(lvls, "%")
   lvls <- str_replace_all(lvls, " - ", "-")
   splt <- str_split(lvls, "-")
   frst <- map_dbl(splt, ~ as.numeric(.x[1]))
   lvls <- str_replace_all(lvls, "-", "_to_")
   lvls <- lvls[order(frst)]

   lvl_list <- lvls
   names(lvl_list) <- orig_lvls
   y <- dplyr::recode(x, !!!lvl_list)
   factor(y, ordered = FALSE)
}

new_data[, 6:64] <- map_dfc(new_data[, 6:64], better_range_lvls)
new_data$average_age <- better_range_lvls(new_data$average_age)

tic_data <-
   recipe(~., data = new_data) %>%
   step_clean_levels(customer_subtype, customer_main_type) %>%
   prep() %>%
   juice() %>%
   dplyr::rename(class = num_mobile_home_pol) %>%
   dplyr::relocate(class)

save(tic_data, file = "RData/tic_data.RData", version = 2, compress = "xz")

