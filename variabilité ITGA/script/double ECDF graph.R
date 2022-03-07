##################################################
#
#  script de création de courbes empiriques cumulatives par ggplot
#
##################################################

library(ggplot2)
library(ggthemes)

####### simulation des données

  #### kromhout : expostats log(gsd) lognormal avec GM=0.84 et GSD=1.87,  200 GES

  sigma.krom <- exp( rnorm( 200 ,log(0.84) , log(1.87) ) )
  
  #### ITGA : expostats log(gsd) lognormal avec GM=0.74 et GSD=2.2,  1000 GES

  sigma.itga <- exp( rnorm( 1000 ,log(0.74) , log(2.2) ) )
  
  
  ###### data.frames
  
  krom <- data.frame( sigma = sigma.krom,
                      log.sigma = log( sigma.krom),
                      gsd = exp( sigma.krom))
  
  itga <- data.frame( sigma = sigma.itga,
                      log.sigma = log( sigma.itga),
                      gsd = exp( sigma.itga))
  
  
  ###### GSDs less than 20
  
  krom <- krom[ krom$gsd < 20 , ]
  
  itga <- itga[ itga$gsd < 20 , ]
  
  ############### making the graph
  
  
  
  
  
  #### tech

  p <- ggplot() 
  
  p <- p +  stat_ecdf( data = krom  , geom = "step" , aes(  x = gsd , color = "Kromhout") )
  
  p <- p +  stat_ecdf( data = itga , geom = "step" , aes( x = gsd , color = "ITGA")  )
  
  p <- p +  geom_hline( yintercept = 0.25, linetype="dashed", color = "black")
  
  p <- p +  geom_hline( yintercept = 0.5, color = "black")
  
  p <- p +  geom_hline( yintercept = 0.75, linetype="dashed", color = "black")
  
  #### beauty
  
  p <- p + theme_solarized()
  
  
  p <- p +  xlab('GSD') + ylab('Cumulative probability')+
    theme(axis.title.x=element_text(size=14))+
    theme(axis.title.y=element_text(size=14))+
    theme(axis.text.x=element_text(size=12 , hjust = 0.5))+
    theme(axis.text.y=element_text(size=12 ,  hjust = 0.5))
  
  p <- p + scale_y_continuous(expand = c(0 , 0.00) , 
                              limits = c(0,1),
                              labels = scales::number_format(accuracy = 0.01,
                                                             decimal.mark = ',') )
  
  p <- p + scale_x_log10(
                              labels = scales::number_format(accuracy = 0.01,
                                                             decimal.mark = ',') )
  
  p <- p + scale_color_manual(name = "Data",
                     breaks = c("Kromhout", "ITGA"),
                     values = c("Kromhout" = "red", "ITGA" = "blue") )
  
  p <- p  + theme(legend.position = c(0.8, 0.6) , legend.key = element_rect(colour = "transparent"))
  

  
  p
  
  