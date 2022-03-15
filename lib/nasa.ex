defmodule Nasa do
  @moduledoc """
  This module counts mass needed for ship with equipment and path mission
  """

  @actions [:land, :launch]

  @doc """
  Get fuel needed for given ship mass and path

  ## Examples

      iex> Nasa.flight_route(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      51898

  """
  @spec flight_route(integer, list) :: integer | {:error, String.t()}
  def flight_route(mass, path) when is_integer(mass) do
    if is_valid_path(path) do
      {_ship_mass_with_fuel, fuel} =
        path
        |> Enum.reverse()
        |> Enum.reduce(
          {mass, 0},
          fn {action, planet}, {ship_mass, fuel_mass} ->
            new_fuel_mass = calculate(action, ship_mass, planet, [])
            {ship_mass + new_fuel_mass, new_fuel_mass + fuel_mass}
          end
        )

      fuel
    else
      {:error, "Wrong arguments"}
    end
  end

  def flight_route(_mass, _route), do: {:error, "Wrong arguments"}

  defp is_valid_path([{action, planet} | t])
       when is_float(planet) and action in @actions,
       do: check_next_action({action, planet}, t)

  defp is_valid_path(_), do: false

  defp check_next_action({_old_action, _old_planet}, []), do: true

  defp check_next_action({old_action, old_planet}, [{action, planet} | t])
       when is_float(planet) and action in @actions and old_action != action do
    if old_action == :land and old_planet != planet do
      false
    else
      check_next_action({action, planet}, t)
    end
  end

  defp check_next_action(_, _), do: false

  defp calculate(action, mass, planet, []) do
    fuel_mass = get_fuel_mass(action, mass, planet)
    calculate(action, mass, planet, [fuel_mass])
  end

  defp calculate(action, mass, planet, [last_fuel_mass | _t] = fuel_mass) do
    new_fuel_mass = get_fuel_mass(action, last_fuel_mass, planet)

    if new_fuel_mass > 0 do
      calculate(action, mass, planet, [new_fuel_mass | fuel_mass])
    else
      Enum.sum(fuel_mass)
    end
  end

  defp get_fuel_mass(:launch, mass, planet) do
    a = (mass * planet * 0.042 - 33) |> trunc
    IO.puts "#{a}"
    a
  end

  defp get_fuel_mass(:land, mass, planet) do
    a = (mass * planet * 0.033 - 42) |> trunc
    IO.puts "#{a}"
    a
  end
end
