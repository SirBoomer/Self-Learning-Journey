import sys
from exercise3 import analyse_file
from exercise4 import top_words
filename=sys.argv[1]
n=int(sys.argv[2])
counts=analyse_file(filename)
len(sys.argv)<3

