using IterTools

preamble, rest = Iterators.peel(partition((parse(Int64, n) for n in eachline("input.txt")), 26, 1))
sums = Set{Int64}(Iterators.take(preamble, 25))
for prevs in rest
  target = prevs[26]
  push!(sums, prevs[25])
  if !any(target-key in sums for key in prevs[1:25])
    println(target)
    break
  end
  delete!(sums, prevs[1])
end
