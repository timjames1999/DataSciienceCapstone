# Install and load required libraries
if (!require("quanteda")) install.packages("quanteda")

library(quanteda)

# Read text from the file
text_file_path <- "C:/Users/tobin/Documents/GitHub/Capstone/sample.txt"
text <- tolower(readLines(text_file_path, warn = FALSE))

# Create a corpus
corpus <- corpus(text)

# Tokenize the corpus
tokens <- tokens(corpus, what = "word", remove_punct = TRUE)

# Generate 3-grams
ngrams <- tokens_ngrams(tokens, n = 3, concatenator = " ")

# Convert to a data.frame
ngrams_df <- data.frame(
  ngram = as.character(ngrams),
  stringsAsFactors = FALSE
)

# Split the ngram column into separate words
ngrams_split <- strsplit(ngrams_df$ngram, " ")

# Create a data.frame with three columns
ngrams_df_split <- data.frame(
  word1 = sapply(ngrams_split, "[[", 1),
  word2 = sapply(ngrams_split, "[[", 2),
  word3 = sapply(ngrams_split, "[[", 3),
  stringsAsFactors = FALSE
)

# Print or save the result
#print(ngrams_df_split)
write.csv(ngrams_df_split, "C:/Users/tobin/Documents/GitHub/Capstone/sample_3_columns.csv", row.names = FALSE)
