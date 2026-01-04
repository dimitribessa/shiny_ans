 #' app/view/apexcharts.R
 #' 
 box::use(shiny[tags, tagList, installExprFunction, div],
        htmltools[validateCssUnit, singleton],
 )

 
# To be called from ui.R
 apexchartOutput <- function(inputId, width="100%", height="100%") { 
    
  style <- sprintf("width: %s; height: %s;",
    validateCssUnit(width), validateCssUnit(height))
  
  tagList(
    # Include CSS/JS dependencies. Use "singleton" to make sure that even
    # if multiple lineChartOutputs are used in the same page, we'll still
    # only include these chunks once.
    singleton(tags$head(
      tags$script(src="https://cdn.jsdelivr.net/npm/apexcharts"),
      tags$script(src ='static/assets/js/apex_general.js')
    )),
    div(id=inputId, class="apexchart", style = style,
    #tag("svg", list())
    )
  )
 }
 
 # To be called from server.R
 renderApexchart <- function(expr, env=parent.frame(), quoted=FALSE) {
  # This piece of boilerplate converts the expression `expr` into a
  # function called `func`. It's needed for the RStudio IDE's built-in
  # debugger to work properly on the expression.
  installExprFunction(expr, "func", env, quoted)
  
  function() {
    dataframe <- func()
     dataframe
  }
   
 }