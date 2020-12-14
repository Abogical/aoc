using Base.Iterators

lines = readlines("input.txt")
ids = [id_str == "x" ? BigInt(1) : parse(BigInt, id_str) for id_str in split(lines[2], ',')]

time = 0
(step, rest_ids) = Iterators.peel(ids)

for id in rest_ids
  for K in countfrom(time+1, step)
    if K % id == 0
      global step = lcm(step, id)
      global time = K
      break
    end
  end
end

println(time-length(ids)+1)
