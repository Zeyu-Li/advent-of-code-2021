
lines = []
with open('2.in', 'r') as fp:
    lines = fp.readlines()

# print(len(lines))
x = 0
y = 0
for line in lines:
    command, n = line.split()
    if command == 'forward': x += int(n)
    elif command == 'down': y += int(n)
    else: y -= int(n)

print(x, y, x * y)
