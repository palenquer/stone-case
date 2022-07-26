defmodule DesafioStone do
  @moduledoc "Desafio Stone"
  @doc "Recebe uma lista de compras e uma lista de emails e depois divide o valor total entre os emails."

  def receive_list([], []), do: {:error, "lista de itens e emails está vazia"}
  def receive_list([], _), do: {:error, "lista de itens está vazia"}
  def receive_list(_, []), do: {:error, "lista de emails está vazia"}

  def receive_list(list, emails) do
    check_emails = has_duplicates?(emails)

    if check_emails do
      {:error, "não pode conter e-mails duplicados"}
    else
      list
      |> sum_list()
      |> divide_values(emails)
      |> total(emails)
    end
  end

  defp has_duplicates?(list) do
    list
    |> Enum.reduce_while(%MapSet{}, fn x, acc ->
      if MapSet.member?(acc, x), do: {:halt, false}, else: {:cont, MapSet.put(acc, x)}
    end)
    |> is_boolean()
  end

  defp sum_list(list) do
    Enum.reduce(list, 0, fn item, acc ->
      if item.amount > 0 and item.price > 0,
        do: item.amount * item.price + acc,
        else: {:error, "valores de amount e price devem ser maiores do que 0"}
    end)
  end

  defp divide_values(value, emails) do
    emails_length = length(emails)
    IO.puts(rem(value, emails_length))
    div(value, emails_length)
  end

  defp total(value, emails),
    do: {:ok, Enum.map(emails, fn email -> %{email: email, value: value} end)}
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

mock_emails = ["teste@teste.com", "stone@teste.com", "teste@stone.com", "stone@stone.com"]

handle_list = DesafioStone.receive_list(mock_itens, mock_emails)

IO.inspect(handle_list)
