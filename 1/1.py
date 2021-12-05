
lines = []
with open('in.in', 'r') as fp:
    lines = list(map(int, fp.readlines()))

# print(len(lines))
count = 0
prev = lines[0]
for line in lines:
    if line > prev:
        count+=1
    prev = line 

print(count)
