defprotocol Option.Functor do
  alias Option.Functor

  @spec fmap(Functor.t(), (term() -> term())) :: Functor.t()
  def fmap(x, f)
end

defimpl Option.Functor, for: Tuple do
  alias Option.{Option, Either}

  # Option.Option
  def fmap(:none, _), do: Option.none()
  def fmap({:some, value}, f), do: f.(value) |> Option.some()

  # Option.Either
  def fmap({:error, value}, _f), do: Either.error(value)
  def fmap({:ok, value}, f), do: f.(value) |> Either.ok()
end
