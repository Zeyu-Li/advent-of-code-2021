fs = require 'fs'
file = '12.in'

output = {}

foo = ->
    fs.readFileSync file, 'ascii'

is_lower = (string) -> string == string.toLowerCase()

add_to_adj = (item) -> (
    [src, dst] = item.split('-')
    if (output[src])
        output[src].push(dst)
    else
        output[src] = [dst]
    if (output[dst])
        output[dst].push(src)
    else
        output[dst] = [src]
)

new_list = foo().split('\n').map((item) -> item.replace(/\r|\n/g, ''))
add_to_adj item for item in new_list

queue = [['start',]]
paths = new Set()

while queue.length != 0 
    curr_path = queue.pop()

    if curr_path[curr_path.length-1] == "end"
        paths.add(curr_path)
        continue

    check = (node) -> (
        if !is_lower(node) || !(node in curr_path) 
            queue.push(curr_path.concat node)
    )

    check node for node in output[curr_path[curr_path.length-1]]

console.log paths.size
