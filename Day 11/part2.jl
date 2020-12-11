using Base.Iterators

@enum SeatStatus empty occupied floor
seat_parser = Dict('L' => empty, '#' => occupied, '.' => floor)

state = [[seat_parser[char] for char in line] for line in eachline("input.txt")]
stateRows = length(state)
stateCols = length(state[1])
state = [row[colnum] for row in state, colnum in 1:stateCols]
prev_state = nothing

while prev_state != state
  occupied_seats = (state .== occupied)
  occupied_count = map(product(1:stateRows, 1:stateCols)) do (row, col)
    sum(map(flatten([
      (CartesianIndices(range) for range in [
        (row+1:stateRows, col)
        (row, col+1:stateCols)
      ]), ((CartesianIndex((row, col)) for (row, col) in range) for range in [
        zip(row-1:-1:1, repeated(col))
        zip(repeated(row), col-1:-1:1)
        zip(row+1:stateRows, col+1:stateCols)
        zip(row-1:-1:1, col+1:stateCols)
        zip(row+1:stateRows, col-1:-1:1)
        zip(row-1:-1:1, col-1:-1:1)
      ])
    ])) do range
      for ind in range
        status = state[ind]
        if status == occupied
          return true
        elseif status == empty
          return false
        end
      end
      false
    end)
  end
  global prev_state = copy(state)
  global state[findall((occupied_count .== 0) .& (state .== empty))] .= occupied
  global state[findall((occupied_count .>= 5) .& occupied_seats)] .= empty
end
println(sum(state .== occupied))
