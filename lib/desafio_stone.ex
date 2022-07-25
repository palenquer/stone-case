defmodule DesafioStone do
  @moduledoc "Desafio Stone"
  @doc "Recebe uma lista de compras e uma lista de emails e depois divide o valor total entre os emails."

  import DesafioStone.SumList, only: [sum_list: 1]
  import DesafioStone.HasDuplicates, only: [has_duplicates?: 1]
  import DesafioStone.DivideValues, only: [divide_values: 2]

  def receive_list([], []) do
    IO.puts("lista de itens e emails está vazia")
  end

  def receive_list([], _) do
    IO.puts("lista de itens está vazia")
  end

  def receive_list(_, []) do
    IO.puts("lista de emails está vazia")
  end

  def receive_list(list, emails) do
    check_emails = has_duplicates?(emails)

    if check_emails do
      IO.puts("não pode conter e-mails duplicados")
    else
      list
      |> sum_list()
      |> divide_values(emails)
      |> total(emails)
    end
  end

  defp total(value, emails) do
    Enum.map(emails, fn email -> %{email: email, value: value} end)
  end
end

mock_itens = [
  %{
    item: "Banana",
    amount: 1,
    price: 52
  },
  %{
    item: "Laranja",
    amount: 1,
    price: 50
  }
]

mock_emails = ["teste@stone.com", "stone@teste.com", "teste@teste.com", "testando@testes.com"]

handle_list = DesafioStone.receive_list(mock_itens, mock_emails)

IO.inspect(handle_list)
