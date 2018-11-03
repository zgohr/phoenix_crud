defmodule PhoenixCrud.EcommerceTest do
  use PhoenixCrud.DataCase

  alias PhoenixCrud.Ecommerce

  describe "addresses" do
    alias PhoenixCrud.Ecommerce.Address

    @valid_attrs %{address: "some address", city: "some city", name: "some name", state: "some state"}
    @update_attrs %{address: "some updated address", city: "some updated city", name: "some updated name", state: "some updated state"}
    @invalid_attrs %{address: nil, city: nil, name: nil, state: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ecommerce.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Ecommerce.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Ecommerce.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Ecommerce.create_address(@valid_attrs)
      assert address.address == "some address"
      assert address.city == "some city"
      assert address.name == "some name"
      assert address.state == "some state"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ecommerce.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Ecommerce.update_address(address, @update_attrs)

      
      assert address.address == "some updated address"
      assert address.city == "some updated city"
      assert address.name == "some updated name"
      assert address.state == "some updated state"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Ecommerce.update_address(address, @invalid_attrs)
      assert address == Ecommerce.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Ecommerce.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Ecommerce.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Ecommerce.change_address(address)
    end
  end
end
