import std / [os, sets, times, tables, algorithm, strutils, options]

import jsony
import supersnappy
import niprefs
import puppy

import watermelon
import glasses
import realestate

var dt : Datetime
var failedToLoad* : bool

var ver4updoot* = "v0.4.1"

type updoots = object
  tag_name: string



# A E S T E T H I C


proc nowMaker() =
  dt = now()


# A E S T E T H I C

var prefs* = toPrefs({
  archivePath: "",
  exportPath: "",
  notesFontSize: 11.0,
  notesFontWeight: 400, 
  notesFontFaceName: "",
  nodesFontSize: 9.0,
  nodesFontWeight: 400, 
  nodesFontFaceName: "",
  findFontSize: 9.0,
  findFontWeight: 400, 
  findFontFaceName: "",
  addNodeFontSize: 9.0,
  addNodeFontWeight: 400, 
  addNodeFontFaceName: "",
  notesFontColor: -1,
  nodesFontColor: -1,
  findFontColor: -1,
  addNodeFontColor: -1,
  notesBgColor: -1,
  nodesBgColor: -1,
  findBgColor: -1,
  addNodeBgColor: -1,
  appliqueNotesColor: -1,
  appliqueNodesColor: -1,
  appliqueFindColor: -1,
  appliqueAddNodeColor: -1,
  archivedRepo: ""
}).initPrefs(path = "koWloon.niprefs")


# A E S T E T H I C



proc save*(path : string) = 
  var xyz = (counter, starkSeq, tablex).toJson()
  var xy2 = xyz.compress()
  writeFile(path, xy2) 



proc load*(path : string):tuple =
  try:
    let fileContent = readFile(path)
    var middle = uncompress(fileContent)
    result = middle.fromJson(tuple[counter : int, starkSeq : seq[string], tablex :Table[string, Thingy]])
  except:
    failedToLoad = true
    return





# A E S T E T H I C


proc generatePath*(currentNode:string):seq[string] = 
  var reversePath : seq[string]
  var cp = tablex[currentNode].parent
  reversePath.add(tablex[cp].title)
  if tablex[cp].title == "root":
    #reversePath.add("root")
    return reversePath
  else:
    reversePath.add(generatePath(cp))
    return reversePath





proc generatePathUtils*(id : string):string = #MAYBE CIGARETTE?
  var rev = generatePath(id)
  rev = rev[0 .. ^2]
  rev.reverse()
  rev.add(tablex[id].title)
  return rev.join("/")



proc generatePathUtils1to1*(id : string):string = #MAYBE CIGARETTE?
  var rev = generatePath(id)
  rev = rev[0 .. ^2]
  rev.reverse()
  rev.add(tablex[id].title)
  return rev.join("\\")


proc generatePathUtilsPar*(id : string):string = #MAYBE CIGARETTE?
  var rev = generatePath(id)
  rev.reverse()
  return rev.join("/")


proc globalWalk*(id : string):string = #MAYBE CIGARETTE?
  var id = id
  var data : string
  if tablex[id].children.len() > 0:
    for i in tablex[id].children:
      data.add("[" & generatePathUtils(i) & "]\n")
      data.add(tablex[i].data & "\n")
      data.add(globalWalk(i))
    return data


proc globalWalk1to1*(id : string):seq[tuple[ids, title, data : string]] =
  var id = id
  var burger : seq[tuple[ids, title, data : string]] #ty exelotl
  if tablex[id].children.len() > 0:
    for i in tablex[id].children:
      burger.add((tablex[i].id,generatePathUtils1to1(i),tablex[i].data))
      burger = burger & globalWalk1to1(i) 
    return burger




# A E S T E T H I C



proc getItOut(title: string, data : string):bool =
  if getString(prefs["exportPath"]).len > 0:
    try:
      var path = getString(prefs["exportPath"]) & "\\" & title
      writeFile(path,data)
      return true
    except:
      return false
  else:
    return false




proc getItOut1to1(title: string, data : string):bool =
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  var dirx = "\\" & dtformatted & "Export\\"
  if getString(prefs["exportPath"]).len > 0:
    try:
      discard existsOrCreateDir(getString(prefs["exportPath"]) & dirx)
      var path = getString(prefs["exportPath"]) & dirx & title
      writeFile(path,data)
    except:
      return false
  else:
    return false


