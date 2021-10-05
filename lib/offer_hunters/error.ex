defmodule OfferHunters.Error do
  @moduledoc """
    creates a model for error handling.
  """
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  @doc """
  Recive the status & result and build a error struct
  ## Examples
  iex> OfferHunters.Error.build(:bad_request, "user not found")
      %OfferHunters.Error{result: "user not found", status: :not_found}
  """
  @spec build(status :: Integer | :atom, result :: String.t()) :: %OfferHunters.Error{
          status: :atom,
          result: String.t()
        }

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end
end
