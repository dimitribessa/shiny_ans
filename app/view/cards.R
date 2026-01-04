#' app/view
#'
box::use(shiny[tags, moduleServer, NS, tagList,
  uiOutput, renderUI],)

#' @export
card <- function(icon = "ni ni-circle-08", tag) {
  
  icon <- paste(icon, "text-dark text-gradient text-lg opacity-10")  
  tagList(
    tags$div(
      class = "card",
      tags$span(class = "mask bg-primary opacity-10 border-radius-lg"),
      tags$div(
        class = "card-body p-3 position-relative",
        tags$div(
          class = "row",
          tags$div(
            class = "col-10 text-start",
            tags$div(
              class = "icon icon-shape bg-white shadow text-center border-radius-2xl",
              tags$i(class = icon)
            ),
           tag
             )
        )
      )
    )
  ) # end taglist
}

#' @export
 func_format <- function(x,y){
    tagList(
      tags$h4(class = "text-white font-weight-bolder mb-0 mt-3", x),
      tags$span( class="text-white text-sm", y)
    )
 }

 
 #' @export
 card_i <- function(..., header = NULL){
      tagList(
        tags$div(class = 'card shadow h-100',
          tags$div(class = 'card-header pb-0',
          tags$h6(header))
          ,
          tags$div(class = 'card-body p-3',
          ...))
      )
 }

 