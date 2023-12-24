# Install and load the required libraries
if (!require("quanteda")) install.packages("quanteda")
if (!require("tm")) install.packages("tm")

# Load the library
library(quanteda)
library(tm)

# Function to preprocess a single text file
preprocess_file <- function(file_path) {
  # Read Data
  text <- tolower(readLines(file_path))
  
  # Additional preprocessing steps
  text <- gsub("/|@|//|$|:|:)|*|&|!|?|_|-|#|", " ", text)
  text <- removeNumbers(text)
  text <- tolower(text)
  text <- removePunctuation(text)
  
  # Load badwords from file
  badwords <- tolower(readLines("C:/Users/tobin/Documents/GitHub/Capstone/badwords.txt"))
  
  # Remove profanity
  text <- removeWords(text, badwords)
  
  text <- stripWhitespace(text)
  return(text)
}

# Set the paths to the source files
file_paths <- c(
  "C:/Users/tobin/Documents/GitHub/Capstone/blogs.txt",
  "C:/Users/tobin/Documents/GitHub/Capstone/news.txt",
  "C:/Users/tobin/Documents/GitHub/Capstone/twitter.txt"
)

# Create a list to store processed text
processed_texts <- list()

# Loop through each file and preprocess
for (file_path in file_paths) {
  processed_texts[[file_path]] <- preprocess_file(file_path)
}

# Save processed texts to separate files
for (i in seq_along(processed_texts)) {
  output_file <- paste0("C:/Users/tobin/Documents/GitHub/Capstone/sample_preprocessed_", i, ".txt")
  writeLines(processed_texts[[i]], con = output_file)
}