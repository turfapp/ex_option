defmodule ExOption do
  defmacro __using__(_opts) do
    quote do
      alias ExOption.{Either, Monad, Option}

      import Monad
      import Either, except: [unwrap: 2, unwrap!: 1]
      import Option, except: [unwrap: 2, unwrap!: 1]
    end
  end
end
