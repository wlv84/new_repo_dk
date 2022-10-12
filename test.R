library("tidyverse")
library("openxlsx")

# Requests:
# 1. Create df of 10 columns, x1-x10, and populate with random integers of 1-10
# 2. Create 10 df's by summarizing for counts from each column using tidy eval
# 3. Output resulting df's into excel, one df per tab

# create the original df
set.seed(1)
vars <- paste0("x", 1:10)
A <- sample(1:10, 1000, TRUE)
A <- matrix(A, 100, 10) %>%
  as.data.frame() %>%
  rename_with(~vars)
names(A)

# create 10 summary df's by each column
col_freq <- function(vars) {
  x <- A %>%
    group_by(!!!rlang::syms(vars)) %>%
    summarize(freq = n(), .groups = "drop")
}
a <- map(vars, col_freq)

# Output with a note
names(a) <- vars
write.xlsx(a, paste("/home/test", "test.xlsx", sep = "/"))
print("Mission Completed!!!")
