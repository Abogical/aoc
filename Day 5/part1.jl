println(maximum(sum((collect(line[1:7]) .== 'B') .* exp2.(9:-1:3)) + sum((collect(line[8:10]) .== 'R') .* exp2.(2:-1:0)) for line in eachline("input.txt")))