proc getItOut1to1global(title: string, data : string): bool = #maybe we shouldn't fallback when fails to read prefs
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  var dirx = "\\" & dtformatted & "Export\\" & title
  if getString(prefs["exportPath"]).len > 0:
    try:
      createDir(getString(prefs["exportPath"]) & splitFile(dirx)[0])
      writeFile(getString(prefs["exportPath"]) & dirx,data)
      return true
    except:
      return false
  else:
    return false



proc exportSingleNote*(currentNode: string):bool =
  var title : string
  nowMaker()
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  if tablex[currentNode].title.len() > 0:
    title = dtformatted & tablex[currentNode].title & ".txt"
  else:  
    title = dtformatted & "Note" & ".txt"
  var data = tablex[currentNode].data
  result = getItOut(title, data)


proc exportContext1to1*(container: seq[string]):bool =
  var title : string
  var data : string
  nowMaker()
  var collisionCheckSet : Hashset[string]
  for i in container:
    title = tablex[i].title
    if title notin collisionCheckSet:
      collisionCheckSet.incl(title)
    else:
      title = title & " " & tablex[i].id
    title = title & ".txt"
    data = tablex[i].data
    result = getItOut1to1(title, data)


proc exportContext*(titleCTX: string, container: seq[string]):bool =
  var title : string
  nowMaker()
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  title = dtformatted & titleCTX & ".txt"
  var data : string
  for i in container:
    data.add("\n[ " & tablex[i].title & " ]\n")
    data.add(tablex[i].data & "\n")
  result = getItOut(title, data)




proc exportGlobal*(id : string):bool=
  var title : string
  nowMaker()
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  title = dtformatted & tablex[id].title & ".txt"
  var data = globalWalk(id)
  result = getItOut(title, data)



proc exportGlobal1to1beta*(id : string): bool=
  var title : string
  var data : string
  nowMaker()
  var collisionCheckSet : Hashset[string]
  var discarded : string
  var burger = globalWalk1to1(id)
  for (ids, title, data) in burger:
    var xtitle = title
    if xtitle notin collisionCheckSet:
      collisionCheckSet.incl(title)
    else:
      xtitle = xtitle & " " & ids
    xtitle = xtitle & ".txt"
    result = getItOut1to1global(xtitle, data)



proc backupMaker*():bool =
  nowMaker()
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  var temp = getString(prefs["exportPath"])
  prefs["exportPath"] = temp & "\\koWBackup"
  createDir(temp & "\\koWBackup")
  save(temp & "\\koWBackup\\" & dtformatted & "backup.kgn")
  result = exportGlobal("root")
  prefs["exportPath"] = temp






# A E S T E T H I C




proc initNinjaRoot*(container : seq[string], container2 : seq[string]) =
  var helloworld = Thingy()
  helloworld.id = "ninjaroot"
  helloworld.title = "ninjaroot"
  tablex["ninjaroot"] = helloworld
  for i,v in container:
    addchild("ninjaroot",v)
    tablex[tablex["ninjaroot"].children[^1]].data = container2[i]






# A E S T E T H I C

proc salmonTheme*() =
  prefs["notesBgColor"] = 14215423
  prefs["nodesBgColor"] = 13093375
  prefs["findBgColor"] = 14215423
  prefs["addNodeBgColor"] = 13093375
  prefs["appliqueNotesColor"] = int(0x0099CC32)
  prefs["appliqueNodesColor"] = int(0x0099CC32)
  prefs["appliqueFindColor"] = int(0x0099CC32)
  prefs["appliqueAddNodeColor"] = int(0x0099CC32)
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0


proc tealTheme*() =
  prefs["notesBgColor"] = 14211250
  prefs["nodesBgColor"] = 11711078
  prefs["findBgColor"] = 14211250
  prefs["addNodeBgColor"] = 11711078
  prefs["appliqueNotesColor"] = 14211250
  prefs["appliqueNodesColor"] = 11711078
  prefs["appliqueFindColor"] = 14211250
  prefs["appliqueAddNodeColor"] = 11711078
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0

