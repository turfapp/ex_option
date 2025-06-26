defmodule ExOption.Monad do
  alias ExOption.{Option, Either}

  # ExOption.Option
  def bind(:none, _), do: Option.none()
  def bind({:some, value}, f), do: f.(value)

  # ExOption.Either
  def bind({:error, value}, _f), do: Either.error(value)
  def bind({:ok, value}, f), do: f.(value)

  # Any other value
  def bind(value, f), do: f.(value)

  @doc """
  Monadic version of the pipe operator.

  ## Examples

      iex> {:ok, "Hello!"} ~>> String.reverse()
      "!olleH"

      iex> {:some, "Hello!"} ~>> String.reverse()
      "!olleH"

      iex> {:error, "Hello!"} ~>> String.reverse()
      {:error, "Hello!"}

  The `~>>/2` operator is mostly useful when there is a desire to execute a series
  of operations resembling a pipeline, where some or all of the operations may fail:

      iex> {:ok, "Hello!"} ~>> (fn _ -> error("Failed!") end).() ~>> (fn value -> ok(value) end).()
      {:error, "Failed!"}

      iex> {:ok, "Hello"} ~>> (fn value -> ok(value <> ", world!") end).()
      {:ok, "Hello, world!"}

      iex> {:ok, "A"} ~>> (fn value -> ok(value <> "B") end).() ~>> (fn value -> ok(value <> "C") end).()
      {:ok, "ABC"}

  If the function on the left-hand side of the operator does not return a monadic
  value (e.g. not an `:ok`/`:error`/`:some` tuple or `:none`), then the resulting
  value will also not be a monadic value.

      iex> ok("Hello!") ~>> String.reverse()
      "!olleH"

  """
  defmacro left ~>> right do
    quote do
      bind(unquote(left), fn val ->
        unquote(Macro.pipe(quote(do: val), right, 0))
      end)
    end
  end
end
