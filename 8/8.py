with open('8.in') as fp:
    lines = fp.read().splitlines()
    lines = [i.split(' | ')[1] for i in lines]

    total = 0
    for line in lines:
        blocks = line.split()

        t = 0
        for block in blocks:
            # print(block)
            
            if len(block) in [2, 3, 4, 7]:
                total += 1
                t+=1

        # print(t)

    print(total)