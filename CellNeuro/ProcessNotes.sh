#!/usr/bin/python3
#Create flash cards csv from notes for import to anki and point out things to review (?) before creating flash cards
import re, sys

fileName = ""

try:
  fileName = sys.argv[1]
except IndexError:
  print("No file provided, using Notes.md")
  fileName = "Notes.md"

with open(fileName, 'r', encoding="utf-8") as file:
    lines_list = file.readlines()

qlist = []

for line in lines_list:
    #Check for (?), dont make flashcards if these exist
    n = re.match(r'.*(\(\?\)).*' , line)
    if (n != None):
        qlist.append(line)

if len(qlist) != 0:
    print("Questions to resolve: ")
    for item in qlist:
        print (item)
else:
    for line in lines_list:
        #Pull out bolded terms and their definitions from the file
        m = re.match(r'\s*\**.*\*\*(.*)\*\*\s*\-\s*(.*)\s' , line)
        if m != None:
            print(m.groups())