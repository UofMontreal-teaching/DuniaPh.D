#################################################################
#
#
#  dépannage Dunia Juillet 2022 - BD ITGA preliminaire
#
#
################################################################

########### libraries
        
        devtools::source_url("https://github.com/lhimp/scripts/raw/master/chemin.R")
        
        
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