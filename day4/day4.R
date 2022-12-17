## day 4
writeLines("2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8", "day4/example.txt")

exampleInput = fread("day4/example.txt", header = F, col.names = c("elf1", "elf2"))
exampleInput[, c("elf1_min", "elf1_max") := tstrsplit(elf1, '-')]
exampleInput[, c("elf2_min", "elf2_max") := tstrsplit(elf2, "-")]

exampleInput[(elf1_min <= elf2_min & elf1_max >= elf2_max) |
               (elf2_min <= elf1_min & elf2_max >= elf1_max)]

## Part 1
elves = fread("day4/input.txt", header = F, col.names = c("elf1", "elf2"))
elves[, c("elf1_min", "elf1_max") := tstrsplit(elf1, '-')]
elves[, c("elf2_min", "elf2_max") := tstrsplit(elf2, "-")]

trgCols = grep("_", names(elves), value = TRUE)
elves[, (trgCols) := lapply(.SD, as.integer), .SDcols = trgCols]

elves[(elf1_min <= elf2_min & elf1_max >= elf2_max) |
               (elf2_min <= elf1_min & elf2_max >= elf1_max)]

## probably more straight forward ways of figuring this out
elves[between(elf1_min,elf2_min, elf2_max) |
        between(elf1_max, elf2_min, elf2_max) |
        between(elf2_min, elf1_min, elf1_max) |
        between(elf2_max, elf1_min, elf1_max)]

