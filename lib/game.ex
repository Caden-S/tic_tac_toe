defmodule Game do
  defstruct player: "X",
            board: [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            state: 0,
            error: ''
end
