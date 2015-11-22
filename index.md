Shiny app pitch presentation
========================================================
author: Olgierd Grodzki
date: 

Introduction
========================================================

This presentation contains the pitch for a data product app created as part of the project for the Developing Data Products course. It shortly describes the capabilities of the app and shows some implementation details and results.

The app was developed in R using the shiny framework. The code for this app can be found [here](https://github.com/olgierdg/DevelopingDataProducts_Project) and the app is hosted [here](https://olgierdg.shinyapps.io/shiny).


App overview
========================================================

The developed app allows the user to:

- experiment with building linear regression models by choosing different predictors,
- build a baseline 'best' model achieved by stepwise regression.

The data set used in this app is the mtcars dataset available in R. The target variable for the linear regression is the mpg variable.

Some implementation details
========================================================

Choosing different predictors for the experiment is implemented by providing a checkbox for each available predictor in the UI. Then, on the server side, the vector of chosen predictors is processed as follows:


```r
i_preds <- c("wt","qsec","am")
preds <- paste(i_preds,collapse=" + ")
paste("mpg ~", preds)
```

```
[1] "mpg ~ wt + qsec + am"
```

This processed formula is then used in the lm function call.

Results example
========================================================

![Results example][id]

[id]: results.png "Results example"