println(
  prod(
    sum(
      (
        collect(
          line[
            [((lineNo-1)*n)%length(line) + 1 for n in [1,3,5,7]]
          ] *
          (lineNo%2 == 1 ? line[((lineNo-1)÷2)%length(line) + 1] : '.')
        ) .== '#'
      ) for (lineNo, line) in enumerate(readlines(open("input.txt")))
    )
  )
)
