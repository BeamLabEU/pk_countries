defmodule PkCountries.Languages do
  @moduledoc """
  Module for looking up language names from ISO 639-1 codes.

  ## Examples

      iex> PkCountries.Languages.get_name("en")
      "English"

      iex> PkCountries.Languages.get_name("pl")
      "Polish"

      iex> PkCountries.Languages.get_name("invalid")
      nil

  """

  @languages_path Path.join([:code.priv_dir(:pk_countries), "data", "languages.json"])
  @external_resource @languages_path

  @languages @languages_path
             |> File.read!()
             |> JSON.decode!()
             |> Map.new(fn {code, data} -> {code, data} end)

  @doc """
  Returns the English name for a language code.

  ## Examples

      iex> PkCountries.Languages.get_name("en")
      "English"

      iex> PkCountries.Languages.get_name("de")
      "German"

      iex> PkCountries.Languages.get_name("ja")
      "Japanese"

  """
  def get_name(code) when is_binary(code) do
    case Map.get(@languages, String.downcase(code)) do
      nil -> nil
      data -> data["name"]
    end
  end

  @doc """
  Returns the native name for a language code.

  ## Examples

      iex> PkCountries.Languages.get_native_name("en")
      "English"

      iex> PkCountries.Languages.get_native_name("de")
      "Deutsch"

      iex> PkCountries.Languages.get_native_name("ja")
      "日本語"

  """
  def get_native_name(code) when is_binary(code) do
    case Map.get(@languages, String.downcase(code)) do
      nil -> nil
      data -> data["nativeName"]
    end
  end

  @doc """
  Returns full language info for a language code.

  ## Examples

      iex> PkCountries.Languages.get("en")
      %{name: "English", native_name: "English", family: "Indo-European", code: "en"}

  """
  def get(code) when is_binary(code) do
    case Map.get(@languages, String.downcase(code)) do
      nil ->
        nil

      data ->
        %{
          code: data["639-1"],
          name: data["name"],
          native_name: data["nativeName"],
          family: data["family"]
        }
    end
  end

  @doc """
  Returns all language codes.

  ## Examples

      iex> "en" in PkCountries.Languages.all_codes()
      true

  """
  def all_codes do
    Map.keys(@languages)
  end

  @doc """
  Returns the count of supported languages.

  ## Examples

      iex> PkCountries.Languages.count()
      184

  """
  def count do
    map_size(@languages)
  end

  @doc """
  Checks if a language code is valid.

  ## Examples

      iex> PkCountries.Languages.valid?("en")
      true

      iex> PkCountries.Languages.valid?("invalid")
      false

  """
  def valid?(code) when is_binary(code) do
    Map.has_key?(@languages, String.downcase(code))
  end
end
