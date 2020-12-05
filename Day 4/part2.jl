function reset_keys()
  global keyval = Dict{String, Union{String, Nothing}}((key, nothing) for key in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]);
end
reset_keys();

number_range = (min, max) -> (value) -> min <= parse(Int16, value) <= max;

validators = Dict("byr" => number_range(1920, 2002),
                  "iyr" => number_range(2010, 2020),
                  "eyr" => number_range(2020, 2030),
                  "hgt" => function (value)
                    m = match(r"^(\d+)(cm|in)$", value)
                    return m != nothing && (m[2] == "cm" ? number_range(150, 193) :
                      number_range(59, 76))(m[1]);
                  end,
                  "hcl" => (value) -> occursin(r"^#([\da-f]{6})$", value),
                  "ecl" => (value) -> any(["amb" "blu" "brn" "gry" "grn" "hzl" "oth"] .== value),
                  "pid" => (value) -> occursin(r"^\d{9}$", value)
                );

valid = 0;

function passport_filled()
  if all(value != nothing && validators[key](value) for (key, value) in keyval)
    global valid += 1
  end
end

for line in eachline(open("input.txt"))
  if isempty(line)
    passport_filled()
    reset_keys()
  else
    for m in eachmatch(r"([^\s:]+):(\S+)", line)
      key = m[1]
      if key != "cid"
        keyval[key] = m[2]
      end
    end
  end
end

passport_filled()

println(valid)
