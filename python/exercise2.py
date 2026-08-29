def count_words(text):
    words=text.split()
    counts={}
    for i in words:
        if i not in counts:

            counts[i]=1
        else:
            counts[i]+=1
    return counts
if __name__ == "__main__":
    print(count_words("the cat the dog the bird"))