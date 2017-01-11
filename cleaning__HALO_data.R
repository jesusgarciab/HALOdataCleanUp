main_df <- read.csv("prostate_epithelium_set4.csv")
temp <- read.csv("prostate_stroma_set4.csv")
main_df <- rbind(main_df, temp)
rm(temp)

##set halo data to "main_df"

##checking used columns
initial_values <- which(colnames(main_df) == "Marker.1.Intensity")
zero_value_columns <- which(colSums(main_df[,initial_values:ncol(main_df)]) == 0) + (initial_values-1)

##Selecting only non zero data 
my_Vars <- names(main_df) %in% zero_value_columns
new_data <- main_df[!my_Vars]

#removing original data
rm(main_df)


#Using "Analisys.Inputs" column for regions to measure
names(new_data)[3] <- "Region"
regions_number <- length(levels(new_data[,"Region"]))
region_levels <- c()


for (i in 1:regions_number) {
        print(paste("There are", regions_number, "levels in this column."))
        print(levels(new_data$Region))
        region_name <- readline(prompt = paste("Please type string to name level number", i, "to find and use as regions: "))
        assign(paste0("region", i), value = region_name)
        
        region_count <-grepl(get(paste0("region",i)), new_data$Region)
        region_levels <- c(region_levels, get(paste0("region",i)))
        

}

levels(new_data$Region) <- region_levels