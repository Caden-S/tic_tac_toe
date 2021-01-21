defmodule TicTacToe do
	import Format

	def play do
    		create_board()
        	|> game_loop(0, true)
	end

	def game_loop(board, player_num, valid) do
    		num = rem(player_num, 2)
        	check_win(board, abs(player_num - 1))

		IEx.Helpers.clear
		IO.puts("\nFor help playing, type 'help' or '?'.")
		IO.puts("\n            Tic-Tac-Toe!")
		print_board(board)

		if num == 0 do
    			if valid == false do
        			IO.puts("Please enter a valid input.")
				IO.gets("Player 1 (X): ")
				|> check_input(board, num)
			end
			if valid == true do
				IO.gets("Player 1 (X): ")
				|> check_input(board, num)
			end
		end
		if num == 1 do
			if valid == false do
    				IO.puts("Please enter a valid input.")
    				IO.gets("Player 2 (O): ")
    				|> check_input(board, num)
    			end
    			if valid == true do
				IO.gets("Player 2 (O): ")
				|> check_input(board, num)
			end
		end
	end

	def create_board() do
    		_board = [" "," "," ",
    			  " "," "," ",
    			  " "," "," "]
    	end

	def print_board(board) do
		IO.puts("\n")
		Format.board_reformat(board)
		|> Format.print_reformat()
		IO.puts("\n")
	end

	def mark_spot(board, location, player_num) do
    		if player_num == 0 do
			List.replace_at(board, location - 1, "X")
			|> game_loop(player_num + 1, true)
		end
		if player_num == 1 do
    			List.replace_at(board, location - 1, "O")
    			|> game_loop(player_num + 1, true)
    		end
    	end 

    def check_input(input, board, player_num) do

        valid_inputs = ["1","2","3","4","5","6","7","8","9","help","?"]
        new_input = String.replace(input, "\n", "")

        if Enum.member?(valid_inputs, new_input) == false do
            game_loop(board, player_num, false)
        end
        
        if new_input == "help" || new_input == "?" do
            help(board, player_num, true)
        end    
        int_input = String.to_integer(new_input)    

        if player_num == 0 do
            check_spot(int_input, board, player_num)
            mark_spot(board, int_input, player_num)
        end
        if player_num == 1 do
            check_spot(int_input, board, player_num)
            mark_spot(board, int_input, player_num)
        end
    end

    def check_spot(input, board, player_num) do
        if Enum.at(board, input - 1) != " " do
            game_loop(board, player_num, false)
        end
        if Enum.at(board, input - 1) == " " do
            :ok
        end
    end

    def win(board, player_num) do
        IEx.Helpers.clear
        print_board(board)
        
        valid_input = ["y\n", "n\n"]
        num = player_num + 1
        
        IO.puts("Congratulations Player #{num}!\n")
        input = IO.gets("Would you like to play again? (y/n): ")

        if Enum.member?(valid_input, input) == false do
            win(board, player_num)
        end

        if input == "y\n" do
            create_board()
            |> game_loop(0, true)
        end
        if input == "n\n" do
            exit(:shutdown)
        end
    end

    def tie(board) do
        IEx.Helpers.clear
        print_board(board)

        valid_input = ["y\n", "n\n"]

        IO.puts("It's a tie!\n")
        input = IO.gets("Would you like to play again? (y/n): ")

        if Enum.member?(valid_input, input) == false do
            tie(board)
        end

        if input == "y\n" do
            create_board()
            |> game_loop(0, true)
        end
        if input == "n\n" do
            exit(:shutdown)
        end
    end

    def check_win(board, player_num) do
        row_win_format = Format.row_reformat(board)
        column_win_format = Format.column_reformat(board)
        diagonal_win_format = Format.diagonal_reformat(board)
        
        if player_num == 0 do
            if Enum.member?(Enum.map(row_win_format, &Enum.count(&1, fn x -> x == "X" end)), 3) == true do
                win(board, player_num)
            end
            if Enum.member?(Enum.map(column_win_format, &Enum.count(&1, fn x -> x == "X" end)), 3) == true do
                win(board, player_num)
            end
            if Enum.member?(Enum.map(diagonal_win_format, &Enum.count(&1, fn x -> x == "X" end)), 3) == true do
                win(board, player_num)
            end
        end
        if player_num == 1 do
            if Enum.member?(Enum.map(row_win_format, &Enum.count(&1, fn x -> x == "O" end)), 3) == true do
                win(board, player_num)
            end
            if Enum.member?(Enum.map(column_win_format, &Enum.count(&1, fn x -> x == "O" end)), 3) == true do
                win(board, player_num)
            end
            if Enum.member?(Enum.map(diagonal_win_format, &Enum.count(&1, fn x -> x == "O" end)), 3) == true do
                win(board, player_num)
            end
        end
        if Enum.member?(board, " ")  == false do
            tie(board)
        end
    end
  
    def help(board, player_num, true) do
        IEx.Helpers.clear
        example_board = ["1","2","3",
                         "4","5","6",
                         "7","8","9"]
        print_board(example_board)
        IO.puts("When it is your turn type in the number corresponding with \n      the number in the box in this example board.\n")
        IO.gets("Type anything when ready to continue: ")
        game_loop(board, player_num, true)
    end
end
  
