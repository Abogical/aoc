print(sum(map(function (line)
  letter = line[3][1];
  password = line[4];
  return (password[parse(Int64, line[1])] == letter) ⊻ (password[parse(Int64, line[2])] == letter) ? 1 : 0;
end, match.(r"(\d+)-(\d+) (\w): (.*)", readlines(open("input.txt"))))))
