defmodule DesafioStone.HasDuplicates do
  def has_duplicates?(list) do
    list
    |> Enum.reduce_while(%MapSet{}, fn x, acc ->
      if MapSet.member?(acc, x), do: {:halt, false}, else: {:cont, MapSet.put(acc, x)}
    end)
    |> is_boolean()
  end
end
