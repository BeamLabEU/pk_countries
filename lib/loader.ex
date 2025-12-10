defmodule PkCountries.Loader do
  @moduledoc false

  alias PkCountries.Country

  @doc """
  Loads all country data from YAML files at compile time.
  """
  def load do
    data_path("countries.yaml")
    |> YamlElixir.read_from_file!()
    |> Enum.map(fn code ->
      data_path("countries/#{code}.yaml")
      |> YamlElixir.read_from_file!()
      |> Map.fetch!(code)
      |> convert_country()
    end)
  end

  defp data_path(path) do
    Path.join([:code.priv_dir(:pk_countries), "data", path])
  end

  defp convert_country(data) do
    %Country{
      number: data["number"],
      alpha2: data["alpha2"],
      alpha3: data["alpha3"],
      currency: data["currency"],
      name: data["name"],
      unofficial_names: data["unofficial_names"],
      continent: data["continent"],
      region: data["region"],
      subregion: data["subregion"],
      geo: atomize_keys(data["geo"]),
      world_region: data["world_region"],
      country_code: data["country_code"],
      national_destination_code_lengths: data["national_destination_code_lengths"],
      national_number_lengths: data["national_number_lengths"],
      international_prefix: data["international_prefix"],
      national_prefix: data["national_prefix"],
      ioc: data["ioc"],
      gec: data["gec"],
      un_locode: data["un_locode"],
      languages_official: data["languages_official"],
      languages_spoken: data["languages_spoken"],
      nationality: data["nationality"],
      address_format: data["address_format"],
      dissolved_on: data["dissolved_on"],
      eu_member: data["eu_member"],
      alt_currency: data["alt_currency"],
      vat_rates: atomize_keys(data["vat_rates"]),
      postal_code: data["postal_code"],
      currency_code: data["currency_code"],
      start_of_week: data["start_of_week"]
    }
  end

  defp atomize_keys(nil), do: nil

  defp atomize_keys(map) when is_map(map) do
    Map.new(map, fn {k, v} -> {String.to_atom(k), atomize_keys(v)} end)
  end

  defp atomize_keys(value), do: value
end
