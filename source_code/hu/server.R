library(shiny)
library(deSolve)
library(ggplot2)
library(gridExtra)
# Hasznalj helyett a ggplot2, ha Linux-on hostolni
# library(Cairo)
# options(shiny.usecairo=TRUE)

shinyServer(function(input, output) {

	# Michaelis-Menten sebesseg formula
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
		# a modell parameterei
		parms = c(
			k1f = input$k1f, 
			k1r = input$k1r, 
			k2  = input$k2, 
			km  = ((input$k1r + input$k2) / input$k1f)
		)

		# kezdeti ertek
		init = c(
			S  = input$S, 
			E  = input$E, 
			ES = 0, 
			P  = 0
		)

		# a szimulacio ido, 100 "lepes" hogy limitalja a cpu frissitest
		sim.time = seq(0, input$tmax, input$tmax / 100) 

		# integrator elinditasa
		out <- as.data.frame(ode(y = init, times = sim.time, func = mm, parms = parms))

		# a grafok cimei kozepre igazitasa
		theme_update(plot.title = element_text(hjust = 0.5))

		# plot kiiras
		p1 <- ggplot(data = out, aes(x = time, y = S)) +
			geom_line(colour = "steelblue", size = 1) +
			xlab("Idő") +
			ylab("Szubsztrát koncentráció [S]") +
			ggtitle("Szubsztrát felhasználás")

		p2 <- ggplot(data = out, aes(x = time, y = P)) +
			geom_line(colour = "steelblue", size = 1) +
			xlab("Idő") +
			ylab("Termék koncentráció [P]") +
			ggtitle("Termék kialakulása")

		p3 <- ggplot(data = out, aes(x = time, y = E, col = "Szabad enzim")) +
			geom_line(size = 1) +
			geom_line(aes(x = time, y = ES, col = "ES komplexum")) +
			guides(col = guide_legend(title = "")) +
			xlab("Idő") +
			ylab("Enzim koncentráció [E]") +
			ggtitle("Szabad és Kötött enzim")

		p4 <- ggplot(data = out, aes(x = S,  y = v)) +
			geom_line(colour = "steelblue", size = 1) +
			xlab("Szubsztrát felhasználás [S]/t") +
			ylab("Termék kialakulása [P]/t") +
			ggtitle("Reakciósebesség")

		# rácsszerkezet
		grid.arrange(p1, p2, p3, p4, ncol = 2)
	})
})
