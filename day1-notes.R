# 1. Basic Math Operations

2 - 5
10*5

sin(3)
cos(-2)

2^3

# 2. Variable Assignment 

a <- sin(3*pi)
b <- a / 5
b <- 100

a^2

# a 11
# b 15
# comments comments comments

# Exercise 1 - Pythag Theorem - Triangle
a <- 11
b <- 15
c <- sqrt(a^2 + b^2)

# variable naming conventions

apples <- 5

green_bananas <- 5  # snake-case
greenBananas <- 5   # camel case
green.bananas <- 5  # bad style case

green-bananas  # minus not allowed
green<-500     # no spaces needed
bananas <- 1   
green-bananas  # now it works

# character class 
greeting <- "Hello Leipzig"
greeting <- 'hello leipzig'

class(greeting)
class(bananas)

my_complex_number <- 4 + 5i
class(my_complex_number)

# 3. LOGICALS

class(TRUE)
FALSE

# equality
green_bananas == green
# greater than less than
green_bananas > green
green_bananas < green
# not equal !=
green_bananas != green

# NAs
TRUE == NA
TRUE == TRUE

my_blood_pressure <- NA

my_blood_pressure <- 200
  
my_blood_pressure > 180

# AND &
# OR |

my_blood_pressure > 100 & my_blood_pressure < 150

my_blood_pressure > 100 | my_blood_pressure < 150

my_blood_pressure < 150 | my_blood_pressure > 100

bret_blood_pressure <- NA

(my_blood_pressure > 150) | (bret_blood_pressure > 150)

my_blood_pressure > 150 & bret_blood_pressure > 150

# NA in logical operations
TRUE | NA
TRUE | (TRUE/FALSE)

FALSE | TRUE  # TRUE
FALSE | FALSE # FALSE
FALSE | NA    #
FALSE & NA

# Order of evaluations
(my_blood_pressure > 150 & my_blood_pressure < 250)  | (bret_blood_pressure > 150)
(TRUE & TRUE) | NA
TRUE | NA
TRUE

# IF STATEMENTS
# - within parentheses evaluated as TRUE/FALSE/NA

if (my_blood_pressure > 150) {
  print("your blood pressure is really high man")
}
# this is the same thing for R
if (TRUE) {
  print("your blood pressure is really high man")
}

if (my_blood_pressure < 150){
  print("your blood pressure is really high man")
}
if (FALSE){
  print("your blood pressure is really high man")
}

my_blood_pressure > 150

TRUE <- 5
T <- FALSE  # avoid overwriting T!

if (T) {
  print("this is true")
}

# Numeric vs Logicals
5 == TRUE
1 == TRUE
0 == FALSE
5 == FALSE

if (my_blood_pressure < 150) {
  print("your blood pressure is really high man")
} else {
  print("your blood pressure IS NOT really high")
}

if (FALSE) {
  print("your blood pressure is really high man")
} else {
  print("your blood pressure IS NOT really high")
}

my_blood_pressure <- 100
if (my_blood_pressure > 150) {
  print("HIGH")
} else if (my_blood_pressure < 50) {
  print("LOW")
} else {
  print("NORMAL")
}

# Exercise 2 - Both, At Least One, None

# oct <- 10
# nov <- 16
# dec <- 70
# number^2 > 100
# sin(number) > 0
# BOTH -> print("BOTH TRUE")
# OR print("At least one true")
# NEITHER print("none true")

#& AND
# | OR

# My Solution
oct <- 10
nov <- 16
dec <- 70

month <- dec

if(month^2 > 100 & sin(month) > 0) {
  print("BOTH TRUE"),
} else if(month^2 > 100 | sin(month) > 0) {
  print("AT LEAST ONE TRUE")
} else {
  print("NONE IS TRUE")
}

# Reversing Order changes results
month <- dec
if (month^2 > 100 | sin(month) > 0) {
  print("AT LEAST ONE TRUE")
} else if(month^2 > 100 & sin(month) > 0) {
  print("BOTH TRUE")
} else {
  print("NONE IS TRUE")
}

# VECTORS

if(10 > 5 & 5 > NA){
  print("what happens")
}

my_vector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

breakfast <- c("yogurt", "granola", "blueberries")

c(breakfast, "egg")

mixed_vector <- c(1, 10, 40, "granola", "toast")
class(mixed_vector)

scores <- c(10,20,700,30,40,50,60,77,88,99,100,110,120, 150, 151023, 120309123, 1230912)
length(scores)

scores[5]
scores[10]
scores[1]

scores[1:6]

length(scores)

scores[9:length(scores)]
scores[9:16]

20 > 15

scores > 15
length(scores > 15)

scores[scores > 15]
length(scores[scores>15])

months <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
months

scores2 <- c(6, 8, 3, 5, 6, 0, 10, 9, 7, 10, 55, 0)

high_scores_index <- scores2 > 6

scores2[high_scores_index]
months[high_scores_index]

scores <- c(10,20,700,30,40,50,60,77,88,99,100,110,120,150,151023,120151023, 1203309123, 1230912)
scores3 <- c(10,20,700,30,40,50,60,77,88,99,100,110)

length(scores3)
scores[high_scores_index]
scores3[high_scores_index]


1:10

for (m in months) {
  print(m)
}

for (i in 1:10) {
  print(months[i])
  print(scores2[i])
}


for (i in 1:12) {
  if(scores[i]^2 > 100 & sin(scores[i]) > 0) {
    print("BOTH TRUE")
  } else if(scores[i]^2 > 100 | sin(scores[i]) > 0) {
    print("AT LEAST ONE TRUE")
  } else {
    print("NONE IS TRUE")
  }
}

for (i in 1:12) {
  print(i)
}

# TASK: 
# find the squares of all numbers from 1 to 20 and print

for (n in 1:20){
  print(n^2)
}

(1:20)^2

# while loop
x <- 0
while (x < 50) {
  print(x)
  x <- x + 1
}



for (i in 1:10) {
  
}

# TASK
# write a while loop
# if x is 40
# decrease x by one until x is 0

x <- 40
while (x > 0) {
  print(x)
  x <- x - 1
  print("hello peeps")
}

# square-brackets [] - indexing
items <- c("dog", "pencil", "house")
items[1]
items[1:2]

# parentheses () - if, for, while, functions
# order of operations

1 + 2 * 8 
(1+2) * 8

if (TRUE) { print("Definitely") }

# Curly braces {} - blocks of code after if, for, while

# comparisons <  > 

if (TRUE) 
  
print("definitely")
print("as well")


while (j > 5) {
  j <- j + 1
}

j <- 100
for (j in 1:10) {
  print("wazzup")
}
print(j)

for (k in 1:10) {
  print("wazzup")
}
print(k)

k <- 1
print("wazzup")
k <- 2
print("wazzup")
#...
k <- 10
print("wazzup")

print(k)

for (k in c(1,2,3,4,5,6,7,8,9,10)) {
  print("wazzup")
}
print(k)

for (k in c("fizz", "buzz", "bar")) {
  print("wazzup")
}
print(k)

j <- 0

while (j < 5) {
  print("oh no")
}

# HIT STOP BUTTON TO STOP INFINITE LOOP

# using breaks in a loop
z <- 0
while (TRUE) {
  print(z)
  print("first line")
  print("second line")
  z <- z + 1
  if (z == 3) {
    break
  }
  print("third line")
}

# Keyboard Shortcuts
# ctrl + enter (send to console)
# ctrl + c (copy)
# ctrl + v (paste)
# ctrl + l (clear R console)
# ctrl + a (select all)


