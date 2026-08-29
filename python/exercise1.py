def analyse(numbers):
    if len(numbers) ==0:
        print('Invalid Number')
    else:
        smallest=min(numbers)
        biggest=max(numbers)
        mean=sum(numbers)/len(numbers)
        count=0
        for i in numbers:
            count +=1
        return {'min':smallest, 'max': biggest, 'mean': mean, 'count': count}

print(analyse([4, 8, 15, 16, 23, 42]))
print(analyse([]))