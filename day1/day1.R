library(data.table)
## Example input
dt = fread("day1/prob1.txt")
res = dt[, sum(V1), by = rleid(is.na(V1))
         ][!is.na(V1), .(calories = V1, elf = rleid(rleid))]

res[which.max(calories)] ## part 1
res[order(-calories)[1:3], sum(calories)] ## part 2

## Actual prompt
dt_q1 = fread("day1/input.txt")
res_q1 = dt_q1[, sum(V1), by = rleid(is.na(V1))
               ][!is.na(V1), .(calories = V1, elf = rleid(rleid))]

res_q1[which.max(calories)]

## part 2 of the prompt - get top 3 elves and the total calories
res_q1[order(-calories)[1:3], sum(calories)]
