# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test Commands

```bash
mix deps.get          # Install dependencies
mix compile           # Compile the project
mix test              # Run all tests
mix test test/countries_test.exs:12  # Run specific test by line number
mix credo --strict    # Run static analysis
mix format            # Format code
mix docs              # Generate documentation
```

## Architecture

BeamLabCountries is a compile-time data library providing ISO 3166 country information. All country data is loaded from YAML files at compile time and embedded into the module as a module attribute.

### Key Design Pattern

**Compile-time data loading**: The `BeamLabCountries` module uses `@countries BeamLabCountries.Loader.load()` to parse all YAML data during compilation. This means:
- Changes to YAML files require recompilation (`mix compile --force`)
- No runtime file I/O for country lookups
- Uses `yaml_elixir` library for YAML parsing

### Module Structure

- `BeamLabCountries` (lib/countries.ex) - Main API: `all/0`, `count/0`, `get/1`, `get!/1`, `get_by/2`, `get_by_alpha3/1`, `filter_by/2`, `exists?/2`
- `BeamLabCountries.Country` - Struct with 30+ fields (alpha2, alpha3, name, region, currency, etc.)
- `BeamLabCountries.Subdivisions` - Runtime loader for country subdivisions (states/provinces)
- `BeamLabCountries.Subdivision` - Struct for subdivision data
- `BeamLabCountries.Loader` - Compile-time YAML parser using yaml_elixir

### Data Location

- `priv/data/countries.yaml` - List of country codes to load
- `priv/data/countries/{CODE}.yaml` - Individual country data files (250 countries)
- `priv/data/subdivisions/{CODE}.yaml` - Subdivision data (loaded at runtime, not compile-time)
