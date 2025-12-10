# TODO

Improvement proposals for PkCountries library.

## High Priority

### Safer `get/1` function
Currently `get/1` crashes with `MatchError` if country code not found:
```elixir
def get(country_code) do
  [country] = filter_by(:alpha2, country_code)  # crashes if not found
  country
end
```
**Proposal:** Return `nil` for not found, add `get!/1` for the raising variant.

### Efficient `exists?/2`
Current implementation iterates entire list even after finding a match:
```elixir
def exists?(attribute, value) do
  filter_by(attribute, value) |> length > 0
end
```
**Proposal:** Use `Enum.any?/2` for early termination.

### O(1) lookups with compile-time maps
Currently all lookups are O(n) - filtering through 250 countries.
**Proposal:** Build lookup maps at compile time:
```elixir
@countries_by_alpha2 Map.new(@countries, &{&1.alpha2, &1})
@countries_by_alpha3 Map.new(@countries, &{&1.alpha3, &1})
```

## Medium Priority

### Add `get_by/2` function
Get single country by any attribute, returning `nil` if not found:
```elixir
PkCountries.get_by(:name, "Poland")
# %PkCountries.Country{...}
```

### Simplify `equals_or_contains_in_list/2`
Replace recursive implementation with `Enum.any?/2`:
```elixir
defp equals_or_contains_in_list(list, value) when is_list(list) do
  Enum.any?(list, &(normalize(&1) == normalize(value)))
end
```

### Cache subdivisions
Subdivisions are read from disk on every `Subdivisions.all/1` call. Options:
- Load at compile time (increases binary size)
- Add ETS-based caching
- Use `persistent_term` for caching

### Clean up `Application.start(:yamerl)`
Currently called in multiple module bodies. Should only be in `Loader` module.

## Low Priority / Nice to Have

### Add `count/0` helper
```elixir
PkCountries.count()
# 250
```

### Add `get_subdivision/2`
Get specific subdivision by country and ID:
```elixir
PkCountries.Subdivisions.get("US", "US-CA")
# %PkCountries.Subdivision{id: "US-CA", name: "California", ...}
```

### Add typespec annotations
Add `@spec` for all public functions to enable Dialyzer and improve docs:
```elixir
@spec get(String.t()) :: Country.t() | nil
@spec filter_by(atom(), term()) :: [Country.t()]
```

### Add `eu_members/0` convenience function
```elixir
PkCountries.eu_members()
# [%PkCountries.Country{alpha2: "AT", ...}, ...]
```

### Support filtering by multiple attributes
```elixir
PkCountries.filter_by(region: "Europe", eu_member: true)
```
