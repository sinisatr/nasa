# Nasa
The goal of this application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on the flight route.

Formula to calculate fuel is quite simple, but it depends on the planet's gravity. Planets NASA is interested in are:

Earth - 9.807 m/s2
Moon - 1.62 m/s2
Mars - 3.711 m/s2

The formula for fuel calculations for the launch is the following:

mass * gravity * 0.042 - 33 rounded down

The formula for fuel calculations for the landing is the following:

mass * gravity * 0.033 - 42 rounded down

For example, for the Apollo 11 Command and Service Module, with a weight of 28801 kg, to land it on the Earth, the required amount of fuel will be:

28801 * 9.807 * 0.033 - 42 = 9278

But fuel adds weight to the ship, so it requires additional fuel, until additional fuel is 0 or negative. Additional fuel is calculated using the same formula from above.

9278 fuel requires 2960 more fuel
2960 fuel requires 915 more fuel
915 fuel requires 254 more fuel
254 fuel requires 40 more fuel
40 fuel requires no more fuel

So, to land Apollo 11 CSM on the Earth - 13447 fuel required (9278 + 2960 + 915 + 254 + 40).

Application should receive a flight route as 2 arguments. First one is the flight ship mass, and second is an array of 2 element tuples, with the first element being land or launch directive, and second element is the target planet gravity.

But take into account that to land a module on the Moon, you need additional fuel, which should be launched from the Earth - we don’t have a refuel station in space - and we need to to carry fuel for all steps from the very beginning.

## Be sure to have

Erlang/OTP 24 - erts-12.2.1
Elixir - 1.13.3

## Running from CLI

Go to file destination and run:
```
# download needed dependencies
mix deps.get

# start interactive shell
iex -S mix

# run command

Nasa.flight_route(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])

# enjoy the view

```
