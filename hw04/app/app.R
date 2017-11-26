library(shiny)
library(ggplot2)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  mainPanel(
    tabsetPanel(
      tabPanel("Barchart",
            column(4,tableOutput('table')),
            column(8,plotOutput("plot1"))
           ),
      tabPanel("Histgram",
            column(3,
        selectInput("x_variable1", "X variable",
                    list(X_variable=c("HW1","HW2","HW3","HW4","HW5","HW6","HW7"     
                                      ,"HW8","HW9","ATT","QZ1","QZ2","QZ3","QZ4"     
                                      ,"EX1","EX2","Test1","Test2","Homework","Quiz","Lab"     
                                      ,"Overall"))),
        sliderInput(inputId = "bins",
                    label = "bins Width:",
                    min = 1,
                    max = 10,
                    value = 5)),
        column(8,
          plotOutput("plot2")),
          h4('Summary'),
          verbatimTextOutput('sum')     

      ),
      tabPanel("Scatterplot", 
               column(4,selectInput("x_variable2", "X variable",
                    list(X_variable=c("HW1","HW2","HW3","HW4","HW5","HW6","HW7"     
                                      ,"HW8","HW9","ATT","QZ1","QZ2","QZ3","QZ4"     
                                      ,"EX1","EX2","Test1","Test2","Homework","Quiz","Lab"     
                                      ,"Overall"))),
        selectInput("y_variable2", "Y variable",
                    list(Y_variable=c("HW1","HW2","HW3","HW4","HW5","HW6","HW7"     
                                      ,"HW8","HW9","ATT","QZ1","QZ2","QZ3","QZ4"     
                                      ,"EX1","EX2","Test1","Test2","Homework","Quiz","Lab"     
                                      ,"Overall"))),
        
        sliderInput(inputId = "alpha1",
                    label = "Opacity:",
                    min = 0,
                    max = 1,
                    value = 0.5),
        checkboxInput("None", "None", TRUE),
        checkboxInput("lm", "lm", FALSE),
        checkboxInput("loess", "loess", FALSE))
      ,
      column(8,plotOutput("plot3")),
      h4("Correlation"),textOutput("result"))
  )
)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  mydata<-read.csv('cleanscores.csv',header = TRUE)
  
  #one
  plotdata1<-data.frame(table(mydata$Grade))
  plotdata1$Prop<-round(plotdata1$Freq/sum(plotdata1$Freq),2)
  names(plotdata1)<-c('Grade','Freq','Prop')
  output$table <- renderTable({plotdata1})
  
  
  output$plot1<-renderPlot({
    ggplot(plotdata1,aes(x=Grade,y=Freq))+geom_bar(stat = "identity")})
  
  #two
  x_variable1 <- reactive({
    input$x_variable1
  })
  
  output$plot2<-renderPlot({
    ggplot(data=mydata, aes_string(x_variable1()))+ geom_histogram(bins =input$bins)
  })
  
  summarydata<-reactive({
    temp<-subset(mydata,select =x_variable1())
    temp
  })
  
  
  output$sum <- renderPrint({
    summary(summarydata())
  })
  
  
  #there
  x_variable2 <- reactive({
    input$x_variable2
  })
  
  y_variable2 <- reactive({
    input$y_variable2
  })
  
  output$plot3<-renderPlot({
    if (input$lm) {
      myplot<-ggplot(data=mydata, aes_string(x=x_variable2(),y=y_variable2()))+ geom_point(size = 2,alpha =input$alpha1)
      myplot<-myplot + geom_smooth(method = "lm", se = FALSE)
    }
    if (input$loess) {
      myplot<-ggplot(data=mydata, aes_string(x=x_variable2(),y=y_variable2()))+ geom_point(size = 2,alpha =input$alpha1)
      myplot<-myplot + geom_smooth()
    }
    if (input$None){
      myplot<-ggplot(data=mydata, aes_string(x=x_variable2(),y=y_variable2()))+ geom_point(size = 2,alpha =input$alpha1)
    }
    myplot
  })
  
  cordata1<-reactive({
    temp<-data.matrix(subset(mydata,select =x_variable2()))
    temp
  })
  
  cordata2<-reactive({
    temp<-data.matrix(subset(mydata,select =y_variable2()))
    temp
  })
  
  cordata<-reactive({
    temp<-cor(cordata1(),cordata2())
    temp
  })
  
  output$result<-renderText({
    cordata()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)