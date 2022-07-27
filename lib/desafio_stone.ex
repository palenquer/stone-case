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
    div_total = Enum.map(emails, fn _ -> %{value: div(value, emails_length)} end)
    check_rem = rem(value, emails_length)

    if check_rem > 0 do
      sum_rem(div_total, 0, check_rem)
    else
      div_total
    end
  end

  defp sum_rem(list, _, 0) do
    list
  end

  defp sum_rem([head | tail], index, value) do
    new_head = %{value: head.value + 1}

    [new_head | sum_rem(tail, index + 1, value - 1)]
  end

  defp total(values, emails) do
    Enum.zip(values, Enum.map(emails, fn email -> %{email: email} end))
  end
end

mock_itens = [
  %{
    item: "Banana",
    amount: 1,
    price: 33
  },
  %{
    item: "Laranja",
    amount: 1,
    price: 33
  },
  %{
    item: "Laranja",
    amount: 1,
    price: 35
  }
]

mock_emails = ["teste@teste.com", "stone@teste.com", "teste@stone.com"]

handle_list = DesafioStone.receive_list(mock_itens, mock_emails)

IO.inspect(handle_list)
