# run with `Rscript 6.r`
iterations <- 79
file <- "6.in"
state <- as.numeric(read.csv(file, header = FALSE, sep = ",")[1,])
state <- state + replicate(length(state), 1)

# brute force is too slow for part two :(
for (iter in 0:iterations)
{
    state_length <- length(state)
    # print(state_length)
    # internal state is all initialized to 7
    internal_state <- replicate(state_length, 7)

    # print(state)
    # print(typeof(state))
    # print(replicate(state_length, -1))
    state <- state - replicate(state_length, 1)

    zeros <- sum(state == 0)
    # print(zeros)
    # change 0s to internal state + 2
    # print(state)
    for (i in seq_along(state)) 
    {
        # print(state[i])
        if (state[i] == 0) 
        {
            internal_state[i] = internal_state[i] + 2
            state[i] = internal_state[i]
        }
    }
    if (zeros != 0) {
        new_items <- replicate(zeros, 7)
        internal_state <- append(internal_state, new_items)
        state <- append(state, new_items)
    }
    # internal_state <- append(internal_state, new_items)
    # state <- append(state, new_items)
    # print(zeros)
    # print(state)
    # print("------")
}
print(length(state))
