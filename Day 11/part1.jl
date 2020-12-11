using ImageFiltering

@enum SeatStatus empty occupied floor
seat_parser = Dict('L' => empty, '#' => occupied, '.' => floor)

state = [[seat_parser[char] for char in line] for line in eachline("input.txt")]
state = [row[colnum] for row in state, colnum in 1:length(state[1])]
prev_state = nothing

while prev_state != state
  occupied_seats = (state .== occupied)
  occupied_count = mapwindow(window -> sum(window[1, 1:3] + window[3, 1:3]) + window[2, 1] + window[2, 3], occupied_seats, (3,3), border=Fill(0))
  global prev_state = copy(state)
  global state[findall((occupied_count .== 0) .& (state .== empty))] .= occupied
  global state[findall((occupied_count .>= 4) .& occupied_seats)] .= empty
end
println(sum(state .== occupied))
