#############
# DIRETORIO #
#############


setwd("D:\\2018\\001-Dados-Turismo")
getwd()

##############
# BIBLIOTECA #
##############

# install.packages("dplyr")
library(dplyr)

#########################
# DOWNLOAD DOS ARQUIVOS #
#########################

# Layout da base de dados #
base <- data.frame(continente = character(0),
                   cod_continente = numeric(0),
                   pais = character(0),
                   cod_pais = numeric(0),	
                   uf = character(0),	
                   cod_uf = numeric(0),	
                   Via = character(0),	
                   cod_via = numeric(0),	
                   ano = numeric(0),	
                   mes = character(0),	
                   cod_mes = numeric(0),
                   chegadas = numeric(0))

# Inicio da serie em 1989 #
ano <- c(1989:as.integer(c(format(Sys.Date(), "%Y"))))
ano


pb <- txtProgressBar(min = 0, max = length(ano), style = 3)
for (i in 1:length(ano)){
  i <- ano[i]
  if (inherits (res <- try(download.file(url = paste0("http://dados.turismo.gov.br/images/csv/chegadas/chegadas_",i,".csv"),
                                         destfile = paste0("chegadas",i,".csv"),
                                         method = "auto", mode = "wb"), silent = TRUE),  "try-error")){
    FALSE } 
  else { 
    res
    fname <- paste0('chegadas',i,".csv")
    data <- read.csv2(fname, header = TRUE)
    data <- data[,1:12]
    names(data) <- names(base)
    base <- rbind(base, data, deparse.level = 0)
  }
  setTxtProgressBar(pb, i)
}

# Removendo objetos temporarios #
rm(data,ano,fname,i,pb,res)

#######################
# BASE DE DADOS FINAL #
#######################

# Visao da base de dados #
table(base$ano)
View(base)

# Removendo linhas com NA #
base <- base[rowSums(is.na(base)) == 0,]

View(base)