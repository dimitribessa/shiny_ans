 #' /app/logic
 #' 
 
 #' @export
 func_load <- function(){
       caminho <- getwd()
       load(file.path(caminho, 'app/data/dado_beneficiarios_operadora.RData') )
            return(dado_ben)}
 

 #' @export
 operadoras <- function(){
       caminho <- getwd()
       load(file.path(caminho, 'app/data/operadoras.RData') )
            return(operadoras)}