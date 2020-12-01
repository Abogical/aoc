sorted_arr = sort(parse.(Int64, readlines(open("input.txt"))));

arr_size = size(sorted_arr)[1]
for smaller_ind = 1:(arr_size-2)
  middle_ind = smaller_ind+1
  larger_ind = arr_size
  smaller = sorted_arr[smaller_ind]
  desired_res = 2020-smaller
  while middle_ind < larger_ind
    middle = sorted_arr[middle_ind];
    larger = sorted_arr[larger_ind];
    res = middle + larger;
    if res > desired_res
      larger_ind -= 1;
    elseif res < desired_res
      middle_ind += 1;
    else
      print(smaller*middle*larger);
      exit(0)
    end
  end
end
