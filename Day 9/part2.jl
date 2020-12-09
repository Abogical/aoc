lines = parse.(Int64, Iterators.takewhile(s -> s !== "776203571", eachline("input.txt")))
cumset = Dict(Iterators.accumulate(((s, _),(ind, n)) -> s+n => ind, enumerate(lines); init=(0 => 0)))
for (sum, ind) in cumset
  other_ind = get(cumset, 776203571+sum, nothing)
  if !isnothing(other_ind)
    (min, max) = extrema(lines[ind:(ind > other_ind ? -1 : 1):other_ind])
    println(min+max)
    break
  end
end
