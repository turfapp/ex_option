defmodule ExOption.Either do
  @type ok(t) :: {:ok, t}
  @type error(e) :: {:error, e}

  @type t(t, e) :: ok(t) | error(e)

  @doc """
  Wrap the value in an `:ok` tuple.

  ## Examples

      iex> ok(:hello)
      {:ok, :hello}

      iex> ok(:world)
      {:ok, :world}

      iex> ok({:ok, :hello})
      {:ok, {:ok, :hello}}

  """
  @spec ok(t) :: ok(t) when t: var
  def ok(value), do: {:ok, value}

  @doc """
  Wrap the value in an `:error` tuple.

  ## Examples

      iex> error(:hello)
      {:error, :hello}

      iex> error(:world)
      {:error, :world}

      iex> error({:error, :hello})
      {:error, {:error, :hello}}

  """
  @spec error(e) :: error(e) when e: var
  def error(value), do: {:error, value}

  @doc """
  Returns `true` if the value is an `:ok` tuple.

  ## Examples

      iex> ok?({:ok, :hello})
      true

      iex> ok?({:error, :world})
      false

      iex> ok?(:something_else)
      false

  """
  @spec ok?(any()) :: boolean()
  def ok?({:ok, _}), do: true
  def ok?(_), do: false

  @doc """
  Returns `true` if the value is an `:error` tuple.

  ## Examples

      iex> error?({:error, :hello})
      true

      iex> error?({:ok, :world})
      false

      iex> error?(:something_else)
      false

  """
  @spec error?(any()) :: boolean()
  def error?({:error, _}), do: true
  def error?(_), do: false

  @doc """
  Returns the contained `:ok` value.

  Raises if the value is anything else.

  ## Examples

      iex> Either.unwrap!({:ok, :hello})
      :hello

      iex> Either.unwrap!({:error, :world})
      ** (RuntimeError) Called `Either.unwrap!()` on something other than an `:ok` tuple

      iex> Either.unwrap!(:something_else)
      ** (RuntimeError) Called `Either.unwrap!()` on something other than an `:ok` tuple

  """
  @spec unwrap!(ok(t)) :: t when t: var
  def unwrap!({:ok, value}), do: value
  def unwrap!(_), do: raise("Called `Either.unwrap!()` on something other than an `:ok` tuple")

  @doc """
  Returns the contained `:ok` value, or the given default if the value is not an `:ok` tuple.

  ## Examples

      iex> Either.unwrap({:ok, :hello}, :world)
      :hello

      iex> Either.unwrap({:error, :hello}, :world)
      :world

      iex> Either.unwrap(:something_else, :world)
      :world

  """
  @spec unwrap(t(t, term()), t) :: t when t: var
  def unwrap({:ok, value}, _default), do: value
  def unwrap(_, default), do: default

  @doc """
  Returns the contained `:error` value.

  Raises if the value is anything else.

  ## Examples

      iex> unwrap_error!({:error, :hello})
      :hello

      iex> unwrap_error!({:ok, :world})
      ** (RuntimeError) Called `Either.unwrap_error!()` on something other than an `:error` tuple

      iex> unwrap_error!(:something_else)
      ** (RuntimeError) Called `Either.unwrap_error!()` on something other than an `:error` tuple

  """
  @spec unwrap_error!(error(e)) :: e when e: var
  def unwrap_error!({:error, value}), do: value
  def unwrap_error!(_), do: raise("Called `Either.unwrap_error!()` on something other than an `:error` tuple")

  @doc """
  Returns the contained `:error` value, or the given default if the value is not an `:error`
  tuple.

  ## Examples

      iex> unwrap_error({:error, :hello}, :world)
      :hello

      iex> unwrap_error({:ok, :hello}, :world)
      :world

      iex> unwrap_error(:something_else, :world)
      :world

  """
  @spec unwrap_error(t(term(), e), e) :: e when e: var
  def unwrap_error({:error, value}, _default), do: value
  def unwrap_error(_, default), do: default
end
