dir_vector = Dict('E' => [1,0], 'W' => [-1,0], 'N' => [0,1], 'S' => [0,-1])

rot(angle) = return [cosd(angle) -sind(angle); sind(angle) cosd(angle)]

(_, (pos)) = foldl(((waypoint, pos), (instr_dir, instr_arg)) -> begin
  if instr_dir == 'L'
    waypoint = rot(instr_arg)*waypoint
  elseif instr_dir == 'R'
    waypoint = rot(-instr_arg)*waypoint
  elseif instr_dir == 'F'
    pos += instr_arg*waypoint
  else
    waypoint += instr_arg*dir_vector[instr_dir]
  end
  return (waypoint, pos)
end
,begin
  m = match(r"(\w)(\d+)", line)
  (m[1][1], parse(Int32, m[2]))
end for line in eachline("input.txt"); init=([10, 1], [0, 0]))

println(sum(abs.(pos)))
