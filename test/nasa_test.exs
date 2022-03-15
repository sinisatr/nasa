defmodule NasaTest do
  use ExUnit.Case
  doctest Nasa

  describe "flight_route/2" do
    test "To the Moon and back" do
      path = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
      expected_result = 51_898
      result = Nasa.flight_route(28_801, path)
      assert expected_result == result
    end

    test "Mission on Mars" do
      path = [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      expected_result = 33_388
      result = Nasa.flight_route(14_606, path)
      assert expected_result == result
    end

    test "Passenger ship" do
      path = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      expected_result = 212_161
      result = Nasa.flight_route(75_432, path)
      assert expected_result == result
    end

    test "Wrong arguments when mass is not integer" do
      path = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      expected_result = {:error, "Wrong arguments"}
      result = Nasa.flight_route("not number", path)
      assert expected_result == result
    end

    test "Wrong arguments when action is not land/launch" do
      path = [{:wrong, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      expected_result = {:error, "Wrong arguments"}
      result = Nasa.flight_route(75_432, path)
      assert expected_result == result
    end

    test "Wrong arguments when 2 times launching" do
      path = [{:launch, 9.807}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      expected_result = {:error, "Wrong arguments"}
      result = Nasa.flight_route(75_432, path)
      assert expected_result == result
    end
  end
end
