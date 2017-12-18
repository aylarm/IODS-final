library(Matrix)
library(ggplot2)
library(dplyr)


getwd()
hd2 <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii2 <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd2)
dim(hd2)
str(gii2)
dim(gii2)
summary(hd2)
summary(gii2)
colnames(hd2)
colnames(hd2)[1] <-"HDI.rank"
colnames(hd2)[3] <-"HDI"
colnames(hd2)[4] <- "Life.exp"
colnames(hd2)[5] <- "Edu.exp"
colnames(hd2)[6] <- "Edu.y.mean"
colnames(hd2)[7] <- "GNI"
colnames(hd2)[8] <- "GNI-HDI.rank"
colnames(hd2)


colnames(gii2)
colnames(gii2)[1] <- "GII.rank"
colnames(gii2)[3] <- "GII"
colnames(gii2)[4] <- "Mot.mor"
colnames(gii2)[5] <- "Adol.birth"
colnames(gii2)[6] <- "Parl.F"
colnames(gii2)[7] <- "Edu2F"
colnames(gii2)[8] <- "Edu2M"
colnames(gii2)[9] <- "LabF"
colnames(gii2)[10] <- "LabM"
colnames(gii2)
gii2 <- mutate(gii2, Edu2FM = Edu2F / Edu2M)
gii2 <- mutate(gii2, LabFM = LabF/LabM)
colnames(gii2)
join_by <- c("Country")


hdi_gii2 <- inner_join(hd2, gii2, by= join_by, suffix= c(".hd2", ".gii2"))
colnames(hdi_gii2)
write.csv(hdi_gii2, file = "human2.csv", row.names = FALSE)
human2 <- read.csv("human2.csv", sep=",", header= T)
str(human2)
human2 <- mutate(human2, GNI = as.numeric(human2$GNI))
str(human2)
colnames(human2)
keep_columns <- c("Country", "Edu2FM","LabFM","HDI", "Edu.exp", "Life.exp", "GNI", "Mot.mor", "Adol.birth", "Parl.F", "Edu.y.mean")
human2 <- select(human2, one_of(keep_columns))
str(human2)
complete.cases(human2)
data.frame(human2[-1], comp = complete.cases(human2))
human2 <- filter(human2, complete.cases(human2))
complete.cases(human2)
str(human2)
last <- nrow(human2) - 7
last
human2 <- human2[1:155, ]
str(human2)
rownames(human2) <- human2$Country

human2 <- dplyr::select(human2, -Country)
str(human2)
head(human2)
write.csv(human2, file = "human2.csv", row.names = TRUE)
human2 <- read.csv("human2.csv", sep=",", header= T, row.names = 1)
str(human2)
summary(human2)
complete.cases(human)
head(human)