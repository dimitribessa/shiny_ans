 #' app/view/sanky.R
 #' 
 box::use(
    shiny[NS, moduleServer],
 )

 box::use(
    app/logic/transform_data[func_sankeydata],
    app/view/echarts,
    app/view/cards[card_i],
 )

 #' @export
 ui <- function(id, header = 'Título', height = '100%'){
    ns <- NS(id)
    card_i(header = header,
              echarts$echartsOutput(ns('chart'), height = height))
 }

 #' @export
 server <- function(id, data){
    moduleServer(id, function(input, output, session){
        ns <- session$ns
        output$chart <- echarts$renderEcharts({
         dadoi <- data()
         dadoi <- func_sankeydata(dadoi)

        list(
            series = list(
                type = 'sankey',
                data = dadoi[[1]],
                links = dadoi[[2]],
                 emphasis = list(focus = 'adjacency')
                ,
                lineStyle = list(color = 'gradient', curveness = 0.5)),
            tooltip = list(trigger = 'item', triggerOn = 'mousemove')
        )
        })
    })
 }