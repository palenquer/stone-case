defmodule DesafioStone.DivideValues do
  def divide_values(value, emails) do
    emails_length = length(emails)
    IO.puts(rem(value, emails_length))
    div(value, emails_length)
  end
end
