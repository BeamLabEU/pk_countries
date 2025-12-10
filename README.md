# BeamLabCountries

BeamLabCountries is a collection of all sorts of useful information for every country in the [ISO 3166](https://en.wikipedia.org/wiki/ISO_3166) standard.

It is based on the data from the pretty popular but abandoned Elixir library [Countries](https://hex.pm/packages/countries) and previously the Ruby Gem [Countries](https://github.com/hexorx/countries).

## Installation

```elixir
defp deps do
  [
    {:beamlab_countries, "~> 1.0"}
  ]
end
```

After you are done, run `mix deps.get` in your shell to fetch and compile beamlab_countries.

## Usage

Find country by attribute:

```elixir
country = BeamLabCountries.filter_by(:alpha2, "DE")
# [%BeamLabCountries.Country{alpha2: "DE", alpha3: "DEU", continent: "Europe",
#   country_code: "49", currency: "EUR", ...}]

countries = BeamLabCountries.filter_by(:region, "Europe")
Enum.count(countries)
# 51
```

Get all countries:

```elixir
countries = BeamLabCountries.all()
Enum.count(countries)
# 250
```

Get a single country by alpha2 code:

```elixir
country = BeamLabCountries.get("PL")
# %BeamLabCountries.Country{name: "Poland", alpha2: "PL", ...}
```

Check if a country exists:

```elixir
BeamLabCountries.exists?(:name, "Poland")
# true
```

Get subdivisions for a country:

```elixir
country = BeamLabCountries.get("BR")
subdivisions = BeamLabCountries.Subdivisions.all(country)
Enum.count(subdivisions)
# 27
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright and License

Copyright (c) 2025 Dmitri Don / BeamLab

Copyright (c) 2015-2025 Sebastian Szturo

This software is licensed under [the MIT license](./LICENSE.md).
