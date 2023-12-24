# Create n-gram

library(quanteda)
library(dplyr)

setwd("~/GitHub/Capstone")

# Read sample text and build corpus
sample <- readLines('sample.txt', encoding = 'UTF-8', skipNul = TRUE)
sample <- tolower(sample)
corpus <- corpus(sample)
rm(sample)

# N-gram tokenization & document-term matrix construction
dfm_ngram <- function(n) {
  tokens_ngram <- tokens(corpus, remove_numbers = TRUE, remove_punct = TRUE, ngrams = n)
  dfm_ngram <- dfm(tokens_ngram)
}

# Build sorted frequency table (frequency descending)
df_ngram <- function(n) {
  matrix_ngram <- function(n) {as.matrix(colSums(sort(dfm_ngram(n))))}
  df_ngram <- data.frame(word = rownames(matrix_ngram(n)), freq = matrix_ngram(n)[, 1], stringsAsFactors = FALSE)
}

# Modify the frequency tables.
# Split the terms in the frequency table, e.g., first word + second word for 2-gram, first two words + third word for 3-gram... but keep the original order of the data frame

split_ngram <- function(n) {strsplit(df_ngram(n)$word, split = ' ')}

# 1-gram
df_1gram <- df_ngram(1)
df_1gram <- df_1gram %>% filter(freq >= 1)
write.csv(df_1gram, 'unigram.csv', row.names = FALSE)
unigram <- read.csv('unigram.csv', stringsAsFactors = FALSE)
saveRDS(unigram, 'unigram.RData')

# 2-gram 
#df_2gram <- df_ngram(2)
#split_2gram <- split_ngram(2)
#df_2gram <- df_2gram %>% mutate(first = sapply(split_2gram, '[[', 1), last = sapply(split_2gram, '[[', 2)) %>% 
#  select(first, last, freq) %>% filter(freq >= 1)
#write.csv(df_2gram, 'bigram.csv', row.names = FALSE)
#bigram <- read.csv('bigram.csv', stringsAsFactors = FALSE)
#saveRDS(bigram, 'bigram.RData')

# 3-gram 
df_3gram <- df_ngram(3)
split_3gram <- split_ngram(3)
df_3gram <- df_3gram %>% 
  mutate(first = paste(sapply(split_3gram, '[[', 1), sapply(split_3gram, '[[', 2), sep = ' '), 
         last = sapply(split_3gram, '[[', 3)) %>% select(first, last, freq) %>% filter(freq >= 1)
write.csv(df_3gram, 'trigram.csv', row.names = FALSE)
trigram <- read.csv('trigram.csv', stringsAsFactors = FALSE)
saveRDS(trigram, 'trigram.RData') 

# 4-gram 
#df_4gram <- df_ngram(4)
#split_4gram <- split_ngram(4)
#df_4gram <- df_4gram %>% 
#  mutate(first = paste(sapply(split_4gram, '[[', 1), sapply(split_4gram, '[[', 2), sapply(split_4gram, '[[', 3), sep = ' '), 
#         last = sapply(split_4gram, '[[', 4)) %>% select(first, last, freq) %>% filter(freq >= 1)
#write.csv(df_4gram, 'quadrigram.csv', row.names = FALSE)
#quadrigram <- read.csv('quadrigram.csv', stringsAsFactors = FALSE)
#saveRDS(quadrigram, 'quadrigram.RData')
