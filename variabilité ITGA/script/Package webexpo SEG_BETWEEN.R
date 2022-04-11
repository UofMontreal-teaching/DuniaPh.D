#################################################################################
#
#
#   SCRIPTS WEBEXPO POUR DUNIA - 
#
##################################################################################


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
          
          
######## SEG EXAMPLE
          
          #data generation
          
          sample.seg.1 <- webexpo.seg.gener.LN( n = 100,
                                                # indicator for the presence of censoring
                                                no.censoring = FALSE,
                                                # Percentage Left censored 
                                                perc.lowerthan = 20,
                                                # Percentage right censored
                                                perc.greaterthan = 10,
                                                # Percentage interval censored
                                                perc.between = 20,
                                                # Distributional parameters
                                                gm = 0.3,
                                                gsd = 2.5,
                                                # Censoring parameters
                                                left_factor = 1.5,
                                                right_factor = 1/1.5,
                                                int_factor = 1.5,
                                                # Measurement error structure
                                                error = "none",   #(or "cv" or "sd")
                                                me.cv = 0.20 ,
                                                me.sd = 0.05)  
          
          #Bayesian calculation using JAGS models
          
          mcmc.seg.1 <- Webexpo.seg.globalbayesian.jags( data.sample = sample.seg.1 ,
                                                         is.lognormal = TRUE , 
                                                         error.type = "none" ,
                                                         oel = 100 )
          
          #Numerical interpretation of the MCMC chains
          
          num.seg.1 <- all.numeric(mu.chain = mcmc.seg.1$mu.chain,
                                   sigma.chain = mcmc.seg.1$sigma.chain,
                                   probacred = 90 ,
                                   oel = 100,
                                   frac_threshold =5 ,
                                   target_perc = 95)
          
######## BETWEEN WORKER EXAMPLE
          
          
          ### lognormal sample high between worker variability : rho = 0.66 (75th percentile in Kromhout et al)
          
          sample.4 <- webexpo.between.gener.LN( # Number of workers     
                                                    n.worker = 20,
                                                    # Number of days
                                                    n.days = rep(20,20), #vector of length n.worker (allows unbalanced data)
                                                    # Presence of censoring
                                                    no.censoring = TRUE,
                                                    # Percentage of left censoring
                                                    perc.lowerthan = 20,
                                                    # Percentage of right censoring
                                                    perc.greaterthan = 10,
                                                    # Percentage of interval cenoring
                                                    perc.between = 20,
                                                    # Ditributional parameters
                                                    gm = 0.3,
                                                    gsd = 2.5,
                                                    rho = 0.5,   ## within worker correlation
                                                    
                                                    # Censoring parameters
                                                    left_factor = 1.5,
                                                    right_factor = 1/1.5,
                                                    int_factor = 1.5,
                                                    
                                                    # Measurement error structure
                                                    error = "none",   #(or "cv" or "sd")
                                                    me.cv = 0.20 ,
                                                    me.sd = 0.05)    
          
          # Bayesian calculations      
          
          #####default webexpo analysis - JAGS

          
          mcmc.4 <- Webexpo.between.globalbayesian.jags(  data.sample = sample.4,
                                                          is.lognormal = TRUE,
                                                          error.type = "none", 
                                                          me.range = c(0.3,0.3), 
                                                          oel = 150,
                                                          prior.model = "informedvar",
                                                          mu.overall.lower = -20,
                                                          mu.overall.upper = 20,
                                                          log.sigma.between.mu=-0.8786,
                                                          log.sigma.between.prec=1.634,
                                                          log.sigma.within.mu=-0.4106,
                                                          log.sigma.within.prec=1.9002, 
                                                          n.iter = 50000, 
                                                          n.burnin = 5000, 
                                                          init.mu.overall = log(0.3),
                                                          init.sigma.within = log(2.5),
                                                          init.sigma.between = log(2.5),
                                                          init.log.sigma.within = log(log(2.5)),
                                                          init.log.sigma.between = log(log(2.5)) )
          
          
          ###### numerical interpretation
          
          
          num.4 <- Webexpo.between.interpretation(  is.lognormal = TRUE , 
                                                    mu.overall = mcmc.4$mu.overall.chain,
                                                    sigma.between.chain = mcmc.4$sigma.between.chain ,
                                                    sigma.within.chain = mcmc.4$sigma.within.chain ,
                                                    probacred = 90, 
                                                    oel = 150,
                                                    target_perc = 95,
                                                    rappap_cover = 80, 
                                                    wwct = 0.2 , 
                                                    prob.ind.overexpo.threshold = 20)
          