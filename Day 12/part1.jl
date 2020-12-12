dir_vector = Dict('E' => [1,0], 'W' => [-1,0], 'N' => [0,1], 'S' => [0,-1])

rot(angle) = return [cosd(angle) -sind(angle); sind(angle) cosd(angle)]

(_, (pos)) = foldl(((dir, pos), (instr_dir, instr_arg)) -> begin
  if instr_dir == 'L'
    dir = rot(instr_arg)*dir
  elseif instr_dir == 'R'
    dir = rot(-instr_arg)*dir
  else
    pos += (instr_dir == 'F' ? dir : dir_vector[instr_dir])*instr_arg
  end
  return (dir, pos)
end
,begin
  m = match(r"(\w)(\d+)", line)
  (m[1][1], parse(Int32, m[2]))
end for line in eachline("input.txt"); init=([1, 0], [0, 0]))

println(sum(abs.(pos)))
