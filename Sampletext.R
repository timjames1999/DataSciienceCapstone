# Read and sample lines from preprocessed files
sample_preprocessed_files <- c(
  "C:/Users/tobin/Documents/GitHub/Capstone/sample_preprocessed_1.txt",
  "C:/Users/tobin/Documents/GitHub/Capstone/sample_preprocessed_2.txt",
  "C:/Users/tobin/Documents/GitHub/Capstone/sample_preprocessed_3.txt"
)

sample_percent <- 0.05

# Function to sample lines from a file
sample_lines <- function(file_path, percent) {
  all_lines <- readLines(file_path, warn = FALSE)
  sample_size <- round(length(all_lines) * percent)
  sampled_lines <- sample(all_lines, sample_size)
  return(sampled_lines)
}

# Combine sampled lines from all files
sampled_text <- lapply(sample_preprocessed_files, function(file) {
  sample_lines(file, sample_percent)
})

# Flatten the list of lines into a single character vector
sampled_text <- unlist(sampled_text)

# Write sampled text to a file
writeLines(sampled_text, "sample.txt")
