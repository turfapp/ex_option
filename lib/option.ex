defmodule Option do
  defmacro __using__(_opts) do
    quote do
      import Option.{Either, Functor, Monad, Option}
    end
  end
end
