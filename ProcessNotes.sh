#!/usr/bin/python3
# Create flash cards csv from notes for import to anki and point out things to
# review (?) and HW items (HW) before creating flash cards
import re, sys, csv, datetime

fileName = ""

try:
  fileName = sys.argv[1]
except IndexError:
  print("No file provided, using Notes.md")
  fileName = "Notes.md"

with open(fileName, 'r', encoding="utf-8") as file:
    lines_list = file.readlines()

hwList = []

for line in lines_list:
    #Check for (?), dont make flashcards if these exist
    n = re.match(r'.*(\(HW\)).*' , line)
    m = re.match(r'.*\~\~(\(HW\))\~\~.*' , line)
    if (m != None): #skip hw if crossed out
        pass
    elif (n != None):
        hwList.append(line)
if len(hwList) != 0:
    print("Homework: ")
    for item in hwList:
        print (item)
else:
    print("No Homework.")

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
    print("No questions to resolve.")
    today = datetime.date.today()
    saveName = 'Flashcards/'+ str(today) +'.csv'
    with open(saveName, 'w', newline='') as csvfile:
      writer = csv.writer(csvfile, delimiter='|',quotechar='|')
      for line in lines_list:
        #Pull out bolded terms and their definitions from the file
        m = re.match(r'\s*\**.*\*\*(.*)\*\*\s*\-\s*(.*)\s' , line)
        if m != None:
            writer.writerow([m.group(1),m.group(2)])
            #print(m.groups())

print("Done")
