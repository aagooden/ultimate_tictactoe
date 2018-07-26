
def recur_fact(num, array)
  puts "cheese"
  if array.empty?
  else
  if num == 0 || num == 1
    1
  else
    array.push(num * recur_fact(num - 1, array))
  end
end
end
puts recur_fact(6, [])