proc savanaTheme*() =
  prefs["notesBgColor"] = 12439255
  prefs["nodesBgColor"] = 12439255
  prefs["findBgColor"] = 12439255
  prefs["addNodeBgColor"] = 12439255
  prefs["appliqueNotesColor"] = 12439255
  prefs["appliqueNodesColor"] = 12439255
  prefs["appliqueFindColor"] = 12439255
  prefs["appliqueAddNodeColor"] = 12439255
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0

proc metalTheme*() =
  prefs["notesBgColor"] = 13551040
  prefs["nodesBgColor"] = 12234151
  prefs["findBgColor"] = 13551040
  prefs["addNodeBgColor"] = 12234151
  prefs["appliqueNotesColor"] = 13551040
  prefs["appliqueNodesColor"] = 12234151
  prefs["appliqueFindColor"] = 13551040
  prefs["appliqueAddNodeColor"] = 12234151
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0




# A E S T E T H I C

var archCounter* : int
var archStarkSeq* : seq[string]
var archTablex* = initTable[string, Thingy]()


proc archCounterGen*(cnt: int):int =
  archCounter = cnt + 1
  result = int(archCounter)

proc addChildRepo(parentid : string, title : string)=
  let now1 = now()
  var newChild = Thingy()
  newChild.id = base64encode(archCounterGen(archCounter))
  newChild.title = title
  newChild.parent = parentid
  newChild.ledit = now1.format("yyyy-MM-dd-HH-mm-ss")
  archTablex[newChild.id] = newChild
  archTablex[parentid].children.add(newChild.id)


proc loadR*(path : string):tuple =
  try:
    let fileContent = readFile(path)
    var middle = uncompress(fileContent)
    result = middle.fromJson(tuple[archCounter : int, archStarkSeq : seq[string], archTablex :Table[string, Thingy]])
  except:
    failedToLoad = true
    return


proc loadRepo(path : string):bool =
  var qkz = loadR(path)
  if failedToLoad == true:
    echo "failed to load"
    failedToLoad.reset()
    return false
  else:
    archCounter = qkz[0]
    archStarkSeq = qkz[1]
    archTablex = qkz[2]
    return true


proc saveRepo*(path : string) = 
  var xyz = (archCounter, archStarkSeq, archTablex).toJson()
  var xy2 = xyz.compress()
  writeFile(path, xy2) 




proc deepPasteRepo(parent : string, currentCopyId : string) = #The Crown Jewel
  var parent = parent
  var currentCopyId = currentCopyId
  for i,v in tablex[currentCopyId].children:
    addchildRepo(parent, tablex[v].title)
    archTablex[archTablex[parent].children[i]].data = tablex[v].data
    if tablex[v].children.len() > 0:
      deepPasteRepo(archTablex[parent].children[i], v)



proc pasteToArchRepo(currentParentId : string) =
      if copyStatus == deepCopyx: #Do not ever touch
        if currentParentId.len() > 0:
          addchildRepo("root",copySingleNodeTitle) 
          var gitFakeId = archTablex[archTablex["root"].children[^1]].id
          archTablex[gitFakeId].data = copySingleNodeData
          deepPasteRepo(gitFakeId, currentCopyId)



proc archivedRepo*(currentParentId : string):bool =
  if loadRepo(getString(prefs["archivedRepo"])):
    pasteToArchRepo(currentParentId)
    #cleanupChild(copySingleNodeTitle) why this never worked? should be safe
    #removeChild(copySingleNodeTitle) 
    saveRepo(getString(prefs["archivedRepo"]))
    archCounter = 0
    archStarkSeq.reset()
    archTablex.reset()
    return true
  else:
    return false



# A E S T E T H I C

proc isUpdated*():Option[bool]=
  try:
    var req = Request(url: parseUrl("https://api.github.com/repos/endriVV/koWloon-generic-notes/releases/latest"),verb: "get")
    var res = fetch(req)
    var jsonNode = res.body.fromJson(updoots)
    var tagz = jsonNode.tag_name
    echo tagz
    if tagz > ver4updoot:
      return some(false)
    else:
      return some(true)
  except:
    return none(bool)