import std / [tables, times]

import watermelon
import realestate



proc counterGen*(cnt: int):int =
  counter = cnt + 1
  result = int(counter)

proc addChild*(parentid : string, title : string)=
  let now1 = now()
  var newChild = Thingy()
  newChild.id = base64encode(counterGen(counter))
  newChild.title = title
  newChild.parent = parentid
  newChild.ledit = now1.format("yyyy-MM-dd-HH-mm-ss")
  tablex[newChild.id] = newChild
  tablex[parentid].children.add(newChild.id)


proc removeChild*(childId : string)= 
  if tablex[childId].children.len() != 0:
    for i in tablex[childId].children:
      removeChild(i)
  tablex.del(childId)


proc cleanupChild*(childId : string)= 
  if childId == "root" or childId == "ninjaroot" or childId == "archroot":
    return
  else:
    var par = tablex[childId].parent
    tablex[par].children.delete(find(tablex[par].children, childId))



# A E S T E T H I C


type
 CopyMode* = enum
  none, singleCopyx, flatCopyx, deepCopyx, deepCutx


var copySingleNodeTitle* : string
var copySingleNodeData* : string
var copyContextNodesTitles* : seq[string]
var copyContextNodesData* : seq[string]
var copyParentId* : string
var currentCopyId* : string
var copyStatus* = none

var traceRoot : seq[string]


proc cleanCopyVars*() =
  copyStatus.reset
  copySingleNodeTitle.reset()
  copySingleNodeData.reset()
  copyContextNodesTitles.reset()
  copyContextNodesData.reset()
  copyParentId.reset()
  currentCopyId.reset()


proc singleCopy*(currentNode : string) = # MODDED
  copySingleNodeTitle = tablex[currentNode].title
  copySingleNodeData = tablex[currentNode].data
  currentCopyId = currentNode
  copyStatus = singleCopyx



proc flatCopy*(currentChildren: seq[string]) =
  for i in currentChildren:
    copyContextNodesTitles.add(tablex[i].title)
    copyContextNodesData.add(tablex[i].data)
  copyStatus = flatCopyx



proc deepCopy*(currentNode : string) =
  currentCopyId = currentNode
  copyParentId = tablex[currentNode].parent
  copySingleNodeTitle = tablex[currentNode].title
  copySingleNodeData = tablex[currentNode].data
  copyStatus = deepCopyx





proc trackBackToRoot(currentRootId : string, destinationPar : string) =
  traceRoot.add(destinationPar)
  if tablex[destinationPar].parent == currentRootId or  tablex[destinationPar].parent.len == 0 :
    return
  else: 
    trackBackToRoot(currentRootId, tablex[destinationPar].parent)



proc deepCut*(currentNode : string) =
    currentCopyId = currentNode
    copyStatus = deepCutx


proc deepPaste(parent : string, currentCopyId : string) = #The Crown Jewel
  var parent = parent
  var currentCopyId = currentCopyId
  for i,v in tablex[currentCopyId].children:
    addchild(parent, tablex[v].title)
    tablex[tablex[parent].children[i]].data = tablex[v].data
    if tablex[v].children.len() > 0:
      deepPaste(tablex[parent].children[i], v)



proc paste*(currentRootId: string, currentParentId : string):bool =
  if copyStatus == singleCopyx:
    addchild(currentParentId,copySingleNodeTitle)
    tablex[tablex[currentParentId].children[^1]].data = copySingleNodeData

  if copyStatus == flatCopyx:
    for i,v in copyContextNodesTitles:
      addchild(currentParentId,v)
      tablex[tablex[currentParentId].children[^1]].data = copyContextNodesData[i]

  if copyStatus == deepCopyx: #Do not ever touch
    addchild(currentRootId,copySingleNodeTitle) 
    var gitFakeId = tablex[tablex[currentRootId].children[^1]].id
    tablex[gitFakeId].data = copySingleNodeData
    deepPaste(gitFakeId, currentCopyId)
    cleanupChild(gitFakeId)
    tablex[currentParentId].children.add(gitFakeId)
    tablex[gitFakeId].parent = currentParentId

  if copyStatus == deepCutx:
    trackBackToRoot(currentRootId,currentParentId)
    if currentCopyId notin traceRoot or currentParentId == currentRootId:
      cleanupChild(currentCopyId)
      tablex[currentParentId].children.add(currentCopyId)
      tablex[currentCopyId].parent = currentParentId
      traceRoot.reset()
    else: 
      return false
    traceRoot.reset()
  return true


# A E S T E T H I C


proc toggleStark*(currentNode : string) =
  if currentNode.len() > 0:
    if stark notin tablex[currentNode].s:
      tablex[currentNode].s.incl(stark)
      starkSeq.add(currentNode)
    else:
      tablex[currentNode].s.excl(stark)
      starkSeq.delete(find(starkSeq,currentNode))



# A E S T E T H I C

proc getHeadCount*(currentNode : string):int =
  if tablex[currentNode].children.len() == 0:
    return 0
  else:
    var seq2check : seq[string]
    seq2check.add(currentNode)
    var k = 0
    var childnum = 0
    var nestingcounter = 1
    while nestingcounter > 0:
      for i in tablex[seq2check[k]].children:
        childnum = childnum + 1
        if tablex[i].children.len() > 0:
          seq2check.add(i)
          nestingcounter = nestingcounter + 1
      nestingcounter = nestingcounter - 1
      k = k + 1
    return childnum


proc getLE*(currentNode : string): string =
  let dt = parse(tablex[currentNode].ledit, "yyyy-MM-dd-HH-mm-ss")
  return dt.format("dd/MM/yyyy") & " at: " & dt.format("HH:mm")






