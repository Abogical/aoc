function reset_keys()
  global keys = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]);
end
reset_keys();

valid = 0;

function passport_filled()
  if isempty(keys)
    global valid += 1
  end
end

for line in eachline(open("input.txt"))
  if isempty(line)
    passport_filled()
    reset_keys()
  else
    for m in eachmatch(r"([^\s:]+):(\S+)", line)
      delete!(keys, m[1])
    end
  end
end

passport_filled()

println(valid)
