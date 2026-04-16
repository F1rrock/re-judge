# A1
x <- scan(file = "stdin", quiet = TRUE)

n <- x[1]
a <- x[2:(n + 1)]

ans <- c(a[seq(1, n, 2)], rev(a[seq(2, n, 2)]))

cat(ans)
