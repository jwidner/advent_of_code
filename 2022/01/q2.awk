function update(value) {
    current = value
    for (i = 0; i < 3; i++) {
        if (current > top_three[i]) {
            temp = top_three[i]
            top_three[i] = current
            current = temp
        }
    }
}
NF == 1 { elf_total += $1 }
NF == 0 {
    update(elf_total)
    elf_total = 0
}
END {
    update(elf_total)
    print top_three[0]+top_three[1]+top_three[2]
}
