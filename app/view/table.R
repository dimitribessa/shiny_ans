 #' app/view/table.R
 #' 
 box::use(
    shiny[tags, NS, moduleServer],
    reactable,
    dplyr[left_join],
 )

 box::use(
    app/view/cards,
    app/logic/load_data,
 )


 #' @export
  ui <- function(id, header = 'Título', height = '350px'){
    ns <- NS(id)
    cards$card_i(header = header,
              reactable$reactableOutput(ns('table'), height = height))
 }

 #' @export
 server <- function(id, data){
    moduleServer(id, function(input, output, session){
        ns <- session$ns
        output$table <- reactable$renderReactable({
        
 operadora <- load_data$operadoras()
         dadoi <- data()
         dadoi <- aggregate(cbind(nr_benef_o, nr_benef_m, nr_benef_t) ~ cd_operado, data = dadoi, FUN = sum, na.rm = T)
         dadoi <- dadoi[order(dadoi$nr_benef_t, decreasing = T),]
         dadoi <- left_join(dadoi, operadora[,-1], by = c('cd_operado' = 'cod_num'))
         dadoi <- dadoi[,c(5,2:4)]
         names(dadoi) <- c('Nome da operadora', 'Qtd. planos odontológicos', 'Qtd. planos a. médica', 'Total')

            reactable$reactable(dadoi[1:10,],pagination = F)
        })
    })
 }
