defmodule BeamLabCountries.Union do
  @moduledoc """
  Union struct representing international organizations and country groupings.
  """

  defstruct [
    :code,
    :name,
    :type,
    :founded,
    :headquarters,
    :website,
    :wikipedia,
    :members
  ]

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          type: atom() | nil,
          founded: String.t() | nil,
          headquarters: String.t() | nil,
          website: String.t() | nil,
          wikipedia: String.t() | nil,
          members: [String.t()]
        }
end
