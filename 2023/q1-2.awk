#!/usr/bin/env awk -f
function rev(input) {
    reversed = ""
    for (i = length(input); i >= 1; i--) {
        reversed = reversed substr(input, i, 1)
    }
    return reversed
}

function replace_first_number(input, nums) {
    first_num_idx = 0
    first_num = 0
    for (n in nums) {
        n_idx = index(input, nums[n])
        n_found = n_idx > 0
        if (n_found && (first_num_idx == 0 || n_idx < first_num_idx)) {
            first_num_idx = n_idx
            first_num = n
        }
    }
    if (first_num_idx > 0) {
        sub(nums[first_num], first_num, input)
    }
    return input
}

function replace_last_number(input, nums) {
    for (n in nums)  rev_nums[n] = rev(nums[n])
    return rev(replace_first_number(rev(input), rev_nums))
}

BEGIN {
    split("one/two/three/four/five/six/seven/eight/nine", nums, "/")
}
{
    $0 = replace_first_number($0, nums)
    $0 = replace_last_number($0, nums)
    first_idx = match($0, /[0-9]/)
    last_idx = match($0, /[0-9][^0-9]*$/)
    first = substr($0, first_idx, 1)
    last = substr($0, last_idx, 1)
    sum += 10*first + last
}
END { print sum }
