lines = []
read_file = '14.in' # '14.in'

with open(read_file, 'r') as fp:
    lines = fp.read().splitlines()

string = lines[0]

hash_table = dict()
for item in lines[2:]:
    a, b = item.split(' -> ')
    hash_table[a] = b

for _ in range(10):
    new_string = ''
    for index, char in enumerate(string):
        # print(index, len(string) - 1)
        if index == len(string) - 1:
            break
        new_string += char + hash_table[char + string[index + 1]]

    new_string += string[-1]
    # print(new_string)
    # break

    string = new_string

print(len(string))

counts = [string.count(char) for char in set(string)]
print(max(counts) - min(counts))
