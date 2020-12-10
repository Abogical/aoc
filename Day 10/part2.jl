adapters = Set(parse(Int32, line) for line in eachline("input.txt"))

ways_results = Dict{Int64, Int64}(maximum(adapters) => 1)
function ways(jolt)
  result = get(ways_results, jolt, nothing)
  if isnothing(result)
    result = sum(ways(upjolt) for upjolt in (jolt+1):(jolt+3) if upjolt in adapters)
    ways_results[jolt] = result
  end
  return result
end

println(ways(0))
