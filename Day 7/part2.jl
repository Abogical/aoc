rules = Dict{String, Union{Int64, Array{Tuple{Int64,SubString{String}}}}}(rule[1] => rule[2] == "no other bags" ? Tuple{Int64,SubString{String}}[] : [(parse(Int64, color[1]), color[2]) for color in eachmatch(r"(\d+) (\S+ \S+) bag", rule[2])] for rule in match.(r"^(\S+ \S+) bags contain ([^\.]+)\.$", eachline("input.txt")))

function count_bags(color)::Int64
  result = get(rules, color, 0)
  if isa(result, Array)
    result = isempty(result) ? 0 : sum(color_count*(count_bags(subcolor) + 1) for (color_count, subcolor) in result)
    global rules[color] = result
    return result
  end
  return result
end

println(count_bags("shiny gold"))
