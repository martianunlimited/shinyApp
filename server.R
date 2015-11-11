

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(MASS)
library(datasets)
data("mtcars")
mtcars$cyl=as.factor(mtcars$cyl)
mtcars$am=as.factor(mtcars$am)
fitMPG=lm(formula = mpg ~ wt * (am + cyl), data = mtcars)
fitHP=lm(formula = hp ~ wt * (am + cyl), data = mtcars)
fitQSEC=lm(formula = qsec ~ wt * (am + cyl), data = mtcars)
fitDISP=lm(formula = disp ~ wt * (am + cyl), data = mtcars)


mpgLine <- function(weight,transmission,cylinders){
    coefs=coefficients(fitMPG)
    cyl6=ifelse(cylinders==6,1,0);
    cyl8=ifelse(cylinders==8,1,0);

    intercept=coefs[1]+transmission*coefs[3]+cyl6*coefs[4]+cyl8*coefs[5]
    slope=coefs[2]+transmission*coefs[6]+cyl6*coefs[7]+cyl8*coefs[8]
    pred=intercept+slope*weight;
    c(intercept,slope,pred)
} 

hpLine <- function(weight,transmission,cylinders){
  coefs=coefficients(fitHP)
  cyl6=ifelse(cylinders==6,1,0);
  cyl8=ifelse(cylinders==8,1,0);
  
  intercept=coefs[1]+transmission*coefs[3]+cyl6*coefs[4]+cyl8*coefs[5]
  slope=coefs[2]+transmission*coefs[6]+cyl6*coefs[7]+cyl8*coefs[8]
  pred=intercept+slope*weight;
  c(intercept,slope,pred)
}

qsecLine <- function(weight,transmission,cylinders){
  coefs=coefficients(fitQSEC)
  cyl6=ifelse(cylinders==6,1,0);
  cyl8=ifelse(cylinders==8,1,0);
  
  intercept=coefs[1]+transmission*coefs[3]+cyl6*coefs[4]+cyl8*coefs[5]
  slope=coefs[2]+transmission*coefs[6]+cyl6*coefs[7]+cyl8*coefs[8]
  pred=intercept+slope*weight;
  c(intercept,slope,pred)
}

dispLine <- function(weight,transmission,cylinders){
  coefs=coefficients(fitDISP)
  cyl6=ifelse(cylinders==6,1,0);
  cyl8=ifelse(cylinders==8,1,0);
  
  intercept=coefs[1]+transmission*coefs[3]+cyl6*coefs[4]+cyl8*coefs[5]
  slope=coefs[2]+transmission*coefs[6]+cyl6*coefs[7]+cyl8*coefs[8]
  pred=intercept+slope*weight;
  c(intercept,slope,pred)
}


shinyServer(
  
  function(input, output) {
#For Debugging    
##    output$inputValue1 <- renderPrint({input$weight})
#    output$inputValue2 <- renderPrint({input$transmission})
#    output$inputValue3 <- renderPrint({input$cylinders})
#    output$inputValue4 <- renderPrint({input$gearCount})
#    output$inputValue5 <- renderPrint({input$carbCount})
#    output$inputValue6 <- renderPrint({input$engineType})
    output$predictionMPG <- renderPrint({
      transmission=as.numeric(input$transmission);
      cylinders=as.numeric(input$cylinders);
      data=mpgLine(input$weight,transmission,cylinders);
      
      sprintf("MPG = %0.2f",data[3])
      })
    
    output$predictionHP <- renderPrint({
      transmission=as.numeric(input$transmission);
      cylinders=as.numeric(input$cylinders);
      data=hpLine(input$weight,transmission,cylinders);
      
      sprintf("HP = %0.2f",data[3])
    })
    output$predictionQSEC <- renderPrint({
      transmission=as.numeric(input$transmission);
      cylinders=as.numeric(input$cylinders);
      data=qsecLine(input$weight,transmission,cylinders);
      
      sprintf("qsec = %0.2f",data[3])
    })
    output$predictionDISP <- renderPrint({
      transmission=as.numeric(input$transmission);
      cylinders=as.numeric(input$cylinders);
      data=dispLine(input$weight,transmission,cylinders);
      
      sprintf("disp = %0.2f",data[3])
    })
    
    
    output$distPlot <- renderPlot({
      
      y <- mtcars$mpg
      x <- mtcars$wt
      par(mfrow=c(1,2))
      plotch=as.numeric(mtcars$cyl)
      plot(x,y,col=mtcars$am,pch=plotch, ylab="Fuel Efficiency (mpg)", xlab="weight")
      transmission=as.numeric(input$transmission);
      cylinders=as.numeric(input$cylinders);
      mpgParam=mpgLine(input$weight,transmission,cylinders);
      points(input$weight,mpgParam[3],pch=19,col="blue")
      text(2.2,max(mtcars$mpg),sprintf("mpg = %0.2f",mpgParam[3]), col="blue")
      abline(a=mpgParam[1],b=mpgParam[2])
      legend("topright","Predicted",pch=19,col="blue")
      plot(x,mtcars$hp,col=mtcars$am,pch=plotch, ylab="horsepower (hp)", xlab="weight")
      
      hpParam=hpLine(input$weight,transmission,cylinders);
      points(input$weight,hpParam[3],pch=19,col="blue")
      text(2.2,max(mtcars$hp),sprintf("hp = %0.2f",hpParam[3]), col="blue")
      abline(a=hpParam[1],b=hpParam[2])
      
      legend("topright","Predicted",pch=19,col="blue")
      
#      plot(x,mtcars$qsec,col=mtcars$am,pch=plotch)
#      plot(x,mtcars$disp,col=mtcars$am,pch=plotch)
      
      
#      
    })

    output$distPlot2 <- renderPlot({
      
      # generate bins based on input$bins from ui.R
      x <- mtcars$wt
      par(mfrow=c(1,2))
      plotch=as.numeric(mtcars$cyl)
      plot(x,mtcars$qsec,col=mtcars$am,pch=plotch,ylab="qsec (s)", xlab="weight")
      #plot(x,y,col=mtcars$am,pch=plotch)
      transmission=as.numeric(input$transmission);
      cylinders=as.numeric(input$cylinders);
      
      qsecParam=qsecLine(input$weight,transmission,cylinders);
      points(input$weight,qsecParam[3],pch=19,col="blue")
      text(2.2,max(mtcars$qsec),sprintf("qsec = %0.2f",qsecParam[3]), col="blue")
      
      abline(a=qsecParam[1],b=qsecParam[2])
      legend("topright","Predicted",pch=19,col="blue")
      #plot(x,mtcars$hp,col=mtcars$am,pch=plotch)
      
      plot(x,mtcars$disp,col=mtcars$am,pch=plotch, ylab="displacement (cu.in)", xlab="weight")
      dispParam=dispLine(input$weight,transmission,cylinders);
      points(input$weight,dispParam[3],pch=19,col="blue")
      text(2.2,max(mtcars$disp),sprintf("disp = %0.2f",dispParam[3]), col="blue")
      
      abline(a=dispParam[1],b=dispParam[2])
      legend("topright","Predicted",pch=19,col="blue")
      
      
      #      
    })
    
    
        
        
  })

