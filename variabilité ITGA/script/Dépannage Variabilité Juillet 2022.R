#################################################################
#
#
#  dépannage Dunia Juillet 2022 - BD ITGA preliminaire
#
#
################################################################

########### libraries
        
        devtools::source_url("https://github.com/lhimp/scripts/raw/master/chemin.R")
        
        library(dplyr)
        
         ##########  Webexpo functions
        
        ## data generation
        
        chemin(
          fileName = "webexpo.seg.randomgeneration.R",
          relPath = c("RANDOM SAMPLE GENERATION"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        
        chemin(
          fileName = "webexpo.between.randomgeneration.R",
          relPath = c("RANDOM SAMPLE GENERATION"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        
        ## data preparation
        
        chemin(
          fileName = "webexpo.seg.dataprep.R",
          relPath = c("DATA PREPARATION", "SEG ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        
        chemin(
          fileName = "webexpo.between.dataprep.R",
          relPath = c("DATA PREPARATION", "BETWEEN WORKER ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        # JAGS models
        
        chemin(
          fileName = "webexpo.seg.mainbayesian.R",
          relPath = c("jags models", "SEG ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        chemin(
          fileName = "webexpo.seg.informedvarbayesian.R",
          relPath = c("jags models", "SEG ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        chemin(
          fileName = "webexpo.seg.informedvarbayesian.models.R",
          relPath = c("jags models", "SEG ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        
        chemin(
          fileName = "webexpo.between.mainbayesian.R",
          relPath = c("jags models", "BETWEEN WORKER ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        chemin(
          fileName = "webexpo.between.informedvarbayesian.R",
          relPath = c("jags models", "BETWEEN WORKER ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        chemin(
          fileName = "webexpo.between.informedvarbayesian.models.R",
          relPath = c("jags models", "BETWEEN WORKER ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        )
        
        
        
        ## Data interpretation
        
        chemin(
          fileName = "webexpo.seg.interpretation.R",
          relPath = c("RESULT INTERPRETATION", "SEG ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        ) 
        
        chemin(
          fileName = "webexpo.between.interpretation.R",
          relPath = c("RESULT INTERPRETATION", "BETWEEN WORKER ANALYSIS"),
          githubCredentials = list(userName = "webexpo", repoName = "webexpo_r_lib")
        ) 

########################### loading data [ NOT IN GITHUB ]
        
        B1_Bayes <- read.csv("C:/jerome/Dropbox/SHARE Dunia Ouedraogo/ITGA/Base de données/B1_Bayes.csv") 
        
        
############################# creating list of SEGs        
        
        #list of unique SEGs
        
        Uniq_GES <- unique(B1_Bayes$id_geh)
        
        #lits of data for each SEG
        
        listofdat <- vector( mode = "list" , length = length(Uniq_GES) ) 
        
        for(i in 1:length(Uniq_GES)){ #Loop through the numbers of Id_geh's 
          
          dat_selection  <- B1_Bayes %>% filter(id_geh == Uniq_GES[i])
          
          ## column selection (expobayes and year for example)
          
          dat_selection <- dat_selection[ , c(21,22,71,78)]
          
          dat <- as.list(dat_selection)
          
          listofdat[[i]] <-  dat_selection 
        }
        
        
##################  analysis of i = 2719
        
        mcmc.seg.1 <- Webexpo.seg.globalbayesian.jags( data.sample = listofdat[[2719]]$Expo_bayes ,
                                                       is.lognormal = TRUE , 
                                                       error.type = "none" ,
                                                       oel = 1 )
        
##### detailled analysis (start of the function "webexpo.seg.mainbayesian.R")
        
 
          
        formatted.data <-webexpo.seg.datapreparation(data.in = listofdat[[2719]]$Expo_bayes)  
        
        x <- formatted.data$data
        
        oel <-1
        
        ###creating the input for the censoring functions in JAGS
        
        #Explanations about the use of dinterval is detailed in the JAGS user manuel (Plummer and Northcott, 2013) and in Kruschke (Kruschke, 2014).
        
        #CensorType is a vector of the length of y, which indicates the censoring status of each observation with regard to the limits indicated by the matrix of censoring points (censorLimitMat)
        
        
        ##must create a matrix with n rows and 2 columnns
        ##column 1 is for the left censoring points (<)
        ##column 2 is for the right censoring points (>)
        
        ## values of the dinterval function
        # 0  : < to the left censoring point
        # 1  : between the 2 censoring points
        # 2 : > to the right censoring points
        
        ##coding the dinterval values
        
        #In practice :
        
        #for left censored points :
        #Censortype is 0
        #left limit of censorLimitMat is the censoring value
        #right limit of censorLimitMat is 50 (value we are sure any observation is smaller than)
        
        #for right censored points :
        #Censortype is 2
        #left limit of censorLimitMat is -50 (value we are sure any observation is greater than)
        #right limit of censorLimitMat is the censoring value
        
        #for interval censored points :
        #Censortype is 1
        #left limit of censorLimitMat is left censoring point
        #rightlimit of censorLimitMat is right censoring value
        
        #for observed points :
        #Censortype is 1
        #left limit of censorLimitMat is -50 (value we are sure any observation is greater than)
        #right limit of censorLimitMat is 50 (value we are sure any observation is smaller than)                
        
        #censorLimitMat is the matrix of censoring points
        
        #x/Y should be set to NA when censored
        
        
        y <- as.numeric(x)/oel  ##Nas automatically generated
        
        ##creating the dinterval vector : CensorType
        
        CensorType <- rep(1,length(x)) 
        
        #left censored
        CensorType[formatted.data$leftcensored] <-0  
        
        #right censored
        CensorType[formatted.data$rightcensored] <-2  
        
        ## creating the matrix of limits
        censorLimitMat <- matrix(nrow = length(y) , ncol = 2)
        censorLimitMat[,1] <-rep(-50,length(y))
        censorLimitMat[,2] <-rep(50,length(y))
        
        
        #left censored
        censorLimitMat[formatted.data$leftcensored,1] <-as.numeric(substring(x[formatted.data$leftcensored],2))/oel
        #right censored
        censorLimitMat[formatted.data$rightcensored,2] <-as.numeric(substring(x[formatted.data$rightcensored],2))/oel
        #interval censored
        censorLimitMat[formatted.data$intcensored,1] <-as.numeric(substring(x[formatted.data$intcensored],2,regexpr("-",x[formatted.data$intcensored],fixed=TRUE)-1))/oel
        censorLimitMat[formatted.data$intcensored,2] <-as.numeric(substring(x[formatted.data$intcensored],regexpr("-",x[formatted.data$intcensored],fixed=TRUE)+1,nchar(x[formatted.data$intcensored])-1))/oel
        
        ####### The issue is seen in censorlimitmat : 61.8 and 109 are greater than 50, supposedly an upper limit to measurements
        