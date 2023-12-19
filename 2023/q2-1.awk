#!/usr/bin/env awk -f
BEGIN {
    RED_MAX = 12
    GREEN_MAX = 13
    BLUE_MAX = 14
}
{
    # Store game index and destroy prefix of $0
    game_idx = $2
    gsub(/[^0-9]/, "", game_idx)
    gsub(/^Game [0-9]+:/, "")
    # Process colors a game at a time
    split($0, games, ";")
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
        if (red > RED_MAX || blue > BLUE_MAX || green > GREEN_MAX) {
            next  # skip invalid game
        }
    }
    total += game_idx
}
END { print total }
