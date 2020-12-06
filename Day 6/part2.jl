answers = Set()
just_reset = true
count = 0

function reset()
  global count += length(answers)
end

for line in eachline("input.txt")
  if isempty(line)
    reset()
    global just_reset = true
  else
    line_collection = (c for c in line)
    if just_reset
      global answers = Set(line_collection)
      global just_reset = false
    else
      intersect!(answers, line_collection)
    end
  end
end

reset()

println(count)

