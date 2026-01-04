 #' app/view/div_lines.R
 #' 
 box::use(
    shiny[tags, tagList, NS, moduleServer, renderUI, uiOutput],
 )

 box::use(
    app/view/cards[card_i],
 )

 #'
 #' 
 
 func_barras <- function(x,y,z){
    tagList(
        tags$li(class="list-group-item border-0 d-flex align-items-center px-0 mb-2",
            tags$div(class = 'w-100',
                tags$div(class = "d-flex mb-2",
                tags$span(class = "me-2 text-sm font-weight-bold text-dark", x),
                tags$span(class="ms-auto text-sm font-weight-bold", y)
                )
                ,
                tags$div(class = "progress progress-md",
                    tags$div(class = paste0("progress-bar bg-primary w-",z), role="progressbar",  `aria-valuemin`="0" ,`aria-valuemax`="100"))
            )
        )
    )
 }

 #' arredondamentos
 mround <- function(x,base){
	base*round(x/base)
}

 #' @export
 ui <- function(id, title = "Título"){
    ns <- NS(id)
    card_i(header = title,
    uiOutput(ns('chart')))
 }

 #' @export
 server <- function(id, data){
    moduleServer(id, function(input, output, session){
       
    output$chart <- renderUI({
         dadoi <- data()
        dadoi <- as.data.frame(table(dadoi$cd_contr))
        dadoi$perc <- round(dadoi$Freq*100/sum(dadoi$Freq),2)
    func_troca <- \(x){switch(x,'Individual/familiar', 'Coletivo empresarial', 'Coletivo por adesão',
              'Coletivo não identificado')}
        tagList(
            tags$u(class = "list-group",
            lapply(1:nrow(dadoi), \(x){
                dadoii <- dadoi[x,]
                suppressWarnings(func_barras(func_troca(dadoii[,1]), paste0(dadoii$perc,'%'), mround(dadoii$perc,5)))
            })
            )
        )
    })
    })
 }
