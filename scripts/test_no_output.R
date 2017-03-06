Sys.time()
print("Starting the R Script")
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

Sys.time()
print("Installed packages")

## load the arguments ##
args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else {
  # default output file
  print(c(args[1], args[2], args[3]))
}

## load data ##
input_path <- "/projects/hackonomics/energy/IHWAP.dta"
IHWAP_pc <- read.dta13(input_path)

Sys.time()
print("Read raw data")

## subset by energy sample ##
IHWAP_pc <- IHWAP_pc[which(IHWAP_pc$BuildingType != "Mobile Home"),]
data_v <- subset(IHWAP_pc, select = c("Household", "myear", "months_post", "months_pre", "Consumption_MMBTU", "treated", "mmonth", "ARRA"))
data_v1 <- data_v[which(data_v$months_post > 12 & data_v$months_pre > 12),]
invalid_household <- data_v1[which((data_v1$Consumption_MMBTU) <= 0.0), ]
length(unique(invalid_household$Household))
data_v2 <- data_v1[which(!(data_v1$Household %in% unique(invalid_household$Household))), ]
#data_temp <- subset(data_v1, select = c("Household", "treated"))
#data_treated <- aggregate(treated ~ Household, data_temp, sum)

Sys.time()
print("Finished Data Preprocessing")

############################################
## do parallel 

energy_parallel <- function (data_v2, s, e, output_path, iter){
  
  #sample_vec <- c(400, 350, 300, 250, 200)
  #effect_vec <- c(0.02, 0.025, 0.03, 0.035, 0.04, 0.045, 0.05)
  #line <- paste0("Beginning of ", iter, "th iteration for: ", s, " | ", e, Sys.time())
  #write(line, file = output_path, append = TRUE)   

  packages <- c("readxl", "lfe")
  lapply(packages, pkgTest)
  
  result_m <- c()
 
  ## find 3000 unique household which randomly sampled from the whole dataset ##
  data_sample <- data_v2[which(!duplicated(data_v2$Household)),]
  selected_household <- data_sample[sample(nrow(data_sample), nrow(data_sample), replace = F),]
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
  selected_sample$logMMBTU_RCT[which(is.infinite(selected_sample$logMMBTU_RCT))] <- -99.9
  
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
  
  ## for the output ##
  #line <- paste0(iter, "th iteration for: ", s, " | ", e, Sys.time())
  #write(line, file = output_path, append = TRUE)    
      
  return(result_m)
  #rm(result_m)
  
}## end of the energy parallel function ##

Sys.time()
print("starting parallel")

np <- detectCores()
cl <- makeForkCluster(np-1)
clusterExport(cl, c("data_v2"))
registerDoParallel(cores=(np-1))

#sample_vec <- c(300, 350, 400, 500, 600) # 400, 350, 300, 250, 200
#effect_vec <- c(0.02) #0.02, 0.025, 0.03, 0.035, 0.04, 0.045, 0.05

s <- as.numeric(args[1])   #300
e <- as.numeric(args[2])   #0.02
num_iter <- as.numeric(args[5])
output_path <- as.character(args[4])
#r <- energy_parallel(data_v2, 300, 0.02)

if(file.exists(output_path)){
  write(c(paste0("operation started for: ", args[1], " | ", args[2])), file = output_path, append = TRUE)
}
if(!file.exists(output_path)){
  write(c(paste0("operation started for: ", args[1], " | ", args[2])), file = output_path, append = FALSE)
}

result2 <- list()
    
temp_res <- foreach(i=1:num_iter, .combine='c') %dopar% {
  energy_parallel(data_v2, s, e, output_path, i)
}

result2 <- c(result2, list(temp_res))
print(s)

print(result2)

stopCluster(cl)
Sys.time()
print("ended parallel")

output_path <- args[3] #"/projects/hackonomics/energy/output/result_0.04.csv"
write.csv(result2, output_path)
Sys.time()
print("finished output")
