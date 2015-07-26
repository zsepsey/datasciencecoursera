library(shiny) 

initModel <- function() {
  set.seed(3523)
  library(AppliedPredictiveModeling)
  data(concrete)
  inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
  training = concrete[ inTrain,]
  testing = concrete[-inTrain,]
  library(e1071)
  fit <- svm(CompressiveStrength~., training)
  testing$pr5 <- predict(fit, testing)
  testing$error <- testing$CompressiveStrength - testing$pr5
  rmse <- sqrt(mean(testing$error ^ 2))
  print(rmse) #6.715009
  
  saveRDS(fit, "concreteModel.RDS")
}
initModel_noTrain <- function() {
  set.seed(3523)
  library(AppliedPredictiveModeling)
  data(concrete)
  library(e1071)
  model <- svm(CompressiveStrength~., data=concrete)
  saveRDS(model, "concreteModel.RDS")
}
initModel()

calc_prediction <- function(concreteData) {
  c <- data.frame(t(unlist(concreteData)))
  names(c) <- names(concrete)[1:8]
  print(c)
  model = readRDS("concreteModel.RDS")
  pred <- predict(model, c)
  as.numeric(pred)
}

shinyServer( function(input, output) {
  concreteData <- reactive(c(input$cement, input$blast, input$flyash, input$water,
                          input$supertplast,input$coarseaggr, input$fineagg, input$age))
  
  output$prediction <- renderText({
#    if (input$goButton > 0) 
    calc_prediction(concreteData())
  })
} 
)