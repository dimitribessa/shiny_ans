 #' app/view/input_data.R

box::use(
    shiny[tags, tagList, selectInput, NS, moduleServer, eventReactive, actionButton ],
    htmltools[tagAppendAttributes],
    stats[aggregate],
 )

box::use(
    app/logic/load_data,
 )

dado <- load_data$func_load()

porte <- c('Todos' = 0,'1 a 10.000 beneficiários' = 1,
            '10.001 a 20.000 beneficiários' = 2, '20.001 a 50.000 beneficiários' = 3,
            '50.001 a 100.000 bneficiários' = 4, '100.001 a 500.000 beneficiários' = 5,
            '> 500.000 beneficiários' = 6)

contrato <- c('Todos'= 99, 'Individual/familiar' = 1, 'Coletivo empresarial' = 2, 'Coletivo por adesão' = 3,
              'Coletivo não identificado' = 4)

#' @export
ui <- function(id){
    ns <- NS(id)
    tagList(
        selectInput(ns('periodo'), label = 'Competência', choices = unique(dado$id_cmpt), selected = max(unique(dado$id_cmpt))) |> tagAppendAttributes(class = "px-2"),
        selectInput(ns('porte'), label = 'Porte das empresas', choices = porte, selected = 'Todos') |> tagAppendAttributes(class = "px-2"),
        selectInput(ns('contrato'), label = 'Tipo de contrato', choices = contrato, selected = 'Todos') |> tagAppendAttributes(class = "px-2"),
        actionButton(ns('atualizar'), 'Atualizar')
    )
 }

#' @export
server_dadoi <- function(id){
    moduleServer(id, function(input, output, session){
        ns <- session$ns
      eventReactive(input$atualizar,{
            dadoi <- dado[which(dado$id_cmpt == input$periodo & dado$ops_atv == 1),]
            if(input$porte != 'Todos'){
                if(as.numeric(input$porte) == 1){dadoi <- subset(dadoi, porte %in% 1:5)}
                if(as.numeric(input$porte) == 2){dadoi <- subset(dadoi, porte == 6)}
                if(as.numeric(input$porte) == 3){dadoi <- subset(dadoi, porte == 7)}
                if(as.numeric(input$porte) == 4){dadoi <- subset(dadoi, porte == 8)}
                if(as.numeric(input$porte) == 5){dadoi <- subset(dadoi, porte == 9)}
                if(as.numeric(input$porte) == 6){dadoi <- subset(dadoi, porte == 10)}
            }
            if(input$contrato != '99'){
                dadoi <- subset(dadoi, cd_contr == as.numeric(input$contrato))
            }
            dadoi
        }, ignoreNULL = F)

    })
 }

 #' @export
 server_serie <- function(id){
    moduleServer(id, function(input, output, session){
        ns <- session$ns
      eventReactive(input$atualizar,{
            dadoi <- dado[dado$ops_atv == 1,]
            if(input$porte != 'Todos'){
                if(as.numeric(input$porte) == 1){dadoi <- subset(dadoi, porte %in% 1:5)}
                if(as.numeric(input$porte) == 2){dadoi <- subset(dadoi, porte == 6)}
                if(as.numeric(input$porte) == 3){dadoi <- subset(dadoi, porte == 7)}
                if(as.numeric(input$porte) == 4){dadoi <- subset(dadoi, porte == 8)}
                if(as.numeric(input$porte) == 5){dadoi <- subset(dadoi, porte == 9)}
                if(as.numeric(input$porte) == 6){dadoi <- subset(dadoi, porte == 10)}
            }
            if(input$contrato != '99'){
                dadoi <- subset(dadoi, cd_contr == as.numeric(input$contrato))
            }
            aggregate(cbind(nr_benef_m, nr_benef_o, nr_benef_t) ~ id_cmpt + competencia, data = dadoi, FUN = sum, na.rm = T)         
        }, ignoreNULL = F)

    })
 }