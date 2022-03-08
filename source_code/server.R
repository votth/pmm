library(shiny)
library(deSolve)
library(ggplot2)
library(gridExtra)
# For nicer ggplot2 output when deployed on Linux
# library(Cairo)
# options(shiny.usecairo=TRUE)


shinyServer(function(input, output) {
  
    # Michaelis-Menten rate equations
    mm <- function(time, init, parms) {
	with(as.list(c(init, parms)), {
	    dS  <- -k1f * S * E + k1r * ES
	    dE  <- -k1f * S * E + (k1r + k2) * ES
	    dES <- k1f * S * E - (k1r + k2) * ES
	    dP  <- k2 * ES
      
	    vmax <- k2 * (E + ES)
	    v <- vmax * S / (km + S)
      
	    return(list(c(dS, dE, dES, dP), v = v))
	})
    }
  
    output$kinetics_plot <- renderPlot( {
	# model parameters
	parms = c(
	    k1f = input$k1f, 
	    k1r = input$k1r, 
            k2  = input$k2, 
	    km  = ((input$k1r + input$k2) / input$k1f)
        )
    
        # initial conditions
        init = c(
	    S  = input$S, 
	    E  = input$E, 
	    ES = 0, 
            P  = 0
        )
        
        # simulation time (with 100 steps to limit cpu load)
        sim.time = seq(0, input$tmax, input$tmax / 100) 
        
        # run the integrator
        out <- as.data.frame(ode(y = init, times = sim.time, func = mm, parms = parms))
        
        # align title to center
        theme_update(plot.title = element_text(hjust = 0.5))
    
        # output plots
        p1 <- ggplot(data = out, aes(x = time, y = S)) +
	   geom_line(colour = "steelblue", size = 1) +
	   xlab("Time") +
	   ylab("Substrate concentration [S]") +
	   ggtitle("Substrate ultilization")
        
        p2 <- ggplot(data = out, aes(x = time, y = P)) +
	   geom_line(colour = "steelblue", size = 1) +
	   xlab("Time") +
	   ylab("Product concentration [P]") +
	   ggtitle("Product formation")
        
        p3 <- ggplot(data = out, aes(x = time, y = E, col = "Free enzyme")) +
	   geom_line(size = 1) +
	   geom_line(aes(x = time, y = ES, col = "ES complex")) +
	   guides(col = guide_legend(title = "")) +
	   xlab("Time") +
	   ylab("Enzyme concentration [E]") +
	   ggtitle("Free and Bound enzymes")
        
        p4 <- ggplot(data = out, aes(x = S,  y = v)) +
	   geom_line(colour = "steelblue", size = 1) +
	   xlab("Substrate ultilization [S]/t") +
	   ylab("Product formation [P]/t") +
	   ggtitle("Reaction speed (enzyme performance)")
        
        # arrange the plots in a grid layout
        grid.arrange(p1, p2, p3, p4, ncol = 2)
    })
})
