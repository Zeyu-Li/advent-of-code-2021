# to run do `ruby 11.rb`

def increment(state)
    for i in 0..11
        for j in 0..11
            state[i][j] += 1
        end
    end
end

def has10s(state)
    for i in 1..10
        for j in 1..10
            if state[i][j] == 10
                return true
            end
        end
    end
    return false
end

def flashes(state)
    flashesStack = []
    # get list
    for i in 1..10
        for j in 1..10
            if state[i][j] == 10
                flashesStack.append([i, j])
            end
        end
    end

    while flashesStack.length() != 0
        # pop from stack and increment + check surroundings
        # print("\n")
        # print("\n")
        # print(flashesStack)
        # print("\n")
        curr = flashesStack.pop 
        # flashesStack.drop(1)
        # print(curr)
        y = curr[0]
        x = curr[1]
        # increment self to remove 10
        
        (-1..1).each do |yy|
            (-1..1).each do |xx|
                next if (yy == xx && xx == 0) || y+yy < 0 || x+xx < 0 || y+yy > 10 || x+xx > 10
                state[y+yy][x+xx] += 1
                flashesStack.push [y+yy, x+xx] if state[y+yy][x+xx] == 10
            end
        end
        # state[y][x] += 1
        # # all 8 sides
        # state[y+1][x] += 1
        # if (state[y+1][x] == 10)
        #     flashesStack.append([y+1, x])
        # end
        # state[y][x+1] += 1
        # if (state[y][x+1] == 10)
        #     flashesStack.append([y][x+1])
        # end
        # state[y][x-1] += 1
        # if (state[y][x-1] == 10)
        #     flashesStack.append([y][x-1])
        # end
        # state[y-1][x] += 1
        # if (state[y-1][x] == 10)
        #     flashesStack.append([y-1, x])
        # end
        # # corners
        # state[y-1][x-1] += 1
        # if (state[y-1][x-1] == 10)
        #     flashesStack.append([y-1, x-1])
        # end
        # state[y-1][x+1] += 1
        # if (state[y-1][x+1] == 10)
        #     flashesStack.append([y-1, x+1])
        # end
        # state[y+1][x-1] += 1
        # if (state[y+1][x-1] == 10)
        #     flashesStack.append([y+1, x-1])
        # end
        # state[y+1][x+1] += 1
        # if (state[y+1][x+1] == 10)
        #     flashesStack.append([y+1, x+1])
        # end
        flashesStack = flashesStack.compact
    end
end

def reset(state)
    adds = 0
    for i in 1..10
        for j in 1..10
            if state[i][j] > 9
                adds += 1
                state[i][j] = 0
            end
        end
    end
    return adds
end

# file in
fp = File.open("11.in")
file_data = fp.readlines.map(&:chomp)
fp.close

min = -9001
# get to state
state = []
boarder = []
for i in 0..11
    boarder.append(min)
end

state.append(boarder)
for line in file_data
    state.append([min] + line.split("").map{ |char| char.to_i } + [min])
end
state.append(boarder)

total = 0
steps = 999
for i in 0..steps
    # step 1, increment
    increment(state)
    # step 2, flashes
    flashes(state)
    # while has10s(state)
    #     flashes(state)
    # end
    # reset
    if reset(state) == 100
        print(i + 1, "\n")
        break
    end
end

# print(total, "\n")

# ["user1", "user2", "user3"]