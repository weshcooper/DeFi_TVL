theme_polsara <- function(){ 
  font <- "Inter"   #assign font family up front
  
  theme_fivethirtyeight() %+replace%    #replace elements we want to change
    
    theme(
      
      #grid elements
      panel.grid.major = element_line(colour = "#d3d3d3"), 
      panel.grid.minor = element_line(colour = "#d3d3d3", size = 0.25),
      axis.ticks = element_blank(),          #strip axis ticks
      
      #since theme_minimal() already strips axis lines, 
      #we don't need to do that again
      
      #text elements
      plot.title = element_text(             #title
        family = font,            #set font family
        size = 14,                #set font size
        face = 'bold',            #bold typeface
        hjust = 0,                #left align
        vjust = 2),               #raise slightly
      
      plot.subtitle = element_text(          #subtitle
        family = font,            #font family
        size = 11),               #font size
      
      plot.caption = element_text(           #caption
        family = font,            #font family
        size = 9,                 #font size
        hjust = 1),               #right align
      
      axis.title = element_text(             #axis titles
        family = font,            #font family
        size = 9),               #font size
      
      axis.text = element_text(              #axis text
        family = font,            #axis famuly
        size = 8),                #font size
      
      axis.text.x = element_text(            #margin for axis text
        margin=margin(5, b = 10)),
      
      panel.background = element_rect(fill = "#f1f0eb", colour = NA),
      
      plot.background = element_rect(colour = "#f1f0eb"),
      
      rect = element_rect(fill = "#f1f0eb", colour = "#f1f0eb",
                          size = 0.5, linetype = 1)
      
      #since the legend often requires manual tweaking 
      #based on plot content, don't define it here
    )
}