import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from collections import Counter


text = "NLP enables computers to understand, interpret, and generate human language effectively."

# 1. Tokenization
tokens = word_tokenize(text)
print("1. Tokens:\n", tokens)

# 2. Stop Word Removal
stop_words = set(stopwords.words('english'))
filtered_tokens = [w for w in tokens if w.lower() not in stop_words and w.isalpha()]
print("\n2. After Stop Word Removal:\n", filtered_tokens)

# 3. Stemming
stemmer = PorterStemmer()
stemmed_words = [stemmer.stem(w) for w in filtered_tokens]
print("\n3. Stemmed Words:\n", stemmed_words)

# 4. Part of Speech Tagging
pos_tags = nltk.pos_tag(tokens)
print("\n4. POS Tags:\n", pos_tags)

# 5. Word Frequency Analysis
freq = Counter(filtered_tokens)
print("\n5. Word Frequency:")
for word, count in freq.most_common():
    print(f"  {word}: {count}")