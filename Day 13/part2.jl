using Base.Iterators

lines = readlines("input.txt")
ids = [id_str == "x" ? BigInt(1) : parse(BigInt, id_str) for id_str in split(lines[2], ',')]

(time, rest_ids) = Iterators.peel(ids)
step = time

for id in rest_ids
  for K in countfrom(time, step)
    if (K+1) % id == 0
      global step = lcm(step, id)
      global time = K+1
      break
    end
  end
end

println(time-length(ids)+1)
