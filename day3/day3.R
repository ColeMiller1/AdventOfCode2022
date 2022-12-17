#day 3 
writeLines("vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw", "day3/example.txt")

exampleData = readLines("day3/example.txt")

splitAndIntersect = function(rucksack) {
  nHalf = nchar(rucksack) / 2L
  
  rucksackLetters = strsplit(rucksack, "")[[1L]]
  Reduce(intersect,
         split(rucksackLetters,
               gl(2L, nHalf)))
}

res = vapply(exampleData, splitAndIntersect, "a", USE.NAMES = FALSE)
sum(match(tolower(res), letters) + 26 * (res %in% LETTERS))

## part 1
inputData = readLines("day3/input.txt")
res = vapply(inputData, splitAndIntersect, "a", USE.NAMES = FALSE)
sum(match(tolower(res), letters) + 26 * (res %in% LETTERS))

## Part 2
intersectThreeVectors = function(threeSacks) {
  Reduce(intersect,
         lapply(threeSacks,
                function(sack) strsplit(sack,"")[[1]]))
}

res = lapply(split(exampleData, rep(1:(length(exampleData)/3), each = 3L)),
       intersectThreeVectors)
sum(match(tolower(res), letters) + 26 * (res %in% LETTERS))
      
res = lapply(split(inputData, rep(1:(length(inputData)/3), each = 3L)),
             intersectThreeVectors)
sum(match(tolower(res), letters) + 26 * (res %in% LETTERS))
