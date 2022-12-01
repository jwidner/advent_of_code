function max(x, y) {
    return x > y ? x : y
}
NF == 1 { current = current + $1 }
NF == 0 { max_calories = max(max_calories, current)
        current = 0
    }
END { 
    max_calories = max(max_calories, current)
    print max_calories
}
