def analyse(numbers):
    try:

        a=min(numbers)
        b=max(numbers)
        c=len(numbers)
        d=sum(numbers)/len(numbers)
        result = {'min': a ,'max': b, 'count': c, 'average': d}
    except ValueError:
        result = {'min' : None, 'max' : None, 'count' : None,  'Average': None}
    return result

print(analyse([4, 8, 15, 16, 23, 42]))
print(analyse([]))

def count_words(text):
    text=text.lower().split()
    text=text.strip(".,!?")
    return text

text = "the cat sat on the mat. The cat was fat!"
counts = count_words(text)
print(counts)