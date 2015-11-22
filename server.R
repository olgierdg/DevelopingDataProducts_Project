library(shiny)
library(tools)
library(utils)

data(mtcars)
mtcars$am <- factor(mtcars$am)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

shinyServer(
    
    function(input, output) {
        
        output$modelSummary <- renderPrint({
            
            if (input$modelButton == 0)
                return()
            
            if(length(isolate(input$predictors)) == 0){
                return("Please specify at least 1 predictor")
            }
            
            input$modelButton
            
            predictors <- paste(isolate(input$predictors),collapse=" + ")
            formula <- paste("mpg ~", predictors)
            
            print(paste("Formula: ",formula))
            
            model <- lm(formula, data = mtcars)
            
            print(summary(model))
            
            output$modelPlot <- renderPlot({
                par(mfrow = c(2,2))
                plot(model)
            })
            
        })
        
        output$bestModelSummary <- renderPrint({
            
            if (input$bestModelButton == 0)
                return()
            
            input$bestModelButton
            
            init_model <- lm(mpg ~ ., data = mtcars)
            capture.output(final_model <- step(init_model, direction = "backward"), file='NUL')
            
            print(summary(final_model))
            
            output$bestModelPlot <- renderPlot({
                par(mfrow = c(2,2))
                plot(final_model)
            })
        })
        
        output$mtcars_desc <- renderPrint({
            cat(helpExtract(mtcars, section = "Desc", type = "m_text"))
        })
        
        output$mtcars_format <- renderPrint({
            cat(helpExtract(mtcars, section = "Format", type = "m_text"))
        })
        
        output$mtcars_source <- renderPrint({
            cat(helpExtract(mtcars, section = "Source", type = "m_text"))
        })
        
        # Source http://stackoverflow.com/a/20165267/1270695
        helpExtract <- function(Function, section = "Usage", type = "m_code", ...) {
            A <- deparse(substitute(Function))
            x <- capture.output(tools:::Rd2txt(utils:::.getHelpFile(help(A, ...)),
                                               options = list(sectionIndent = 0)))
            B <- grep("^_", x)                    ## section start lines
            x <- gsub("_\b", "", x, fixed = TRUE) ## remove "_\b"
            X <- rep(FALSE, length(x))
            X[B] <- 1
            out <- split(x, cumsum(X))
            out <- out[[which(sapply(out, function(x) 
                grepl(section, x[1], fixed = TRUE)))]][-c(1, 2)]
            while(TRUE) {
                out <- out[-length(out)]
                if (out[length(out)] != "") { break }
            } 
            
            switch(
                type,
                m_code = c("```r", out, "```"),
                s_code = c("<<>>=", out, "@"),
                m_text = paste("    ", out, collapse = "\n"),
                s_text = c("\\begin{verbatim}", out, "\\end{verbatim}"),
                stop("`type` must be either `m_code`, `s_code`, `m_text`, or `s_text`")
            )
        }
        
    }
    
    
)