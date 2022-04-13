import std / [strutils, tables, algorithm, unicode ]
import watermelon





# A E S T E T H I C


proc findNext*(currentNode: string, searchTerm : string, next : int):tuple[pos1,pos2:int] =
  var next = next
  var pos1 : int
  var data = tablex[currentNode].data[next  .. ^1]
  if searchTerm == searchTerm.toLowerAscii():
    if data.toLowerAscii.find(searchTerm) == -1:
      data = tablex[currentNode].data
      next = 0
  else:
    if data.find(searchTerm) == -1:
      data = tablex[currentNode].data
      next = 0
  if searchTerm == searchTerm.toLowerAscii():
    pos1 = data.toLowerAscii.find(searchTerm) + next
  else:
    pos1 = data.find(searchTerm) + next
  var pos2 = pos1 + searchTerm.runelen()
  return (pos1, pos2)



proc replaceAll*(currentNode: string, searchTerm : string,replacer : string)=
  var data : string
  var rex : string
  if currentNode.len > 0:
    if searchTerm == searchTerm.toLowerAscii():
      data = tablex[currentNode].data.toLowerAscii()
      rex = data.replace(searchTerm,replacer)
    else:
      data = tablex[currentNode].data
      rex = data.replace(searchTerm,replacer)
    tablex[currentNode].data = rex


# A E S T E T H I C

proc orderAZ*(temp : seq[string]):seq[string] = #change
  var temp = temp
  var tupler2 : seq[tuple[hello,world :string]]
  var temp2 : seq[string]
  for i in temp:
    temp2.add(tablex[i].title.toLowerAscii)
  for i,v in temp:
    tupler2.add((temp2[i],temp[i])) 
  tupler2 = tupler2.sortedByIt(it.hello) #ty rika-sama <3
  var temp4 : seq[string]
  for i in tupler2:
    temp4.add(i[1])
  return temp4



proc orderLE*(temp : seq[string]):seq[string] =
  var temp = temp
  var tupler2 : seq[tuple[hello,world :string]]
  var temp2 : seq[string]
  for i in temp:
    temp2.add(tablex[i].ledit)
  for i,v in temp:
    tupler2.add((temp2[i],temp[i])) #v?
  tupler2 = tupler2.sortedByIt(it.hello)    #ty rika-sama <3
  tupler2.reverse()
  var temp4 : seq[string]
  for i in tupler2:
    temp4.add(i[1])
  return temp4




