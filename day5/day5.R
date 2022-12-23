library(stringi)
library(Rcpp)
#day 5
writeLines(
"    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2", "day5/example.txt")

exampleInput = readLines("day5/input.txt")

indexWithWhiteSpace = which(!nzchar(exampleInput))

originalCols = head(exampleInput, indexWithWhiteSpace - 2)
colWidth = 3L
nCols = floor(nchar(originalCols[1L]) / colWidth)

cols = replicate(nCols, list(), simplify = "list")

for (row in rev(originalCols)) {
  for (col in seq.int(nCols)) {
    startChar = 1 + colWidth * (col - 1) + 1 * (col - 1)
    endChar = colWidth * col + 1 * (col - 1)
    cellVal = substring(row, startChar, endChar)
    if (nzchar(trimws(cellVal))) {
      cols[[col]] = append(cols[[col]], cellVal)
    }
  }
}

cols_start = lapply(cols, unlist)

moves = tail(exampleInput, -indexWithWhiteSpace)
moves = stri_extract_all_regex(moves,"\\(?[0-9]+\\)?")

for (move in moves) {
  move = as.integer(move)
  how_many = move[1]
  from_col = move[2]
  to_col = move[3]
  
  cols_start[[to_col]] = append(cols_start[[to_col]], (tail(cols_start[[from_col]], how_many))) ## part 2
  ##cols_start[[to_col]] = append(cols_start[[to_col]], rev(tail(cols_start[[from_col]], how_many))) ## part 1
  cols_start[[from_col]] = head(cols_start[[from_col]], -how_many)
}
unlist(lapply(cols_start, tail, 1))
