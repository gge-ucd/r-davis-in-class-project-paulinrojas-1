surveys <- read.csv('data/portal_data_joined.cvs')
surveys
colnames(surveys)

surveys_base <- surveys[1:60, c(6,9,13)]
colnames(surveys_base)
row.names(surveys_base)

surveys_base$species_id <-as.character(surveys_base$species_id)
surveys_base$plot_type <- as.character(surveys_base$plot_type)

surveys_base <- surveys_base[complete.cases(surveys_base),]
row.names(surveys_base)

#challenge
challenge_base <- surveys_base[(surveys_base[,2]>150),]
colnames(surveys)
