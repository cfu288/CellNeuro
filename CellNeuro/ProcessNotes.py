#Create flashcards and point out things to review
import re, sys

with open(sys.argv[1], 'r', encoding="utf-8") as file:
    lines_list = file.readlines()

for line in lines_list:
    #line = '      * **Process one** - (neurite) extends from ganglion to muscle (term used instead of axon/dendrite) '
    m = re.match(r'\s*\**.*\*\*(.*)\*\*\s*\-\s*(.*)\s' , line)
    if m != None:
        print(m.groups())
