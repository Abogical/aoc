using IterTools

diff_add = Dict(1 => [1,0], 2 => [0,0], 3 => [0,1])
(d1, d2) = sum(diff_add[b-a] for (a,b) in IterTools.partition([0; sort(parse.(Int64, eachline("input.txt")))], 2, 1))
println(d1*(d2+1))
