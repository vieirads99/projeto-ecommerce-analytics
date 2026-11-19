-- =====================================================================
-- Consultas de validação (BigQuery)
-- Conferem se os KPIs e gráficos do dashboard batem com a tabela `vendas`.
-- Projeto: ecommerce-analytics-514821 | Dataset: ecommerce_analytics
-- =====================================================================

-- ---------------------------- KPIs ----------------------------------

-- KPI: Receita (faturamento total)
SELECT
  ROUND(SUM(faturamento), 2) AS faturamento_total
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`;

-- KPI: Total de pedidos
SELECT
  COUNT(*) AS total_pedidos
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`;

-- KPI: Ticket médio
SELECT
  ROUND(SUM(faturamento) / COUNT(*), 2) AS ticket_medio
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`;

-- KPI: Clientes únicos
SELECT
  COUNT(DISTINCT id_cliente) AS clientes_unicos
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`;

-- KPI: Receita por cliente
SELECT
  ROUND(SUM(faturamento) / COUNT(DISTINCT id_cliente), 2) AS receita_cliente
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`;

-- --------------------------- Análises -------------------------------

-- Análise 01: ranking de produtos por quantidade vendida
SELECT
  nome_produto,
  SUM(quantidade) AS quantidade
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY nome_produto
ORDER BY quantidade DESC;

-- Análise 02: ranking de quantidade vendida por categoria
SELECT
  categoria,
  SUM(quantidade) AS quantidade
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY categoria
ORDER BY quantidade DESC;

-- Análise 03: ranking de faturamento por categoria (gráfico "Faturamento por categoria")
SELECT
  categoria,
  ROUND(SUM(faturamento), 2) AS faturamento
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY categoria
ORDER BY faturamento DESC;

-- Análise 04: faturamento por categoria e produto (gráfico "Faturamento por produto")
SELECT
  categoria,
  nome_produto,
  ROUND(SUM(faturamento), 2) AS faturamento
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY categoria, nome_produto
ORDER BY categoria, faturamento DESC;

-- Análise 05: faturamento mensal (gráfico "Evolução do faturamento mensal")
SELECT
  EXTRACT(YEAR FROM data_pedido)  AS ano,
  EXTRACT(MONTH FROM data_pedido) AS mes,
  ROUND(SUM(faturamento), 2)      AS faturamento
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY ano, mes
ORDER BY ano, mes;

-- Análise 06: faturamento e quantidade por estado (gráfico "Faturamento por estado")
SELECT
  estado,
  ROUND(SUM(faturamento), 2) AS faturamento,
  SUM(quantidade)            AS quantidade
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY estado
ORDER BY faturamento DESC;

-- Análise 07: faturamento e quantidade por categoria
SELECT
  categoria,
  ROUND(SUM(faturamento), 2) AS faturamento,
  SUM(quantidade)            AS quantidade
FROM `ecommerce-analytics-514821.ecommerce_analytics.vendas`
GROUP BY categoria
ORDER BY faturamento DESC;
