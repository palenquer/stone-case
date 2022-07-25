defmodule DesafioStone.SumList do
  def sum_list(list) do
    list
    |> Enum.map(fn item ->
      if item.amount >= 0 and item.price >= 0,
        do: item.amount * item.price,
        else: IO.puts("valores de amount e price devem ser maiores do que 0")
    end)
    |> Enum.sum()
  end
end
