# Introdução


Este projeto foi desenvolvido para criar um pipeline automatizado que integra treinamento, predição e análise gráfica de modelos de regressão linear ou logística. O produto é altamente configurável, adaptando-se facilmente a diferentes conjuntos de dados e configurações, com base em um arquivo de configuração no formato YAML. 

A estrutura do projeto é composta pelos seguintes diretórios e arquivos:

- Projeto/
  - entradas/      # Arquivos de entrada (csv e json)
  - saidas/        # Arquivos de saída gerados (modelos, gráficos, etc.)
  - treinamento.R  # Script de treinamento do modelo
  - predicao.R     # Script de predição do modelo
  - grafico.R      # Script de análise gráfica
  - configuracao.yaml  # Arquivo de configuração
  - README.Rmd     # Arquivo de documentação
  - main.R         # Script principal que integra todas as partes
  
# Requisitos

Para executar o projeto corretamente, é necessário ter o seguinte ambiente configurado:

```r
install.packages(c("glue", "yaml", "jsonlite", "nnet", "usethis"))
```

Além disso, o usuário precisa fornecer:

- Um arquivo de configuração no formato YAML, denominado configuracao.yaml, que define os parâmetros para a execução do pipeline.
- Um conjunto de dados no formato CSV localizado na pasta entradas.
- Um arquivo JSON contendo os valores das variáveis preditoras, que será utilizado para gerar predições no script de predição, também localizado na pasta entradas.


# Arquivo de Configuração
O arquivo configuracao.yaml é utilizado para especificar os parâmetros de entrada do produto, como o nome do arquivo de dados, o tipo de modelo a ser ajustado, as variáveis preditoras e a variável resposta. A seguir, temos um exemplo típico de como esse arquivo deve ser estruturado:

```r
tabela: mtcars.csv  # Nome do arquivo de dados

# Tipo de modelo: (reg_linear | reg_logistica)
modelo: reg_logistica  # Modelo de regressão logística

# Reutilizar modelo existente ou treinar um novo? (sim | nao)
reutilizar_modelo: nao  # Treinar um novo modelo

# Modelo a ser utilizado para fazer a predição
escolhe_modelo: fit1  # Nome do modelo a ser reutilizado, se aplicável

# Pares de variáveis: variável resposta e preditoras
pares:
  - "y": am  # Variável resposta
    "x": [wt, cyl]  # Variáveis preditoras
```

- tabela: Nome do arquivo de dados no formato CSV que contém as observações a serem utilizadas no treinamento. O arquivo deve estar localizado na pasta entradas.

- modelo: Especifica o tipo de modelo a ser ajustado. As opções possíveis são:
    - reg_linear - Para ajustar um modelo de regressão linear.
    - reg_logistica - Para ajustar um modelo de regressão logística.

- reutilizar_modelo: Indica se um modelo previamente ajustado deve ser reutilizado ou se um novo modelo deve ser treinado. As opções são sim (reutiliza) ou nao (treina novamente).

- escolhe_modelo: Nome do arquivo de modelo salvo na pasta saidas a ser utilizado para predições. Apenas relevante se reutilizar_modelo for sim.
pares: Define a variável resposta (y) e as variáveis preditoras (x) para o ajuste do modelo.


# Execucao do Produto
O produto pode ser executado através do script main.R, que faz a integração das três partes principais: treinamento, predição e geração de gráficos. Para executar o produto, abra o RStudio e utilize o seguinte comando no console:
```r
source('main.R')
```

O script main.R realiza as seguintes etapas:

- Se reutilizar_modelo for nao, ele ajusta o modelo especificado no arquivo configuracao.yaml, utilizando o arquivo de dados fornecido, e salva o modelo ajustado na pasta saidas.

- Executa o script predicao.R, que gera predições com base no modelo ajustado e nas variáveis preditoras fornecidas no arquivo preditores.json.

- Executa o script grafico.R, que gera um gráfico comparando os valores observados e preditos e salva esse gráfico na pasta saidas.


# Resultados
Ao final da execução, os seguintes arquivos serão gerados na pasta saidas:

- O modelo ajustado salvo na pasta saidas, no formato .rds.
- Arquivo .json contendo as predições geradas pelo modelo.
- Um gráfico comparando os valores observados e preditos, salvo na pasta saidas em formato .pdf.
