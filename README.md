# ExOption

<!-- README START -->

`ex_option` is library that provides the `Either` and `Option` monad in Elixir.

## Installation

`ex_option` is not available in Hex, and can therefore only be installed through Git by
adding `:ex_option` to your list of dependencies in `mix.exs` like so:

```elixir
def deps do
  [
    {:ex_option, git: "https://github.com/turfapp/ex_option.git", branch: "main"}
  ]
end
```

## Basic usage

Elixir uses tuple-based `{:ok, value}` and `{:error, reason}` for error handling. Normally, in order to deal with these values, you have to do a case-analysis:

```elixir
def new_date(date, time) do
  case DateTime.new(date, time) do
    {:ok, time} -> time
    {:error, reason} -> {:error, reason}
  end
end
```

However, this quickly becomes cumbersome when you have to pipe multiple operations that may fail together. In light of this, `ex_option` introduces the `~>>/2` operator, which is a monadic variant of the familiar `|>/2` operator. The `~>>/2` operator implicitly handles any errors that may have occurred in the pipeline:

```elixir
# Imports the necessary functions and macros
use ExOption

def convert_date(date, time, timezone) do
  DateTime.new(date, time)
  # `DateTime.new/2` returns an `{:ok, value}` or `{:error, reason}` tuple. The `~>>/2` operator checks
  # the returned value, and either (1) passes `value` as the first argument to the function on the
  # right-hand side, or (2) returns `{:error, reason}` and does not evaluate the right-hand side.
  ~>> DateTime.convert(timezone)
  ~>> DateTime.add(42)
  # Wrap the result of `DateTime.add/2` in an `{:ok, value}` tuple
  ~>> ok()
end
```

`ex_option` also has an implementation to work with `{:some, value}` and `:none`. The same `~>>/2` operator can be used for values of that form.

<!-- README END -->