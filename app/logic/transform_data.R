 #' app/view/transform_data
 #' 
 box::use(
    reshape2,
    stats[aggregate],
 )

 #' @export
 func_sankeydata <- function(x){

func_troca <- \(x){switch(x, 'Individual/familiar', 'Coletivo empresarial', 'Coletivo por adesão',
              'Coletivo não identificado')}

func_trocai <- \(x){switch(x,'1 a 10.000 beneficiários', '1 a 10.000 beneficiários',
         '1 a 10.000 beneficiários',
         '1 a 10.000 beneficiários', '1 a 10.000 beneficiários',
            '10.001 a 20.000 beneficiários', '20.001 a 50.000 beneficiários',
            '50.001 a 100.000 bneficiários', '100.001 a 500.000 beneficiários',
            '> 500.000 beneficiários')}


 dadoi <- x

 dadoii <- aggregate(cbind(nr_benef_o, nr_benef_m)~porte + cd_contr, data = dadoi, FUN = sum, na.rm = T)
 dadoii <- reshape2$melt(dadoii, id.vars = c('porte', 'cd_contr'), na.rm = T)
 dadoii <- dadoii[which(dadoii$value > 0),]
 dadoii <- dadoii[which(dadoii$cd_contr > 0),]
 dadoii$porte <- sapply(dadoii$porte, func_trocai, simplify = T)
 dadoii$cd_contr <- sapply(dadoii$cd_contr, func_troca, simplify = T)
 dadoii$variable = factor(dadoii$variable, labels = c('Plano Odontológico', 'Plano A. Médica'))
# nodes <- with(dadoii, unique(c(porte, cd_contr, variable)))

 dadoiii <- aggregate(value ~ variable + porte , FUN = sum, na.rm = T, data = dadoii)
 names(dadoiii) <- c('source', 'target', 'value')
 dadoiiv <- aggregate(value ~ porte + cd_contr, FUN = sum, na.rm = T, data = dadoii)
 names(dadoiiv) <- c('source', 'target', 'value')
 
 dadoii <- as.data.frame(rbind(dadoiii, dadoiiv))
 dadoii$source <- as.character((dadoii$source))
 
 nodes <- with(dadoii, unique(c(target,source)))
 nodes <- lapply(nodes, \(x){list(name = x)})
 #links <- lapply(split(dadoii, seq(nrow(dadoii))),\(x){list(x[1,])}) |> unname() #source = x[1,1], target = x[1,2], value = x[1,3])}) |> unname()
 links <- lapply(seq(nrow(dadoii)), function(x){c(dadoii[x,])})

 list(nodes,links)
}