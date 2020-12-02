print(sum(map(function (line)
  letter = line[3][1];
  password = line[4];
  return parse(Int64, line[1]) <= sum([p == letter ? 1 : 0 for p in password]) <= parse(Int64, line[2]) ? 1 : 0;
end, match.(r"(\d+)-(\d+) (\w): (.*)", readlines(open("input.txt"))))))
