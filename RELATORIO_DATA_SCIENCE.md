# Relatório de Ciência de Dados: Vinheria Agnello

Este relatório consolida as 4 etapas do projeto de Ciência de Dados para prever e analisar o sucesso de vendas da Vinheria Agnello.

---

## 1. Definição da Base de Dados

Para entender os padrões de vendas, geramos uma base de dados contendo **2000 registros** simulados (`data/sales_dataset.csv`). As colunas foram definidas pensando nas variáveis comerciais e operacionais que impactam a decisão de compra:

1. **`sale_id`**: Identificador único da venda (ex: SALE-00001).
2. **`product_category`**: Categoria do vinho (Red Wine, White Wine, Rose Wine, Sparkling Wine).
3. **`price_usd`**: Preço do produto em dólares (numérico).
4. **`customer_age`**: Idade do cliente (numérico).
5. **`customer_loyalty_years`**: Anos de fidelidade do cliente com a Vinheria (numérico).
6. **`region`**: Região da venda (North, South, East, West).
7. **`sales_channel`**: Canal de venda (Online, Physical Store).
8. **`season`**: Estação do ano em que a venda ocorreu (Winter, Summer, Spring, Autumn).
9. **`discount_applied`**: Indica se houve aplicação de desconto (1 = Sim, 0 = Não).
10. **`sale_success` (Rótulo/Target)**: Indica se a venda foi concluída com sucesso (1 = Sucesso, 0 = Falha).

**Racional:** A combinação de perfil demográfico (idade, fidelidade), atributos do produto (categoria, preço) e contexto (estação, canal, desconto) fornece um cenário completo para o algoritmo identificar padrões (ex: vinhos tintos vendem melhor no inverno; descontos aumentam as chances de sucesso).

---

## 2. Modelagem de Aprendizado Supervisionado

O objetivo foi prever a coluna `sale_success` com base nos demais atributos.

*   **Algoritmo Escolhido:** **Árvore de Decisão (Decision Tree Classifier)**. Escolhemos este modelo porque ele é altamente interpretável. Em um contexto de negócios como a Vinheria, é crucial entender *por que* o modelo tomou a decisão, e a árvore permite visualizar as regras geradas. Limitamos a profundidade da árvore (max_depth=5) para evitar overfitting.
*   **Atributos de Entrada (Features):** Utilizamos todas as colunas numéricas e transformamos as categóricas (como `product_category` e `season`) usando *One-Hot Encoding*. O `sale_id` foi descartado por ser apenas um identificador.
*   **Separação Treino/Teste:** Utilizamos a técnica de Holdout, separando os dados em **70% para treinamento** (1400 registros) e **30% para teste** (600 registros). O modelo aprende os padrões nos dados de treino e é avaliado em dados inéditos (teste).
*   **Métricas de Avaliação Obtidas:**
    *   **Acurácia:** ~65.8% (O modelo acertou quase 66% de todas as previsões).
    *   **Precisão:** ~71.0% (Quando o modelo previu que uma venda seria um "Sucesso", ele acertou em 71% das vezes).
    *   **Matriz de Confusão:** Mostrou que o modelo tem uma facilidade maior em identificar os sucessos (True Positives = 306) do que as falhas (True Negatives = 89).

---

## 3. Criação de Dashboard no Tableau (Guia de Implementação)

Como o sistema operacional é macOS, o **Tableau Public** (versão gratuita na web) é a alternativa mais simples e direta. Siga este roteiro para criar o dashboard com os dados gerados:

