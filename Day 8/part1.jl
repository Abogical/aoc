@enum InstructionType nop acc jmp
struct Instruction
  instruction::InstructionType
  arg::Int32
end
allTypes = Dict("acc" => acc, "jmp" => jmp, "nop" => nop)
program = [Instruction(allTypes[m[1]], parse(Int32, m[2])) for m in match.(r"^(\S+) ([+-]\d+)", eachline("input.txt"))]

acc_reg = 0
ran = Set{Int32}()
line = 1
while line <= length(program) && !(line in ran)
  push!(ran, line)
  instruction = program[line]
  if instruction.instruction == jmp
    global line += instruction.arg
  else
    if instruction.instruction == acc
      global acc_reg += instruction.arg
    end
    global line += 1
  end
end

println(acc_reg)
