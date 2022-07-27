## Stone - Case Técnico Elixir

# Banco de dados

A query de banco de dados se encontram no arquivo SQL.md do projeto.

# Programação

O módulo principal deste case se encontra dentro de lib/desafio_stone.ex. Dentro deste módulo só haverá 1 função acessível chamada receive_list, esta função recebe 2 parâmetros, o primeiro é uma lista de compras e o segundo é uma lista de emails. Ao executar a função com os parâmetros corretos, é retornado uma lista com os mapas contendo email e valor a ser pago.

## Rodando o projeto

Para rodar o projeto, é preciso executar o comando em seu terminal:

```elixir
elixir lib/desafio_stone.ex
```

obs: dentro do arquivo desafio_stone.ex já existe um mock com as listas para testes

Para executar os testes, é preciso executar o comando em seu terminal:

```elixir
mix test
```

obs: Os testes se encontram na pasta test/desafio_stone_test.exs
