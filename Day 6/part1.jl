answers = Set()
count = 0

for line in eachline("input.txt")
  if isempty(line)
    global answers = Set()
  else
    for c in line
      if !(c in answers)
        global count += 1
        push!(answers, c)
      end
    end
  end
end

println(count)
