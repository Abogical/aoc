rules = Dict{String, Union{Bool, Array{SubString{String}}}}(rule[1] => rule[2] == "no other bags" ? SubString{String}[] : [color[1] for color in eachmatch(r"(\S+ \S+) bag", rule[2])] for rule in match.(r"^(\S+ \S+) bags contain ([^\.]+)\.$", eachline("input.txt")))

processing = Set{SubString{String}}()
function has_shiny_gold(color)
  if color in processing
    return missing
  end
  result = get(rules, color, false)
  if isa(result, Array)
    push!(processing, color)
    result = any(child == "shiny gold" ? true : has_shiny_gold(child) for child in result)
    global rules[color] = result
    delete!(processing, color)
    return result
  end
  return result
end

println(count(has_shiny_gold(color) for color in keys(rules)))
