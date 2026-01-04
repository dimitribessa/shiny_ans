

 #' explorando dados do Sistema de Informaçoes de Beneficiários (01-set-2, 11:10h)
 #' dados de beneficiários obtidos em https://dadosabertos.ans.gov.br/FTP/PDA/dados_de_beneficiarios_por_operadora/
 #' 

# .libPaths('D:\\Dimitri\\Docs 17-out-15\\R\\win-library\\3.1') #caminho dos pacotes
 
 library('dplyr')
 library('magrittr')
 library('lubridate')

#' utilizando os dados do dbc por operadora (05-set-2025, 17:07hh)
  meses <- seq(as.Date('2011-06-01'), as.Date('2025-09-01'), by = '3 months')

  dado_beneficiarios_operadora <- purrr::map_df(meses, function(x){
   mes <- substr(x, 1,7)
   link <- paste0('https://dadosabertos.ans.gov.br/FTP/Base_de_dados/Microdados/dados_dbc/beneficiarios/operadoras/tb_cc_',mes,'.dbc')
   download.file(link, destfile = file.path(getwd(),'beneficiarios/por_operadoras/arquivo.dbc'), mode = 'wb')
   dadoi <- read.dbc::read.dbc(file.path(getwd(),'beneficiarios/por_operadoras/arquivo.dbc'))
   dadoi <- subset(dadoi, SG_UF == 'SC')
   names(dadoi) <- tolower(names(dadoi))
   dadoi[,c('nr_benef_o', 'nr_benef_m', 'nr_benef_t')] <- 
        sapply(dadoi[,c('nr_benef_o', 'nr_benef_m', 'nr_benef_t')], function(x){as.numeric(as.character(x))})
   dadoi[,c('id_cmpt','cd_operado','modalidade','porte','cd_contr','nr_benef_o','nr_benef_m','nr_benef_t','ops_atv', 'ops_ben')]
  }) 

  # save(dado_beneficiarios_operadora, file = 'beneficiarios/por_operadoras/dado_beneficiarios_operadora.RData')
   save(dado_beneficiarios_operadora, file = 'G:/Meu Drive/Documentos/Curso R/Shiny/rhino/tutorial/soft_ui/app/data/dado_beneficiarios_operadora.RData')
 