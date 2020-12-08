@enum InstructionType nop acc jmp
struct Instruction
  instruction::InstructionType
  arg::Int32
end
allTypes = Dict("acc" => acc, "jmp" => jmp, "nop" => nop)
program = [Instruction(allTypes[m[1]], parse(Int32, m[2])) for m in match.(r"^(\S+) ([+-]\d+)", eachline("input.txt"))]

ran = Set{Int32}()
jmps = Set{Int32}()
nops = Set{Int32}()
line = 1
while line <= length(program) && !(line in ran)
  push!(ran, line)
  instruction = program[line]
  if instruction.instruction == jmp
    push!(jmps, line)
    global line += instruction.arg
  else
    if instruction.instruction == nop
      push!(nops, line)
    end
    global line += 1
  end
end

using Distributed

pmap(Iterators.flatten(((
  function (line)
    instruction = program[line]
    line == jmp ? Instruction(nop, instruction.arg) : instruction
  end for jmp in jmps),(
  function (line)
    instruction = program[line]
    line == nop ? Instruction(jmp, instruction.arg) : instruction
  end for nop in nops)))
) do programFn
  acc_reg = 0
  ran = Set{Int32}()
  line = 1
  while !(line in ran)
    push!(ran, line)
    instruction = programFn(line)
    if instruction.instruction == jmp
      line += instruction.arg
    else
      if instruction.instruction == acc
        acc_reg += instruction.arg
      end
      line += 1
    end
    if line > length(program)
      println(acc_reg)
      exit(0)
    end
  end
end

