db <- read.csv(glue('entradas/{config$tabela}'), stringsAsFactors = T)  # lendo banco de dados

if (is.null(config$escolhe_modelo)) {
  config$escolhe_modelo <- 'fit1'
}

fit <- readRDS(glue('saidas/{config$escolhe_modelo}.rds'))  # lendo modelo


if (config$modelo == 'reg_linear') {
  # Para regressão linear
  plot(x = fit$fitted.values, y = db[[config$pares[[1]]$y]], 
       xlab = 'Valores Preditos', ylab = 'Valores Observados', main = 'Gráfico de Regressão Linear')
  abline(v=predicao_val, lty = 8, col = rgb(0, 0, 0, alpha = 0.5))  # adiciona as linhas verticais
  
} else if (config$modelo == 'reg_logistica') {
  # Para regressão logística
  plot(x = fit$fitted.values, y = db[[config$pares[[1]]$y]], 
       xlab = 'Valores Preditos (Probabilidades)', ylab = 'Valores Observados', main = 'Gráfico de Regressão Logística')
  abline(v=predicao_val, lty = 8, col = rgb(0, 0, 0, alpha = 0.5))  # adiciona as linhas verticais
}


pdf('saidas/grafico_predicao.pdf', width = 7, height = 5)

message("Gráfico gerado e salvo na pasta 'saidas'.")