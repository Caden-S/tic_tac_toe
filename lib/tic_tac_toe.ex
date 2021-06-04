defmodule TicTacToe do
  alias Game

  def main() do
    %Game{}
    |> play()
  end

  def play(game) do
    IEx.Helpers.clear()
    IO.puts("\nFor help playing, type 'help' or '?'.")
    IO.puts("\n            Tic-Tac-Toe!")
    print_board(game.board)
    IO.puts(game.error)

    input =
      IO.gets("Player #{game.player}: ")
      |> String.replace("\n", "")

    if input_valid?(input) do
      if input == "help" || input == "?" do
        help(game)
      else
        new_game = %{game | error: ''}
        location = String.to_integer(input)
        new_board = mark_spot(new_game, location)
        check_win(%{new_game | board: new_board})
      end
    else
      play(%{game | error: "Please enter a valid input."})
    end
  end

  def print_board(board) do
    IO.puts("\n")

    Format.board_reformat(board)
    |> Format.print_reformat()

    IO.puts("\n")
  end

  def mark_spot(game, location) do
    if spot_taken?(game, location) do
      new_game = %{game | error: "Please choose an empty space."}
      play(new_game)
    else
      List.replace_at(game.board, location - 1, game.player)
    end
  end

  def input_valid?(input) do
    valid_inputs = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "help", "?"]

    Enum.member?(valid_inputs, input)
  end

  def spot_taken?(game, location) do
    Enum.at(game.board, location - 1) != " "
  end

  def win(board, player) do
    IEx.Helpers.clear()
    print_board(board)

    valid_input = ["y\n", "n\n"]

    IO.puts("Congratulations Player #{player}!\n")
    input = IO.gets("Would you like to play again? (y/n): ")

    if Enum.member?(valid_input, input) == false do
      win(board, player)
    end

    if input == "y\n" do
      main()
    end

    if input == "n\n" do
      exit(:shutdown)
    end
  end

  def tie(board) do
    IEx.Helpers.clear()
    print_board(board)

    valid_input = ["y\n", "n\n"]

    IO.puts("It's a tie!\n")
    input = IO.gets("Would you like to play again? (y/n): ")

    if Enum.member?(valid_input, input) == false do
      tie(board)
    end

    if input == "y\n" do
      main()
    end

    if input == "n\n" do
      exit(:shutdown)
    end
  end

  def switch_player(player) do
    if player == "X" do
      "O"
    else
      "X"
    end
  end

  def check_win(game) do
    win_condition(game)

    if Enum.member?(game.board, " ") == false do
      tie(game.board)
    end
  end

  def check_for_win(win_format, player) do
    Enum.map(win_format, fn x -> Enum.all?(x, &(&1 == player)) end)
    |> Enum.any?()
  end

  def win_condition(game) do
    row_win_format = Format.row_reformat(game.board)
    column_win_format = Format.column_reformat(game.board)
    diagonal_win_format = Format.diagonal_reformat(game.board)
    win_possibilities = [row_win_format, column_win_format, diagonal_win_format]

    player_won? =
      Enum.map(win_possibilities, &check_for_win(&1, game.player))
      |> Enum.any?()

    if player_won? do
      win(game.board, game.player)
    else
      new_player = switch_player(game.player)
      new_game = %{game | board: game.board, player: new_player}
      play(new_game)
    end
  end

  def help(game) do
    IEx.Helpers.clear()
    example_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    print_board(example_board)

    IO.puts(
      "When it is your turn type in the number corresponding with \n      the number in the box in this example board.\n"
    )

    IO.gets("Type anything when ready to continue: ")
    play(game)
  end
end
