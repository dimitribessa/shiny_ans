 #' app/view/linechart.R
 #' 
 box::use(
    shiny[NS, moduleServer],
 )

 box::use(
    app/view/apexcharts,
    app/view/cards[card_i],
 )

 #' @export
 ui <- function(id, header = 'Título', height = '100%'){
    ns <- NS(id)
    card_i(header = header,
              apexcharts$apexchartOutput(ns('chart'), height = height))
 }

 #' @export
 server <- function(id, data){
    moduleServer(id, function(input, output, session){
        ns <- session$ns
        output$chart <- apexcharts$renderApexchart ({
         dadoi <- data()[,3:5]
          nomes <- c('Planos a. médica', 'Planos odontológico', 'Todos')
          xaxis <-dadoi[,2]
          dadoi <- lapply(1:3, \(x){list(name = nomes[x], data = dadoi[,x])}) |> unname()
         
        list(
            series = dadoi,
            chart = list(
                height = '100%',
                type = 'area'
            )
            ,
            dataLabels = list(enabled = FALSE)
            ,
            stroke = list(curve = 'smooth', width = 1)
            ,
            xaxis = list(categories =c(xaxis))

        )
        })
    })
 }