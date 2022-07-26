defmodule DesafioStoneTest do
  use ExUnit.Case

  describe "receive_list/2" do
    test "when all params are valid, returns a successfull response" do
      params_list = [
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

      params_emails = ["teste@teste.com", "stone@teste.com", "teste@stone.com", "stone@stone.com"]

      response = DesafioStone.receive_list(params_list, params_emails)

      assert {:ok,
              [
                %{email: "teste@teste.com", value: 25},
                %{email: "stone@teste.com", value: 25},
                %{email: "teste@stone.com", value: 25},
                %{email: "stone@stone.com", value: 25}
              ]} = response
    end

    test "when there are invalid params, returns an error" do
      params_list = []
      params_emails = []

      response = DesafioStone.receive_list(params_list, params_emails)

      expected_response = {:error, "lista de itens e emails está vazia"}

      assert expected_response == response
    end

    test "when there are an invalid list, returns an error" do
      params_list = []
      params_emails = ["teste@teste.com", "stone@teste.com", "teste@stone.com", "stone@stone.com"]

      response = DesafioStone.receive_list(params_list, params_emails)

      expected_response = {:error, "lista de itens está vazia"}

      assert expected_response == response
    end

    test "when there are an invalid email, returns an error" do
      params_list = [
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

      params_emails = []

      response = DesafioStone.receive_list(params_list, params_emails)

      expected_response = {:error, "lista de emails está vazia"}

      assert expected_response == response
    end
  end
end
