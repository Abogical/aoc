lines = readlines("input.txt")
req_time = parse(Int32, lines[1])
println(prod(minimum(begin
  id = parse(Int32, id_str)
  (id-req_time%id, id)
end for id_str in split(lines[2], ',') if id_str != "x")))
