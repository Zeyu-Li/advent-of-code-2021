items = 2000

items -= 1

counter = 0
prev = gets.to_i
while items > 0
    curr = gets.to_i
    if prev < curr
        counter += 1
    end 
    prev = curr
    items -= 1
end 

puts counter
