# pacotes utilizados
library(glue)
require(yaml)
require(jsonlite)
require(nnet)
require(usethis)


# lendo configuracoes
config <- read_yaml('configuracao.yaml')  # lendo configuracoes

# verificações
if (!(config$reutilizar_modelo %in% c('sim', 'nao', 'não'))) {
  stop('Especificacoes incorretas em reutilizar_modelo.')
}

# executando
if (config$reutilizar_modelo %in% c('não', 'nao')) source('treinamento.R')
source('predicao.R')
source('grafico.R')



