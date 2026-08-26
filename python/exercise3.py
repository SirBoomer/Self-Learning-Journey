from exercise2 import count_words
def analyse_file(filename):
    with open(filename) as f:
        text=f.read()
    count=count_words(text)
    return count

print(analyse_file("sample.txt"))
