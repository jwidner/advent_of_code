#!/usr/bin/env awk -f
function max(a, b) {
    return a > b ? a : b
}

{
    # Destroy prefix of $0
    gsub(/^Game [0-9]+:/, "")
    # Process colors a game at a time
    split($0, games, ";")
    red_max = 0; blue_max = 0; green_max = 0
    for (game in games) {
        red = 0; blue = 0; green = 0
        split(games[game], colors, ",")
        for (color in colors) {
            match(colors[color], /[0-9]+/)
            color_num = substr(colors[color], RSTART, RLENGTH)
            match(colors[color], /[a-z]+/)
            color_word = substr(colors[color], RSTART, RLENGTH)
            if (color_word == "red")    red   += color_num
            if (color_word == "blue")   blue  += color_num
            if (color_word == "green")  green += color_num
        }
        red_max = max(red_max, red)
        blue_max = max(blue_max, blue)
        green_max = max(green_max, green)
    }
    total += red_max*blue_max*green_max
}
END { print total }
