from exercise3 import analyse_file
def top_words(counts,n):
    pairs=list(counts.items())
    pairs=sorted(pairs,key=lambda pair: pair[1], reverse=True)
    term=pairs[:n]
    return term 
counts= analyse_file("sample.txt")
print(top_words(counts, 5))