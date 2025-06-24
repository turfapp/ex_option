defmodule OptionTest do
  use ExUnit.Case
  doctest Option

  test "greets the world" do
    assert Option.hello() == :world
  end
end
