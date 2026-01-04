 # app/main.R

box::use(
  #shiny[htmlTemplate,moduleServer, NS, uiOutput],
  utils[head],
  shiny[moduleServer, NS, fluidPage,  fluidRow, column, tagList, tags, reactive, uiOutput, renderUI, HTML],
)

box::use(
  app/view/apexcharts,
  app/view/cards,
  app/view/layouts,
  app/view/input_data,
  app/view/line_chart,
  app/view/div_lines,
  app/view/bar_chart,
  app/view/sankey,
  app/view/table,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
 # caminho <- getwd()
  #htmlTemplate(filename = file.path(caminho,'app/static/pages/dashboard.html'))
  layouts$main_page(
    layouts$navbar(title = 'Beneficiários de Saúde Complementar em SC',
     input_data$ui(ns('dados'))),
    tags$div(class="container-fluid py-4",
    fluidRow(
      column(3,
      uiOutput(ns('card_totaloperadoras')))
      ,
      column(3,
      uiOutput(ns('card_beneficiarios'))
      )
      ,
      column(3,
      uiOutput(ns('card_totalmedico'))
      )
      ,
      column(3,
      uiOutput(ns('card_totalodonto'))
      )
      ) #endrow
      
  ,
  fluidRow( class = 'pt-6',
    column(6,
    line_chart$ui(ns("chart"), header = "Série de tempo", height = '20rem')
    ),
    column(6,
    div_lines$ui(ns('divlines'), title = 'Tipo de contrato')
    )
  ),
  fluidRow( class = 'pt-6',
    column(5,
    bar_chart$ui(ns('barchart'), header = "Beneficiários por porte das operadoras", height = '25rem')
    )
    ,
    column(7,
    sankey$ui(ns('sankey'), header = 'Diagrama Sankey (Plano >> Porte >> Tipo contrato)', height = '25rem'))
  ) #endrow
  ) #edn div
  
  )#end main_page
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
   dado <- input_data$server_dadoi('dados')
   dado_serie <- input_data$server_serie('dados')

   #' card total operadoras
   output$card_totaloperadoras <- renderUI({
              dadoi <- as.data.frame(table(dado()$cd_operado))
              dadoi <- cards$func_format(nrow(dadoi), 'Total de operadoras')
              cards$card(icon = "ni ni-fat-add", tag = dadoi)
              })

  #' card total beneficiários
   output$card_beneficiarios <- renderUI({
              dadoi <- sum(dado()$nr_benef_t, na.rm = T)
              dadoi <- cards$func_format(dadoi, 'Total de beneficiários')
              cards$card(icon = "ni ni-single-02", tag = dadoi)
              })

  #' card total de beneficiários de assistência médica
   output$card_totalmedico <- renderUI({
              dadoi <- sum(dado()$nr_benef_m, na.rm = T)
              dadoi <- cards$func_format(dadoi, 'Beneficiários de assistência médica')
              cards$card(icon = "ni ni-ambulance", tag = dadoi)
              })

  #' card total de planos odontológicos
   output$card_totalodonto <- renderUI({
              dadoi <- sum(dado()$nr_benef_o, na.rm = T)
              dadoi <- cards$func_format(dadoi, 'Beneficiários de planos odontológicos')
              cards$card(icon = "ni ni-shop", tag = dadoi)
              })

  #' linechart  
  line_chart$server('chart', data = dado_serie)

  #' divlines
  div_lines$server('divlines', data = dado)

  #' barchart
  bar_chart$server('barchart', data = dado)
   
  #' sankey
  sankey$server('sankey', data = dado)

   }) #end module server
}