**Passo 1: Importar os dados**
1. Acesse o [Tableau Public Web](https://public.tableau.com/) e crie/acesse sua conta.
2. Clique em **"Criar Visualização" (Create a Viz)**.
3. Faça o upload do arquivo `data/sales_dataset.csv` gerado na raiz deste projeto.

**Passo 2: Criar as Visualizações (Planilhas)**
Crie 3 planilhas separadas (Worksheets) clicando no ícone de "Nova Planilha" na parte inferior:

*   **Visualização 1: Taxa de Sucesso por Categoria (Gráfico de Barras)**
    *   Arraste `product_category` para **Colunas**.
    *   Arraste `sale_success` para **Linhas** (Altere a medida de "Soma" para "Média" clicando na pílula para ver a taxa de sucesso percentual).
*   **Visualização 2: Impacto do Desconto nas Vendas (Gráfico de Pizza ou Barras Empilhadas)**
    *   **Atenção:** Como `discount_applied` tem valores numéricos (0 e 1), o Tableau pode interpretá-lo como "Medida" (cor verde). No painel esquerdo (Dados), clique com o botão direito em `discount_applied` e escolha **"Converter em Dimensão" (Convert to Dimension)** para que ele fique azul.
    *   Mude o tipo de gráfico no cartão de Marcas para **Pizza (Pie)**.
    *   Arraste `discount_applied` (agora como dimensão/azul) para **Cor** no cartão de Marcas.
    *   Arraste `Contagem de sales_dataset` (ou contagem de linhas) para **Ângulo** no cartão de Marcas.
*   **Visualização 3: Sucesso por Estação do Ano (Gráfico de Linha ou Barras)**
    *   Arraste `season` para **Colunas**.
    *   Arraste `sale_success` (como Média) para **Linhas**.

**Passo 3: Criar o Dashboard e Filtros**
1. Clique no ícone **"Novo Painel" (New Dashboard)**.
2. Arraste as 3 planilhas que você acabou de criar para a tela central.
3. Para adicionar os filtros: Clique no menu de opções de uma das visualizações inseridas -> **Filtros** -> Selecione `season` (Período), `product_category` (Produto) e `region` (Região).
4. No menu dos filtros que aparecerão à direita, clique na setinha de opções e selecione **"Aplicar a Planilhas" -> "Todas usando esta fonte de dados"**. Agora os filtros interagem com o painel todo!

---

## 4. Reflexão Final

### Quais insights foram descobertos a partir dos dados?
Com base na importância das *features* (Feature Importances) calculadas pelo modelo, descobrimos que:
1.  **O Desconto é o Rei:** A aplicação de desconto (`discount_applied`) teve a maior importância na decisão da árvore (~33%).
2.  **Sensibilidade a Preço:** O preço do vinho (`price_usd`) é o segundo fator mais decisivo (~19%), indicando que existe um limiar claro onde a conversão cai drasticamente.
3.  **Fidelização Vale a Pena:** O tempo de fidelidade do cliente (`customer_loyalty_years`) representa ~16% da importância, mostrando que clientes antigos têm uma propensão muito maior a fechar negócio independentemente de outros fatores.

### Como a Vinheria poderia usar essa análise para tomar decisões estratégicas?
A Vinheria Agnello pode atuar de forma mais preditiva:
*   **Campanhas Direcionadas:** Sabendo que clientes com mais de 5 anos de fidelidade convertem melhor, a empresa pode reduzir os descontos genéricos para esse grupo e concentrar a verba de descontos para a atração de novos clientes ou clientes de primeira viagem online.
*   **Gestão de Estoque:** Como vinhos tintos perforam melhor no inverno e espumantes no verão/primavera, o setor de compras pode prever as demandas sazonais com base nessas probabilidades.

### O modelo de classificação teve bom desempenho? Quais melhorias poderiam ser feitas?
O modelo teve um desempenho razoável, com **66% de Acurácia** e **71% de Precisão**. Em um contexto de vendas do mundo real (onde o comportamento humano é imprevisível), bater a casa dos 70% de precisão inicial é um bom ponto de partida, mas há espaço para melhorias significativas:
*   **Melhoria de Dados:** O modelo sofreu com um pouco de *Underfitting* (não capturou toda a complexidade). Poderíamos adicionar mais variáveis ricas, como "Avaliação do Produto", "Custo do Frete" ou "Tempo de Navegação no Site".
*   **Otimização do Modelo (Tuning):** Podemos testar algoritmos mais complexos como **Random Forest** ou **XGBoost**, além de otimizar os hiperparâmetros da árvore usando *Grid Search* ao invés de fixar arbitrariamente a profundidade máxima em 5.
*   **Tratamento de Desbalanceamento:** Se o dataset real tiver muito mais sucessos do que falhas (ou vice-versa), seria ideal aplicar técnicas como SMOTE para balancear a base de treino.
