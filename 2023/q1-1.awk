#!/usr/bin/env awk -f
{
    gsub(/[^0-9]/, "")
    first = substr($0, 1, 1)
    last = substr($0, length($0), 1)
    sum += 10*first + last
}
END { print sum }
