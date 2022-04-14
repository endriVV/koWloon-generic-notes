import std / [os, sets, times, tables, algorithm, strutils, options]

import jsony
import supersnappy
import niprefs
import puppy

import watermelon
import glasses


var dt : Datetime
var failedToLoad* : bool

var ver4updoot* = "v0.4.3"

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
  randomTheme: false,
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
  if tablex[cp].title == "root" or tablex[cp].title == "archroot" :
    #reversePath.add("root")
    return reversePath
  else:
    reversePath.add(generatePath(cp))
    return reversePath




proc generatePathUtils*(id : string):string = 
  var rev = generatePath(id)
  rev = rev[0 .. ^2]
  rev.reverse()
  rev.add(tablex[id].title)
  return rev.join("/")



proc generatePathUtils1to1*(id : string):string = 
  var rev = generatePath(id)
  rev = rev[0 .. ^2]
  rev.reverse()
  rev.add(tablex[id].title)
  return rev.join("\\")



proc generatePathUtilsPar*(id : string):string = 
  var rev = generatePath(id)
  discard rev.pop()
  rev.reverse()
  return rev.join("/")


proc generatePathUtilsForStarkCheck*(id : string):string = 
  var rev = generatePath(id)
  result = rev.pop()




proc globalWalk*(id : string):string = 
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



proc mailtoContext*(container: seq[string]):string =
  var title : string
  var data : string
  for i in container:
    data.add("\n[ " & tablex[i].title & " ]\n")
    data.add(tablex[i].data & "\n")
  return data[1 .. ^1].replace("\n", "%0d%0a")




proc exportGlobal*(id : string):bool=
  var title : string
  nowMaker()
  let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
  title = dtformatted & tablex[id].title & ".txt"
  var data = globalWalk(id)
  result = getItOut(title, data)



proc exportGlobal1to1beta*(id : string): bool=
  nowMaker()
  var collisionCheckSet : Hashset[string]
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
  try:
    nowMaker()
    let dtformatted = dt.format("yyyy-MM-dd HH-mm-ss ")
    var temp = getString(prefs["exportPath"])
    prefs["exportPath"] = temp & "\\koWBackup"
    createDir(temp & "\\koWBackup")
    save(temp & "\\koWBackup\\" & dtformatted & "backup.kgn")
    result = exportGlobal("root")
    result = exportGlobal("archroot")
    prefs["exportPath"] = temp
    return true
  except:
    return false






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
  prefs["notesBgColor"] = 12835051 #or 14150135
  prefs["nodesBgColor"] = 12439255
  prefs["findBgColor"] = 12835051
  prefs["addNodeBgColor"] = 12439255
  prefs["appliqueNotesColor"] = 12835051
  prefs["appliqueNodesColor"] = 12439255
  prefs["appliqueFindColor"] = 12835051
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

proc cherryBlossomTheme*() = #in honor of alphatester demotomohiro
  prefs["notesBgColor"] = 15986943
  prefs["nodesBgColor"] = 14011647
  prefs["findBgColor"] = 15986943
  prefs["addNodeBgColor"] = 14011647
  prefs["appliqueNotesColor"] = 11711078
  prefs["appliqueNodesColor"] = 11711078
  prefs["appliqueFindColor"] = 11711078
  prefs["appliqueAddNodeColor"] = 11711078
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0

proc coalTheme*() = 
  prefs["notesBgColor"] = 9997466
  prefs["nodesBgColor"] = 9932698
  prefs["findBgColor"] = 9997466
  prefs["addNodeBgColor"] = 9932698
  prefs["appliqueNotesColor"] = 9997466
  prefs["appliqueNodesColor"] = 9932698
  prefs["appliqueFindColor"] = 9997466
  prefs["appliqueAddNodeColor"] = 9932698
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0

proc dolphinTheme*() = 
  prefs["notesBgColor"] = 16506555
  prefs["nodesBgColor"] = 16370320
  prefs["findBgColor"] = 16506555
  prefs["addNodeBgColor"] = 16370320
  prefs["appliqueNotesColor"] = 16506555
  prefs["appliqueNodesColor"] = 16370320
  prefs["appliqueFindColor"] = 16506555
  prefs["appliqueAddNodeColor"] = 16370320
  prefs["notesFontColor"] = 0
  prefs["nodesFontColor"] = 0
  prefs["findFontColor"] = 0
  prefs["addNodeFontColor"] = 0


# A E S T E T H I C

proc isUpdated*():Option[bool]=
  try:
    var req = Request(url: parseUrl("https://api.github.com/repos/endriVV/koWloon-generic-notes/releases/latest"),verb: "get")
    var res = fetch(req)
    var jsonNode = res.body.fromJson(updoots)
    var tagz = jsonNode.tag_name
    if tagz > ver4updoot:
      return some(false)
    else:
      return some(true)
  except:
    return none(bool)