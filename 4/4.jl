# run with `julia 4.jl`
using Printf

function toInt(str)::Int64
    return parse(Int64, str)
end

function crossout(boards, call)
    for (b, board) in enumerate(boards)
        for (i, row) in enumerate(board)
            for (j, item) in enumerate(row)
                if item == call
                    boards[b][i][j] = 0
                    @goto endBoard
                end
            end
        end
        @label endBoard
    end
    return
end

function sumBoard(board)
    total = 0
    for row in board
        for item in row
            total += item
        end
    end
    return total
end

function getWinner(boards)
    win = 0
    for board in boards
        # check rows
        for row in board
            for item in row
                if item != 0
                    @goto endRow
                end
            end
            win = sumBoard(board)
            @goto winBoard

            @label endRow
        end
        # check columns
        # transpose does not work :(
        # break
        for (i, row) in enumerate(board)
            for (j, item) in enumerate(row)
                if board[j][i] != 0
                    @goto endRow2
                end
            end
            win = sumBoard(board)
            @goto winBoard

            @label endRow2
        end
    end
    @label winBoard
    return win
end

function main()
    file = "4.in"
    fp = open(file, "r")

    boards = []
    calls = []
    single_board = []
    start = false
    line_count = 0

    for lines in readlines(fp)
        # increment line_count
        line_count += 1 

        if (line_count + 4) % 6 == 0
            if start
                push!(boards, single_board)
                single_board = []
            else
                start = true
            end
        end

        if (line_count == 1)
            calls = map(toInt, split(lines, ','))
        else 
            if lines == "" continue end
            push!(single_board, map(toInt, split(lines)))
            # println(map(toInt, split(lines)))
        end
    end
    close(fp)

    winner = 0
    for call in calls
        crossout(boards, call)
        # println(boards)
        # break
        winner = getWinner(boards)
        if (winner != 0)
            
            println("$winner $call")
            winner *= call
            break
        end
    end
    println(winner)
end

main()
