defmodule DesafioStone.SumList do
  def sum_list(list) do
    Enum.reduce(list, 0, fn item, acc ->
      if item.amount >= 0 and item.price >= 0,
        do: item.amount * item.price + acc,
        else: IO.puts("valores de amount e price devem ser maiores do que 0")
    end)
  end
end
