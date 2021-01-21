defmodule Format do
	def board_reformat(board) do
        	list1 = [Enum.at(board, 0), Enum.at(board, 1), Enum.at(board, 2)]
        	list2 = ["-","-","-"]
		list3 = [Enum.at(board, 3), Enum.at(board, 4), Enum.at(board, 5)]
		list4 = ["-","-","-"]
		list5 = [Enum.at(board, 6), Enum.at(board, 7), Enum.at(board, 8)]

		_reformat =
		Enum.concat([], [list1])
		|> Enum.concat([list2])
		|> Enum.concat([list3])
		|> Enum.concat([list4])
		|> Enum.concat([list5])
	end

	def print_reformat(board) do
    		board
    		|> Enum.map(fn [x,y,z] -> IO.puts("           #{x}  |  #{y}  |  #{z}  ") end)
    	end

    	def row_reformat(board) do
        	_reformat = [[Enum.at(board, 0), Enum.at(board, 1), Enum.at(board, 2)],
			     [Enum.at(board, 3), Enum.at(board, 4), Enum.at(board, 5)],
			     [Enum.at(board, 6), Enum.at(board, 7), Enum.at(board, 8)]]
	end

	def column_reformat(board) do
    		_reformat = row_reformat(board)
    		|> List.zip
    		|> Enum.map(&Tuple.to_list/1)
    	end

    	def diagonal_reformat(board) do
        	list1 = [Enum.at(board, 0), Enum.at(board, 4), Enum.at(board, 8)]
		list2 = [Enum.at(board, 2), Enum.at(board, 4), Enum.at(board, 6)]
		_reformat = Enum.concat([list1], [list2])
	end
end
