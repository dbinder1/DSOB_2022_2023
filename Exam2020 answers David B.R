setwd("C:/Users/DavidBinder/Documents/Personal/BSB/Coding training/Statistics notes/Statistics/Mock exam 18 Oct 22")

# Import libraries
library(readstata13)
library(pastecs)
library(ggplot2)

# Import the data
dataBSB = read.dta13("dataSurveyBSBFall2020.dta")

for (i in 10:19) {
  dataBSB[,i] = as.numeric(dataBSB[,i])
}

# Create empty table
myTable = matrix(nrow = 10, ncol = 6, data = NA)

for (i in 10:19) {
  stat_vector = stat.desc(dataBSB[,i])
  stat_mean = stat_vector["mean"]
  stat_mean_CI = stat_vector["CI.mean.0.95"]
  myTable[i - 9, 1] = round(stat_vector["median"], 1)
  myTable[i - 9, 2] = round(stat_vector["var"], 1)
  myTable[i - 9, 3] = round(stat_mean, 1)
  myTable[i - 9, 4] = round(stat_vector["SE.mean"], 1)
  myTable[i - 9, 5] = round(stat_mean - stat_mean_CI, 1)
  myTable[i - 9, 6] = round(stat_mean + stat_mean_CI, 1)
}
myTable

dataBSB[,"totalPMJ"] = rowSums(dataBSB[, 10:19])

mean(dataBSB[dataBSB[,"preExp_PMJ_religion"] >= 3,"preExp_PMJ_animalPain"])
var(dataBSB[dataBSB[,"preExp_PMJ_nice"] == 5,"preExp_PMJ_environment"])
median(dataBSB[dataBSB[,"preExp_PMJ_animalMind"] != 3,"preExp_PMJ_necessary"])
stat.desc(dataBSB[dataBSB[,"preExp_PMJ_natural"] < 6,"preExp_PMJ_nice"])["SE.mean"]

# Create empty table
BSB_Table = matrix(nrow = 5, ncol = 2, data = NA)

for (i in 1:5) {
  x = as.numeric(dataBSB[,"freq_viandeRouge"]) == i
  BSB_Table[i, 1] = round(stat.desc(dataBSB[x,"totalPMJ"])["mean"], 2)
  BSB_Table[i, 2] = round(stat.desc(dataBSB[x,"totalPMJ"])["SE.mean"], 2)
}
BSB_Table


totalPMJ_Graph = ggplot(dataBSB,aes(x = totalPMJ)) +
    ggtitle("Distribution of total PMJ") +
    labs(x = "Total PMJ", y = "Frequency") +
    geom_histogram(binwidth = 1) +
    theme_minimal() 
ggsave("totalPMJ_Graph.png")
totalPMJ_Graph

dataBSB[,"meatOften"] = as.numeric(as.numeric(dataBSB[,"freq_viandeRouge"]) >= 4)
dataBSB[,"meatOften"] = factor(dataBSB[,"meatOften"], levels = c(0, 1), labels = c("Unfrequent meat eaters", "Frequent meat eaters"))
dataBSB[,"meatOften"]

meatBelief_Graph = ggplot(dataBSB,aes(x = meatOften, y = preExp_PMJ_environment)) +
  labs(x = "", y = "Beliefs about environment impact of meat") +
  stat_summary(fun = mean, geom = "bar", fill = "gray", color = "Black") +
  stat_summary(fun.data = mean_cl_normal, geom="pointrange") +
  theme_minimal() 
meatBelief_Graph
