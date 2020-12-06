list = Set(sum((collect(line[1:7]) .== 'B') .* exp2.(9:-1:3)) + sum((collect(line[8:10]) .== 'R') .* exp2.(2:-1:0)) for line in eachline("input.txt"))

println(intersect(setdiff(0:(127*8+7), list), (l+1 for l in list), (l-1 for l in list)))
