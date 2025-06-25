defmodule ExOption.Option do
  @type some(t) :: {:some, t}
  @type nnone() :: :none

  @type t(t) :: some(t) | nnone()

  @doc """
  Wrap the value in a `:some` tuple.

  ## Examples

      iex> some(:hello)
      {:some, :hello}

      iex> some(:world)
      {:some, :world}

      iex> some({:some, :hello})
      {:some, {:some, :hello}}

  """
  @spec some(t) :: some(t) when t: var
  def some(value), do: {:some, value}

  @doc """
  The `:none` value.

  ## Examples

      iex> none()
      :none

  """
  @spec none() :: nnone()
  def none, do: :none

  @doc """
  Returns `true` if the value is a `:some` tuple.

  ## Examples

      iex> some?({:some, :hello})
      true

      iex> some?(:none)
      false

      iex> some?(:something_else)
      false

  """
  @spec some?(any()) :: boolean()
  def some?({:some, _}), do: true
  def some?(_), do: false

  @doc """
  Returns `true` if the value is `:none`.

  ## Examples

      iex> none?(:none)
      true

      iex> none?({:some, :world})
      false

      iex> none?(:something_else)
      false

  """
  @spec none?(any()) :: boolean()
  def none?(:none), do: true
  def none?(_), do: false

  @doc """
  Returns the contained `:some` value.

  Raises if the value is anything else.

  ## Examples

      iex> Option.unwrap!({:some, :hello})
      :hello

      iex> Option.unwrap!(:none)
      ** (RuntimeError) Called `Option.unwrap!()` on something other than a `:some` tuple

      iex> Option.unwrap!(:something_else)
      ** (RuntimeError) Called `Option.unwrap!()` on something other than a `:some` tuple

  """
  @spec unwrap!(some(t)) :: t when t: var
  def unwrap!({:some, value}), do: value
  def unwrap!(_), do: raise("Called `Option.unwrap!()` on something other than a `:some` tuple")

  @doc """
  Returns the contained `:some` value, or the given default if the value is not a `:some`
  tuple.

  ## Examples

      iex> Option.unwrap({:some, :hello}, :world)
      :hello

      iex> Option.unwrap(:none, :world)
      :world

      iex> Option.unwrap(:something_else, :world)
      :world

  """
  @spec unwrap(t(t), t) :: t when t: var
  def unwrap({:some, value}, _default), do: value
  def unwrap(_, default), do: default
end
