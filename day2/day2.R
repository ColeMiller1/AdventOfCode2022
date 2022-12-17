# Day 2
library(data.table)

movePoints = fread(
"move movePt
Rock  1
Paper 2
Scissors  3")

gameOutcomes = fread(
  "oppPt myPt myResult
  1 1 D
  1 2 W
  1 3 L
  2 1 L
  2 2 D
  2 3 W
  3 1 W
  3 2 L
  3 3 D")

resultPoints = fread(
  "result resultPoints
  D 3
  W 6
  L 0"
)

oppStrat = fread(
  "oppCode  oppMove
  A Rock
  B Paper
  C Scissors"
)

myStrat = fread(
  "myCode myMove
  X Rock
  Y Paper
  Z Scissors"
)

## Example prompt:

exampleDt = fread(
  "oppCode  myCode
  A Y
  B X
  C Z"
)

exampleDt[oppStrat, on = "oppCode", oppMove:=oppMove]
exampleDt[movePoints, on = .(oppMove = move), oppPt := movePt]

exampleDt[myStrat, on = "myCode", myMove:=myMove]
exampleDt[movePoints, on = .(myMove = move), myPt := movePt]

exampleDt[gameOutcomes, on = .(oppPt, myPt), myResult := myResult]
exampleDt[resultPoints, on = .(myResult = result), gamePoints := resultPoints]
exampleDt[, myTotalPts := myPt + gamePoints]

exampleDt[, sum(myTotalPts)]
exampleDt
## Part 1
inputDt = fread("day2/input.txt", header = F, col.names = c("oppCode", "myCode"))

inputDt[oppStrat, on = "oppCode", oppMove:=oppMove]
inputDt[movePoints, on = .(oppMove = move), oppPt := movePt]

inputDt[myStrat, on = "myCode", myMove:=myMove]
inputDt[movePoints, on = .(myMove = move), myPt := movePt]

inputDt[gameOutcomes, on = .(oppPt, myPt), myResult := myResult]
inputDt[resultPoints, on = .(myResult = result), gamePoints := resultPoints]
inputDt[, myTotalPts := myPt + gamePoints]

inputDt[, sum(myTotalPts)]

## Part II
exampleDt = fread(
  "oppCode  outcomeCode
  A Y
  B X
  C Z"
)

outcomeLu = fread(
  "outcomeCode result
  X L
  Y D
  Z W"
)
exampleDt[oppStrat, on = "oppCode", oppMove:=oppMove]
exampleDt[movePoints, on = .(oppMove = move), oppPt := movePt]

exampleDt[outcomeLu, on = .(outcomeCode), myResult := result]
exampleDt[resultPoints, on = .(myResult = result), resultPoints := resultPoints]

exampleDt[gameOutcomes, on = .(myResult = myResult,
                               oppPt = oppPt),
          myPt := myPt]

exampleDt

exampleDt[myStrat, on = "myCode", myMove:=myMove]
exampleDt[movePoints, on = .(myMove = move), myPt := movePt]

exampleDt[, myTotalPts := myPt + resultPoints]

exampleDt[, sum(myTotalPts)]

## Prompt 2
inputDt = fread("day2/input.txt", header = F, col.names = c("oppCode", "outcomeCode"))

inputDt[oppStrat, on = "oppCode", oppMove:=oppMove]
inputDt[movePoints, on = .(oppMove = move), oppPt := movePt]

inputDt[outcomeLu, on = .(outcomeCode), myResult := result]
inputDt[resultPoints, on = .(myResult = result), resultPoints := resultPoints]

inputDt[gameOutcomes, on = .(myResult = myResult,
                               oppPt = oppPt),
          myPt := myPt]

inputDt[, myTotalPts := myPt + resultPoints]

inputDt[, sum(myTotalPts)]
## Different method

mvPts = c("X" = 1, "Y" = 2, "Z" = 3)

pts = list("A X" = 3 + 1,
           "A Y" = 6 + 2,
           "A Z" = 0 + 3,
           "B X" = 0 + 1,
           "B Y" = 3 + 2,
           "B Z" = 6 + 3,
           "C X" = 6 + 1,
           "C Y" = 0 + 2,
           "C Z" = 3 + 3)
sum(unlist(pts[readLines("day2/input.txt")]))

