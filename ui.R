library(shiny)
shinyUI(navbarPage('Developing Data Products Project', id="page", collapsible=TRUE, inverse=FALSE,
                   tabPanel("App",
                            
                            headerPanel("Building a prediction model for MPG in the mtcars dataset"),
                            
                            sidebarPanel(
                                h2('Custom linear regression'),
                                checkboxGroupInput("predictors", "Choose predictors",
                                                   c("cyl"  = "cyl",
                                                     "disp" = "disp",
                                                     "hp"   = "hp",
                                                     "drat" = "drat",
                                                     "wt"   = "wt",
                                                     "qsec" = "qsec",
                                                     "vs"   = "vs",
                                                     "am"   = "am",
                                                     "gear" = "gear",
                                                     "carb" = "carb")),
                                actionButton("modelButton", "Build custom model"),
                                h2('Best linear regression'),
                                actionButton("bestModelButton", "Build best model (stepwise regression)")
                            ),
                            mainPanel(
                                h2('Custom linear regression'),
                                h3('Summary'),
                                verbatimTextOutput("modelSummary"),
                                h3('Plots'),
                                plotOutput("modelPlot"),
                                h2('Best linear regression'),
                                h3('Summary'),
                                verbatimTextOutput("bestModelSummary"),
                                h3('Plots'),
                                plotOutput("bestModelPlot")
                            )
                   ),
                   tabPanel("Documentation",
                            headerPanel("App documentation"),
                            wellPanel(
                                h2('Overview'),
                                p('This app allows the user to experiment with building linear 
                                  regression models by choosing different predictors. Additionally, 
                                  it provides a baseline \'best\' model achieved by stepwise
                                  regression.'),
                                h2('Dataset details'),
                                p('The data set used in this app is the mtcars dataset
                                  available in R. The target variable for the linear
                                  regression is the mpg variable. Below is the description of the 
                                  data set and its format, which explains the meaning of
                                  the predictor codes.'),
                                h3('Description'),
                                verbatimTextOutput("mtcars_desc"),
                                h3('Format'),
                                verbatimTextOutput("mtcars_format"),
                                h3('Source'),
                                verbatimTextOutput("mtcars_source"),
                                h2('App usage'),
                                p('Using the app involves selecting checkboxes for chosen predictors
                                  and clicking the build model button, or just clicking the button for
                                  the  \'best\' model.')
                            )
                   )
))