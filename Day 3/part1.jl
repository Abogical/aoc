println(count(line[((lineNo-1)*3)%length(line)+1] == '#' for (lineNo, line) in enumerate(readlines(open("input.txt")))))
