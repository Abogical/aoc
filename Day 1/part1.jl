sorted_arr = sort(parse.(Int64, readlines(open("input.txt"))));

smaller_ind = 1;
larger_ind = size(sorted_arr)[1];
while smaller_ind < larger_ind
  smaller = sorted_arr[smaller_ind];
  larger = sorted_arr[larger_ind];
  res = smaller + larger;
  if res > 2020
    global larger_ind -= 1;
  elseif res < 2020
    global smaller_ind += 1;
  else
    print(smaller*larger);
    break
  end
end
