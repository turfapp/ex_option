defprotocol Option.Monad do
  alias Option.Monad

  @spec bind(Monad.t(), (term() -> t)) :: t when t: Monad.t()
  def bind(x, f)
end

defimpl Option.Monad, for: Tuple do
  alias Option.{Option, Either}

  # Option.Option
  def bind(:none, _), do: Option.none()
  def bind({:some, value}, f), do: f.(value)

  # Option.Either
  def fmap({:error, value}, _f), do: Either.error(value)
  def fmap({:ok, value}, f), do: f.(value)
end
