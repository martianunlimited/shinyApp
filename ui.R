
library(shiny)


shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Vehicle Performance Predictor"),
  
  # Sidebar with slider and numeric inputs
  sidebarPanel(
    h3("Documentation"),
    p("This shinyApp takes in the weight, number of cylinders and transmission type of your car
      to predict the fuel efficiency (in miles per gallon),power (in hp), quarter mile time (in sec) 
      and displacement (in cubic inches)"),
    p("Adjust the slider to change the weight of the car, and change the radio buttons to change the number of cylinders 
      and transmission type. The results is displayed in the plots on the right, with the prediction marked as
      a blue circle. A fitted line is available to show how the parameter responds to changes in the weight.
      Numerical values of the prediction are displayed on the plots and at the bottom"),

    
    h3("Car attributes"),
    sliderInput('weight',label= h4("Weight (lb/1000)"),min=1.5,max=5.5,value=3),
    radioButtons("transmission", label = h4("Transmission Type"), 
                 choices = list("Automatic" = 0, "Manual" = 1), selected = 0),
    radioButtons("cylinders", label = h4("No. Cylinders"), 
                 choices = list("4" = 4, "6" = 6, "8" = 8), selected = 8),
    helpText("Disclaimer: the the results with a pinch of salt, this application is for the purpose 
             of demonstatrating how we can create an application in shiny, and not for practical purposes")
    
    ),
  
  
  # Show the result of the prediction and a histogram as a reference
  mainPanel(
    h4('Model description'),
    p('We model the responses using the model below, where wt is the weight, cyl is the number of cylinders 
      and am is the transmission type'),
    code('predictor <- lm(response ~ wt * (cyl + am),data=mtcars)',align='center'),
    h3('Result of the car performance predictor, with fitted line'),
#    h3('Your predicted fuel consumption'),
#    verbatimTextOutput("prediction"),
#    br(),
#    h4('As a reference, here is how your car fares with respect to others:'),
    plotOutput("distPlot"),
   plotOutput("distPlot2"),
h5('Estimated Fuel Efficiency'),
verbatimTextOutput("predictionMPG"), 
h5('Estimated Horse Power'),
verbatimTextOutput("predictionHP"),
h5('Estimated Quarter Mile Time'),
verbatimTextOutput("predictionQSEC"), 
h5('Estimated Displacement'),
verbatimTextOutput("predictionDISP")

  )
  )
  )