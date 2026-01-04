 #' app/view
 #' 
 #' 
 box::use(
    shiny[tags, HTML, tagList]
 )

 #' @export
  main_page <- function(...){
   tags$body(class="g-sidenav-show bg-gray-100",
   ...
   ,
   HTML('<script src="app/static/assets/js/core/popper.min.js"></script>
  <script src="app/static/assets/js/core/bootstrap.min.js"></script>
  <script src="app/static/assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="app/static/assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>'
  )
  )}

 #' @export
  navbar <- function(title = 'Título', ...){
      tagList(
         tags$nav(class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl", id="navbarBlur", `navbar-scroll`="true",
            tags$div( class="container-fluid py-1 px-3",
               tags$nav(`aria-label`="breadcrumb",
                  tags$h3(class="font-weight-bolder mb-0", title)
               ),
               tags$div(class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4 justify-content-end" ,id="navbar",
                  ... 
               )   
            )
         )
      )
  }
