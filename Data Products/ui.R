library(shiny) 
shinyUI(fluidPage(
    # Application title 
    h3("Concrete compressive strength calculation"),
    tabsetPanel(
      tabPanel("Calculation", fluidRow(
        column(12,
               p(),
               tags$i('Use the sliders to select age and ingredients of the concrete mixture. The calculated the compressive strength appears below. For more information about the calculation see the Doucmentation tab.'),
               tags$hr()
        )), fluidRow(
          column(4,
                 sliderInput('cement', 'Cement (kg in a m3 mixture)', value=540, min=0, max=5000, step=0.1),
                 sliderInput('blast', 'Blast Furnace Slag (kg in a m3 mixture)', 5.45, min=0, max=5000, step=0.1), 
                 sliderInput('flyash', 'Fly Ash (kg in a m3 mixture)', value=0, min=0, max=5000, step=0.1)
          ), column(4,
                    sliderInput('water', 'Water', value=162, min=0, max=5000, step=0.1),
                    sliderInput('supertplast', 'Superplasticizer (kg in a m3 mixture)', value=2.5, min=0, max=5000, step=0.1),
                    sliderInput('coarseaggr', 'Coarse Aggregate', value=1040, min=0, , max=5000, step=0.1) 
          ), column(4,
                    sliderInput('fineagg', 'Fine Aggregate (kg in a m3 mixture)', value=676, min=0, max=5000, step=0.1),
                    sliderInput('age', 'Age (Days 1~365)', value=28, min=1, max=365, step=1)
          )), fluidRow(
            column(6,
                   tags$hr(),
                   #h3('Results of calculation'),
                   h4('Compressive strength (MPa)'), 
                   verbatimTextOutput("prediction")
            ) 
          )
      ), 
      tabPanel("About", 
               p(),
               "This application calculates the compressive strength of concrete based on its age and igredients.",
               "You can use the sliders to adjust the parameters. The calculated compressive strength will show on the same page below.",
               p(),
               "The calculation is based on R's Support Vector Machines.",
                "This machine learning method fits a non-linear regression model for the compression strength of concrete.",
               "For more information see",
               tags$a("https://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Classification/SVM"),
               p(),
               "The data used for fitting the model has been obtained from ",
               tags$a("https://archive.ics.uci.edu/ml/datasets/Concrete+Compressive+Strength") 
              )
    )
  )
)
