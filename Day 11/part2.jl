using Distributed
using Base.Iterators

@enum SeatStatus empty occupied floor
seat_parser = Dict('L' => empty, '#' => occupied, '.' => floor)

state = [[seat_parser[char] for char in line] for line in eachline("input.txt")]
stateRows = length(state)
stateCols = length(state[1])
state = [row[colnum] for row in state, colnum in 1:stateCols]
prev_state = nothing

search_ranges = flatten([
  # Straights
  (zip(repeated(row), 1:stateCols) for row in 1:stateRows)
  (zip(1:stateRows, repeated(col)) for col in 1:stateCols)
  (zip(repeated(row), stateCols:-1:1) for row in 1:stateRows)
  (zip(stateRows:-1:1, repeated(col)) for col in 1:stateCols)
  # Diagonals
  (zip(row:stateRows, 1:stateCols) for row in 1:stateRows)
  (zip(1:stateRows, col:stateCols) for col in 2:stateCols)
  (zip(row:stateRows, stateCols:-1:1) for row in 1:stateRows)
  (zip(stateRows:-1:1, col:stateCols) for col in 2:stateCols)
  (zip(row:-1:1, 1:stateCols) for row in 1:stateRows)
  (zip(1:stateRows, col:-1:1) for col in 1:stateCols-1)
  (zip(row:-1:1, stateCols:-1:1) for row in 1:stateRows)
  (zip(stateRows:-1:1, col:-1:1) for col in 1:stateCols-1)
])

while prev_state != state
  occupied_seats = (state .== occupied)
  occupied_count = zeros(size(state))
  for range in search_ranges
    see_occupied = false
    for (row, col) in range
      if see_occupied
        occupied_count[row, col] += 1
      end
      ind_status = state[row, col]
      if ind_status == occupied
        see_occupied = true
      elseif ind_status == empty
        see_occupied = false
      end
    end
  end
  global prev_state = copy(state)
  global state[findall((occupied_count .== 0) .& (state .== empty))] .= occupied
  global state[findall((occupied_count .>= 5) .& occupied_seats)] .= empty
end
println(sum(state .== occupied))
