library(shiny)

#define the user interface
shinyUI(fluidPage(
	#App title
	headerPanel("Pi Michaelis Menten (PMM)"),

	#Sidebar with slider controls
	sidebarPanel(
		numericInput(
			"tmax", "Simulation time (1-1000):",
			value=20, min=1, max=1000, step=NA
		),
		sliderInput(
			"k1f", "k1 forward:",
			value=1, min=0, max=10, step=0.1
		),
		sliderInput(
			"k1r", "k1 reverse:",
			value=1, min=0, max=10, step=0.1
		),
		sliderInput(
			"k2", "k2:", 
			value=1, min=0, max=10, step=0.1
		),
		sliderInput(
			"S", "Initial [S]ubstrate concentration:",
			value=100, min=0, max=100, step=0.1
		),
		sliderInput(
			"E", "Initial [E]nzyme concentration:",
			value=10, min=0, max=100, step=0.1
		)
	),

	#Show the plot
	mainPanel(
		tabsetPanel(
			tabPanel("Model",
				img(src="mechanism.png"),
				plotOutput("kinetics_plot"),
			),

			tabPanel("Description",
				h3("Enzyme catalyzed reaction visualization:"),
				img(src="enzyme_action.png"),
				br(),
				br(),

				h3("Introduciton"),

				p("For starter, chemical reactions happen by chance and these reactions take time to occur."),

				p("Enzymes are biological entities that increase the chance of chemicals reacting. They facilitate all kinds of reactions while not being an active participant themselves (they don't change in the reaction), hence, are of great interest to biologists since they can drive all kinds of reactions that wouldn't ordinarily occur (at least not within the lifetime of the researcher!) and don't change the outcome of said reaction."),
				p("Biologists can adjust the properties of enzymes by modifying their attributes (like how efficiently they bind to reactants and how quickly they can convert them into product), usually to get them to drive faster reactions under particular conditions (like breaking down dirt on your clothes whilst being spun at 1200rpm at 30oC in your washing machine - not a naturally occuring environment!)"),

				p("This app simulates the process of an enzyme binding to a substrate and converting it to product. In a regular chemical reaction, this would be a 1:1 relationship and the, concentration of product would increase linearly with concentration of substrate as one converts to the other. For enzyme driven reactions however, the enzyme is an intermediary and therefore, the rate of the reaction is non-linear as it is governed by the performance of the enzyme, like the speed of a car is governed by the performance of the engine, but like an engine, an enzyme can be tuned. Welcome to the world of the enzyme kineticist!"),

				h3("Application instruction:"),
				p("This app simulates the modifications a scientist can make to the attributes of an enzyme and reports the rate of product formation ([P]), substrate ultilization ([S]) and the information about the amount of free enzyle ([E]) complexed with substrate ([ES])."),
				p("These calculations are same as those performed daily by enzyme kineticists, and apps like this are useful experimental tools."),

				strong("The simulation's parameters:"),
				br(),
				img(src="mechanism.png"),

				p("k1 forward: the forward rate of substrate [S] binding to enzyme [E], forming an enzyme-substrate complex [ES]."),
				p("k1 reverse: the reverse rate of substrate [S] unbinding from the enzyme-substrate complex [ES], before reaching the \"catalytic step\"."),
				p("k2: the conversion rate of the bounded substrate [ES] to product [P], which happens in the \"catalytic step\""),
				p("S: the initial concentration of the substrate."),
				p("E: the initial concentration of the enzyme. Its maximum value matches that of the substrate's because Michaelis-Menten kinetics only holds true when [S] >> [E]."),

				h3("Epilogue"),
				p(
					"Enzyme kinetics is a huge field, and this WebApp only covers the \"visualization\" of it. For more information, you should take a look at the ", a("Wikipedia page,",href="https://www.wikiwand.com/en/Enzyme_kinetics"), 
					"or this well-written ", a("commemorative article", href="http://onlinelibrary.wiley.com/doi/10.1111/febs.12598/pdf"),
					"on the classic 1913 manuscript of Michaelis and Menten."
				)
			)
		)
	)
))
