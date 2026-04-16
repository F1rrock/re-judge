# A2

x <- scan(quiet = TRUE)

n <- x[1]
a <- x[2:(n + 1)]
k <- x[n + 2]
l <- x[n + 3]

cat(sum(a) - sum(a[k:l]))
