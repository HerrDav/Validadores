# Validadores
Validadores em Microsoft SQL Server


## Validador de CPF

**Como usar**
```sql
  --0 = false
  --1 = true

  --Atribuindo em Tabela
  SELECT dbo.ValidaCPF('NOME_CAMPO_CPF') as Validado FROM NOME_TABELA
  --Atribuição na Select
  SELECT dbo.ValidaCPF('11111111111') as Validado

```
**Utilizado como base:** [Macoratti](https://www.macoratti.net/alg_cpf.htm#:~:text=O%20algoritmo%20de%20valida%C3%A7%C3%A3o%20do,%3A%20111.444.777%2D05.)
