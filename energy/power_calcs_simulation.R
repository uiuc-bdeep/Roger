##################################################################
## Preliminaries
rm(list=ls())

## This function will check if a package is installed, and if not, install it
pkgTest <- function(x) {
  if (!require(x, character.only = TRUE))
  {
    install.packages(x, dep = TRUE)
    if(!require(x, character.only = TRUE)) stop("Package not found")
  }
}

## These lines load the required packages
packages <- c("readxl", "parallel", "doParallel", "readstata13", "lfe", "foreach")
lapply(packages, pkgTest)

## load data ##
IHWAP_pc <- read.dta13("/projects/hackonomics/energy/IHWAP_clean.dta")


## subset by energy sample ##
data_v <- subset(IHWAP_pc, select = c("Household", "myear", "count_post", "count_pre", "Consumption_MMBTU", "treated", "mmonth"))
data_v1 <- data_v[which(data_v$count_post >= 12 & data_v$count_pre >= 12),]
invalid_household <- data_v1[which((data_v1$Consumption_MMBTU) < 0.0), ]
length(unique(invalid_household$Household))
data_v2 <- data_v1[which(!(data_v1$Household %in% unique(invalid_household$Household))), ]
#data_temp <- subset(data_v1, select = c("Household", "treated"))
#data_treated <- aggregate(treated ~ Household, data_temp, sum)


############################################
## do parallel 

energy_parallel <- function (data_v2, sample_vec1, effect_vec1){
  
  #sample_vec <- c(400, 350, 300, 250, 200)
  #effect_vec <- c(0.02, 0.025, 0.03, 0.035, 0.04, 0.045, 0.05)
  
  packages <- c("readxl", "lfe")
  lapply(packages, pkgTest)
  
  sample_vec <- sample_vec1
  effect_vec <- effect_vec1
  
  result_m <- c()
  
  for (s in sample_vec) {
    for (e in effect_vec) {
      
      ## find 3000 unique household which randomly sampled from the whole dataset ##
      data_sample <- data_v2[which(!duplicated(data_v2$Household)),]
      selected_household <- data_sample[sample(nrow(data_sample), 3000, replace = F),]
      selected_sample <- data_v2[which(data_v2$Household %in% selected_household$Household), ]
      selected_sample <- selected_sample[order(selected_sample$Household),]
      selected_sample_raw <- selected_sample
      
      ## RCT ##
      RCT <- selected_household[sample(nrow(selected_household), s, replace = F),]
      selected_sample$RCT <- 0
      selected_sample$RCT[which(selected_sample$Household %in% RCT$Household)] <- 1
      
      ## change the effects if the household is treated ##
      selected_sample$MMBTU_RCT <- selected_sample$Consumption_MMBTU
      selected_sample$MMBTU_RCT_temp <- selected_sample$Consumption_MMBTU * (1-e)
      selected_sample$MMBTU_RCT[which(selected_sample$RCT == 1 & selected_sample$treated == 1)] <- selected_sample$MMBTU_RCT_temp[which(selected_sample$RCT == 1 & selected_sample$treated == 1)]
      selected_sample$MMBTU_RCT_temp <- NULL
      
      ## loging the MMBTU_RCT ##
      selected_sample$logMMBTU_RCT <- log(selected_sample$MMBTU_RCT)
      
      ## creating treated_RCT ##
      selected_sample$treated_RCT <- 0
      selected_sample$treated_RCT[which(selected_sample$RCT == 1 & selected_sample$treated == 1)] <- 1
      
      selected_sample$treated_RCT <- as.factor(selected_sample$treated_RCT)
      selected_sample$treated <- as.factor(selected_sample$treated)
      selected_sample$Household <- as.factor(selected_sample$Household)
      selected_sample$myear <- as.factor(selected_sample$myear)
      selected_sample$mmonth <- as.factor(selected_sample$mmonth)
      ## regression ##
      m1 <- felm(logMMBTU_RCT ~ treated + treated_RCT | mmonth:myear + Household:mmonth | 0 | Household, data = selected_sample, na.action=na.pass)
      
      result_m <- c(result_m, m1$STATS$logMMBTU_RCT$cpval[2][[1]])
      
      #print(iter)
      #iter = iter + 1
    }
  }
  
  return(result_m)
  #rm(result_m)
  
}## end of the energy parallel function ##


np <- detectCores()
cl <- makeForkCluster(np-1)
clusterExport(cl, c("data_v2"))
registerDoParallel(cores=(np-1))

sample_vec <- c(400, 350, 300, 250, 200) # 400, 350, 300, 250, 200
effect_vec <- c(0.05) #0.02, 0.025, 0.03, 0.035, 0.04, 0.045, 0.05

result2 <- list()

for (s in sample_vec) {
  
  result1 <- c()
  
  for (e in effect_vec) {
    
    temp_res <- foreach(i=1:200, .combine='c') %dopar% {
      energy_parallel(data_v2, s, e)
    }
    
    result1 <- c(result1, temp_res)
    print(temp_res)
    
  }
  
  result2 <- c(result2, list(result1))
  print(result1)
  
}

stopCluster(cl)

write.csv(result2, "/projects/hackonomics/energy/output/result_0.05.csv")

