using Base.Iterators
using Distributed

lines = readlines("input.txt")
ids = [id_str == "x" ? BigInt(1) : parse(BigInt, id_str) for id_str in split(lines[2], ',')]
(max_id, max_id_offset) = findmax(ids)
time_offsets = collect(Iterators.filter(n -> n != 0, take(countfrom(1-max_id_offset), length(ids))))
deleteat!(ids, max_id_offset)
for time in countfrom(BigInt(100000000000000) + BigInt(100000000000000)%max_id, max_id)
  if all(((time.+time_offsets) .% ids) .== 0)
    println(time-max_id_offset+1)
    exit(0)
  end
  @show time
end
