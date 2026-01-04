 #' app/view/bar_chart.R
 #' 
 box::use(
    shiny[NS, moduleServer],
    stats[aggregate],
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
         dadoi <- data()

         func_troca <- \(x){switch(x,'1 a 10.000 beneficiários', '1 a 10.000 beneficiários',
         '1 a 10.000 beneficiários',
         '1 a 10.000 beneficiários', '1 a 10.000 beneficiários',
            '10.001 a 20.000 beneficiários', '20.001 a 50.000 beneficiários',
            '50.001 a 100.000 bneficiários', '100.001 a 500.000 beneficiários',
            '> 500.000 beneficiários')}
         
         dadoi$porte <- sapply(dadoi$porte, func_troca, simplify = T)
         dadoi <- aggregate(nr_benef_t ~ porte, data = dadoi, FUN = sum, na.rm = T)
         dadoi <- dadoi[order(dadoi$nr_benef_t, decreasing = T),]
         
         xaxis <- as.character(dadoi[,1])
         dadoi <- list(data = dadoi$nr_benef_t, name = 'Qtd. Beneficiários')

        list(
            series = list(dadoi),
            chart = list(
                height = '100%',
                type = 'bar'
            )
            ,
            plotOptions = list(bar = list(borderRadius = 4,borderRadiusApplication = 'end', horizontal = TRUE))
            ,
            dataLabels = list(enabled = FALSE)
            ,            
            xaxis = list(categories =c(xaxis))

        )
        })
    })
 }