#Load required libraries
library(dplyr)
library(ggplot2)

#Function to perform EDA on a single file
perform_eda <- function(file_path) {
  #Read the text file
  data <- readLines(file_path, warn = FALSE)
  
  #Basic summary
  cat("Summary for file:", file_path, "\n")
  
  #Word count
  words <- unlist(strsplit(data, " "))
  cat("Word count:", length(words), "\n")
  
  #Character count
  cat("Character count:", sum(nchar(data)), "\n")
  
  #Line count
  cat("Line count:", length(data), "\n")
  
  #Minimum, maximum, and mean words per line
  words_per_line <- sapply(strsplit(data, " "), length)
  cat("Minimum words per line:", min(words_per_line), "\n")
  cat("Maximum words per line:", max(words_per_line), "\n")
  cat("Mean words per line:", mean(words_per_line), "\n")
  
  #File size
  cat("File size (in bytes):", file.info(file_path)$size, "\n")
  
  #Create a basic data table
  data_table <- data.frame(Word = words)
  
  #Display the first few rows of the data table
  cat("\nData Table (first few rows):\n")
  print(head(data_table))
  
  #Word frequency histogram (top 25 words)
  word_freq <- table(words)
  word_freq_df <- data.frame(Word = names(word_freq), Frequency = as.numeric(word_freq))
  top_25_words <- head(word_freq_df[order(word_freq_df$Frequency, decreasing = TRUE), ], 25)
  
  plotx<-ggplot(top_25_words, aes(x = reorder(Word, -Frequency), y = Frequency)) +
    geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
    labs(title = "Top 25 Word Frequency Histogram") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability
  print(plotx)
  
  #Words per line histogram
  plotx2<-ggplot(data.frame(WordsPerLine = words_per_line), aes(x = WordsPerLine)) +
    geom_histogram(binwidth = 1, fill = "green", alpha = 0.7) +
    labs(title = "Words per Line Histogram") +
    theme_minimal()
  print(plotx2)
}

#List of file paths
file_paths <- c("C:/Users/tobin/Documents/GitHub/Capstone/blogs.txt", "C:/Users/tobin/Documents/GitHub/Capstone/news.txt", "C:/Users/tobin/Documents/GitHub/Capstone/twitter.txt")

#Perform EDA for each file
for (file_path in file_paths) {
  perform_eda(file_path)
  cat("\n\n")
}
