
# def recur_fact(num, array)
#   puts "cheese"
#   if array.empty?
#   else
#   if num == 0 || num == 1
#     1
#   else
#     array.push(num * recur_fact(num - 1, array))
#     puts array
#   end
# end
# end
# puts recur_fact(6, [])



def recur_fact(num, array)
	puts "first"
	array.push(num)
  if num == 0 || num == 1
  	puts "if is true"
    1
  else
  	puts "In the else statement"
  	p "array is #{array}"
    result = num * recur_fact(num - 1, array)
    puts result
  end
end
puts recur_fact(6, []) # 720



# def iter_fact(num)
#   if num == 0 || num == 1
#     1
#   else
#     sum = 1
#     num.times do |n|
#       sum *= (n + 1)
#       puts sum
#     end
#     sum
#   end
# end

# puts iter_fact(6) # 720