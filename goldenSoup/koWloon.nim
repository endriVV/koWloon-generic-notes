import wNim / [wApp,wPaintDC, wFontDialog, wImage, wDirDialog, wColorDialog ,wFileDialog, wFont, wCheckBox, wFrame, wPanel, wButton, wTextCtrl, wUtils, wListCtrl, wStaticBox, wMessageDialog, wStatusBar, wIcon, wBitmap, wMenuBar, wMenu, wMenuBarCtrl,wDataObject,wListBox,wStaticText]
import std / [strformat, strutils, tables, algorithm, os, times, unicode, sequtils, with, options,enumerate]
import winim/winstr, winim/inc/shellapi, winim/lean

import niprefs

import glasses
import watermelon
import alohacafe
import romance
import cigarette
import nostalgia
import lateforwork


var unsaved = false
var saveMark = ""

let savefloppy ="\u{1F5AB}"
const namedrop = "koWloon (generic) notes"
const author = "endriVV"
let github = "https://github.com/endriVV/koWloon-generic-notes"
var archiveName : string
let ver = fmt" - {ver4updoot} "
var bookmarkingSeq : seq[string]
const slurpy=staticRead("gyoza/Untitled3.ico")
const slurpy2=staticRead("gyoza/Untitled560.png")





proc createChildThreadAbouts()=
  var t1 = fmt"{namedrop}{ver}"
  var t2 = fmt"Author: {author}"
  var t3 = github

  var app = App()
  var frame = Frame(title="About", size=(340, 520))
  let sub1 = Panel(frame)
  let sub2 = Panel(frame)
  let smallFont = Font(12, weight=900, faceName="Tahoma")
  frame.icon = Icon(slurpy)
  sub1.backgroundColor = 16777215
  sub2.backgroundColor = 16777215
  let dataBitmap = Bitmap(slurpy2)
  let textctrl2 = TextCtrl(sub1, style=wTeRich or wTeMultiLine or wTeCenter or wTeReadOnly)

  proc layout() =
    frame.layout:
        sub1:
            top = frame.top
            left = frame.left
            bottom = sub2.top
            right = frame.right
        sub2:
            left = frame.left
            bottom = frame.bottom
            height = frame.height / 2
    sub1.layout:
        textctrl2:
            top = sub1.top
            left = sub1.left
            bottom = sub1.bottom
            right = sub1.right

  with textctrl2:
    writeText("\n")
    writeText("\n")
    writeText("\n")
    writeText("\n")
    writeText("\n")
    writeText("\n")
    writeText("\n")
    setStyle(lineSpacing=1.5, indent=288)
    writeText("\n")
    setFormat(smallFont, fgColor=wBlack)
    writeText(t1)
    setFormat(smallFont, fgColor=wMediumAquamarine)
    writeText("\n")
    writeText(t2)
    setFormat(smallFont, fgColor=wBlue)
    writeText("\n")
    writeLink(t3, "Github page")
    writeText("\n")



  textctrl2.wEvent_TextLink do (event: wEvent):
    if event.mouseEvent == wEvent_LeftUp:
      let url = textctrl2.range(event.start..<event.end)
      ShellExecute(0, "open", url, nil, nil, 5)
      frame.delete



  sub2.wEvent_Paint do ():
    var
      dc = PaintDC(sub2)

    dc.backgroundTransparent = true
    dc.drawBitmap(dataBitmap)


  frame.wEvent_Size do ():
    layout()

  layout()

  frame.show()
  app.mainLoop()







proc createChildThreadUpdate()=
  var t1 = fmt"{namedrop}{ver}"
  var t2 = fmt"Author: {author}"
  var t3 = github

  var app = App()
  var frame = Frame(title="Check for Updates..", size=(340, 520))
  let sub1 = Panel(frame)
  let sub2 = Panel(frame)
  let smallFont = Font(12, weight=900, faceName="Tahoma")
  frame.icon = Icon(slurpy)
  sub1.backgroundColor = 16777215
  sub2.backgroundColor = 16777215
  let dataBitmap = Bitmap(slurpy2)
  let textctrl2 = TextCtrl(sub1, style=wTeRich or wTeMultiLine or wTeCenter or wTeReadOnly)


  proc layout() =
    frame.layout:
        sub1:
            top = frame.top
            left = frame.left
            bottom = sub2.top
            right = frame.right
        sub2:
            left = frame.left
            bottom = frame.bottom
            height = frame.height / 2
    sub1.layout:
        textctrl2:
            top = sub1.top
            left = sub1.left
            bottom = sub1.bottom
            right = sub1.right


  var check = isUpdated()

  textctrl2.writeText("\n")
  textctrl2.writeText("\n")
  textctrl2.writeText("\n")
  textctrl2.writeText("\n")
  textctrl2.writeText("\n")
  textctrl2.setStyle(lineSpacing=1.5, indent=288)
  textctrl2.setFormat(smallFont, fgColor=wBlack)
  textctrl2.writeText(t1)
  textctrl2.writeText("\n")

  if check == some(false):
      t2 = "New updates are available!"
      textctrl2.setFormat(smallFont, fgColor=wRed)
      textctrl2.writeText(t2)
      textctrl2.setFormat(smallFont, fgColor=wBlack)
      textctrl2.writeText("\n")
      textctrl2.writeText("Visit the homepage to download them")

  if check == some(true):
      t2 = "The program is updated to the latest version. Happy day ٩(◕‿◕｡)۶"
      textctrl2.setFormat(smallFont, fgColor=wMediumAquamarine)
      textctrl2.writeText(t2)
  if check == none(bool):
      t2 = "Couldn't connect to the server ( •_•)"
      textctrl2.setFormat(smallFont, fgColor=wRed)
      textctrl2.writeText(t2)

  textctrl2.setFormat(smallFont, fgColor=wBlue)
  textctrl2.writeText("\n")
  textctrl2.writeLink(t3, "Github page")
  textctrl2.writeText("\n")



  textctrl2.wEvent_TextLink do (event: wEvent):
    if event.mouseEvent == wEvent_LeftUp:
      let url = textctrl2.range(event.start..<event.end)
      ShellExecute(0, "open", url, nil, nil, 5)
      frame.delete


  sub2.wEvent_Paint do ():
    var
      dc = PaintDC(sub2)

    dc.backgroundTransparent = true
    dc.drawBitmap(dataBitmap)




  frame.wEvent_Size do ():
    layout()

  layout()



  frame.show()
  app.mainLoop()










proc main(bootstarter : bool) =


  var modFlag = false
  var modCheck : string
  var keep = false
  var ctx = false

  let app = App()
  let frame = Frame(title=fmt"{saveMark}{namedrop}{ver} []", size=(850, 650))
  let panel = Panel(frame)
  frame.icon = Icon(slurpy)





  type
    Operation = enum
      nin, addx, search, newx, docx, prefx, starkx

  var modeStatus = addx

  var archMode = ""

  var currentRootId = "root"
  var currentGrandParentId : seq[string]
  var tempGrandParentId : seq[string]
  var currentParentId = currentRootId
  var currentParentPath = ""
  var currentChildren : seq[string]
  var currentNode : string


  var searchTitles : seq[string]
  var searchNotes : seq[string]
  var searchTerm : string
  var searchResultsId : seq[string]



  type
    MenuID = enum
      idOpen = wIdUser, idExit, idSave
      idSaveAs
      idAbout
      idLeft
      idRight
      idDown
      idUp
      idPlus
      idPlusPlus
      idRemove
      idMinus
      idSwapDown
      idSwapUp
      idModify
      idClipboard
      idClipboards   
      idNotesToNodes
      idNotesToSubNodes
      idNotesToSubNodesPivot
      idNotesToNotes
      idEsc
      idExportNote
      idExportContext
      idExportGlobal
      idExportContext1to1
      idExportGlobal1to1
      idSearch
      idAdvSearch
      idCtx
      idFindNext
      idOrderAZ
      idOrderLE
      idReplace
      idReplaceAll
      idPaste
      idSingleCopy
      idFlatCopy
      idDeepCopy
      idDeepCut
      idCheck1
      idCheck2
      idNew
      idRefresh
      idDocx
      idPrefs
      idBackup
      idToggleStarks
      idStarkList
      idArchiveElement
      idAddView
      idCheckUpdates
      idToggleArchive
      idMail
      idMailContext

  let menuBar = MenuBar(frame)
  let menuFile = Menu(menuBar, "&File")
  menuFile.append(idNew, "&New", "Create a new data archive")
  menuFile.append(idOpen, "&Open..", "Load an existing archive")
  menuFile.appendSeparator()
  menuFile.append(idSave, "&Save\tCtrl+S", "Save")
  menuFile.append(idSaveAs, "&Save As ..", "Save as another .kgn archive")
  menuFile.appendSeparator()
  menuFile.append(idAddView, "&Add View", "Opens a new Window to edit the same Notes")
  menuFile.appendSeparator()
  menuFile.append(idPrefs, "&Preferences", "Customize")
  menuFile.appendSeparator()
  menuFile.append(idExit, "&Exit\tCtrl+Q", "Exit")
  let menuEdit = Menu(menuBar, "&Edit")
  menuEdit.append(idPlus, "&Zoom in Node\tCtrl+Enter", "Shift to next subnode level")
  menuEdit.append(idMinus, "&Zoom out Node\tCtrl+Backspace", "Shift back to previous subnode level")
  menuEdit.appendSeparator()
  menuEdit.append(idFindNext, "&Find Next\tCtrl+N", "Find Next")
  menuEdit.append(idReplace, "&Replace\tCtrl+R", "Replace")
  menuEdit.append(idReplaceAll, "&Replace all", "Replace all")
  menuEdit.appendSeparator()
  menuEdit.append(idNotesToNodes, "&Notes to Nodes\tCtrl+P", "Send all the current Notes, line by line, to Node List")
  menuEdit.append(idNotesToSubNodes, "&Notes to Sub-Nodes", "Send all the current Notes, line by line, as SubNode to pre-existing Nodes")
  menuEdit.append(idNotesToSubNodesPivot, "&Notes to Sub-Nodes [Pivot]", "Send all the current Notes, line by line, as Pivot SubNode to pre-existing Nodes")
  menuEdit.append(idNotesToNotes, "&Notes to line-by-line Notes", "Send all the current Notes, line by line, as Note to pre-existing Nodes")
  menuEdit.appendSeparator()
  menuEdit.append(idMail, "&Mail Note", "Opens the default email program and drafts an email with the note contents")
  menuEdit.append(idMailContext, "&Mail Context", "Like Mail Note but for the current context")
  let menuNode = Menu(menuBar, "&Nodes")
  menuNode.append(idRefresh, "&RefreshNode\tF5", "Refresh a node")
  menuNode.appendSeparator()
  menuNode.append(idRemove, "&Delete Node\tCtrl+Del", "Delete node and all subnodes")
  menuNode.append(idModify, "&Rename Node\tCtrl+M", "Rename node")
  menuNode.appendSeparator()
  menuNode.append(idSwapUp, "&Swap up\tAlt+Up", "Swap node one position up")
  menuNode.append(idSwapDown, "&Swap down\tAlt+Down", "Swap node one position down")
  menuNode.appendSeparator()
  menuNode.append(idClipboard, "&Node to Clipboard", "Copy a single Node name to the Clipboard")
  menuNode.append(idClipboards, "&Nodes to Clipboard", "Copy all the current Nodes to the Clipboard")
  menuNode.append(idOrderAZ, "&Order Nodes A-Z", "Order current Nodes alphabetically")
  menuNode.append(idOrderLE, "&Order Nodes Last-Edited", "Order current Nodes in order of edit time")
  let menuCopy = Menu(menuBar, "&Copy")
  menuCopy.append(idSingleCopy, "&Single Copy", "Copy only the current Node")
  menuCopy.append(idFlatCopy, "&Flat Copy", "Copy only the current context (no subnodes)")
  menuCopy.appendSeparator()
  menuCopy.append(idDeepCut, "&Deep Cut\tF6", "Cut current Node including any subnode")
  menuCopy.append(idDeepCopy, "&Deep Copy\tF7", "Copy current Node including any subnode")
  menuCopy.appendSeparator()
  menuCopy.append(idPaste, "&Paste\tF8", "Paste")
  menuCopy.appendSeparator()
  menuCopy.append(idArchiveElement, "&Archive Element", "Deep Cuts the current node to the Archive")
  let menuUtils = Menu(menuBar, "&Utils")
  menuUtils.append(idToggleStarks,"&Add / Remove Bookmark","Toggled the favorite status of the current node")
  menuUtils.append(idStarkList,"&View Bookmarks List","Displays all the current favorite nodes")
  menuUtils.appendSeparator()
  menuUtils.append(idToggleArchive,"&Toggle Archive","Enter or Exit Archive List")
  menuUtils.appendSeparator()
  menuUtils.append(idExportNote,"&Export Note","Export current note")
  menuUtils.append(idExportContext,"&Export Context","Export current context")
  menuUtils.append(idExportGlobal,"&Export Global","Deep Export from current node")
  menuUtils.appendSeparator()
  menuUtils.append(idExportContext1to1,"&Export Context 1to1","Export current context, one file per node")
  menuUtils.append(idExportGlobal1to1,"&Export Global 1to1","Deep Export from current node, one file per node")
  let menuHelp = Menu(menuBar, "&Help")
  menuHelp.append(idDocx, "Documentation", "Documentation")  
  menuHelp.append(idCheckUpdates, "Check for Updates..", "Check for Updates")  
  menuHelp.appendSeparator()
  menuHelp.append(idBackup, "Backup", "Make a backup copy of your archive in .kgn and plain text format")
  menuHelp.appendSeparator()
  menuHelp.append(idAbout, "About", "Info") 

  let menuContext = Menu()
  menuContext.append(idToggleStarks,"&Add / Remove Bookmark","Toggled the favorite status of the current node")
  menuContext.appendSeparator()
  menuContext.append(idRemove, "&Delete Node\tCtrl+Del", "Delete node and all subnodes")
  menuContext.append(idModify, "&Rename Node\tCtrl+M", "Rename node")
  menuContext.appendSeparator()
  menuContext.append(idSwapUp, "Swap up\tAlt+Up", "Swap node one position up")
  menuContext.append(idSwapDown, "Swap down\tAlt+Down", "Swap node one position down")
  menuContext.appendSeparator()
  menuContext.append(idSingleCopy, "&Single Copy", "Copy only the current Node")
  menuContext.append(idFlatCopy, "&Flat Copy", "Copy only the current context (no subnodes)")
  menuContext.appendSeparator()
  menuContext.append(idDeepCut, "&Deep Cut\tF6", "Cut current Node including any subnode")
  menuContext.append(idDeepCopy, "&Deep Copy\tF7", "Copy current Node including any subnode")
  menuContext.appendSeparator()
  menuContext.append(idPaste, "&Paste\tF8", "Paste")
  menuContext.appendSeparator()
  menuContext.append(idArchiveElement, "&Archive Element", "Deep Cuts the current node to the Archive")
  let pasteContext = Menu()
  pasteContext.append(idPaste, "&Paste\tF8", "Paste")

  let status = StatusBar(frame)

  let boxOne = StaticBox(panel, label="Notes:")
  let dataBox = TextCtrl(boxOne,style=wTeMultiLine or wVScroll or wTeNoHideSel) #test with wTeProcessTab #wVScroll
  let boxTwo = StaticBox(panel, label="Node List:")
  var dataList = ListBox(boxTwo, style=wLbNeededScroll) #style=wLbAlwaysScroll
  let boxThree = StaticBox(panel, label="Find:")
  let boxFour = StaticBox(panel, label="Add Node:")
  let inputList = TextCtrl(boxFour)
  let inputSearch = TextCtrl(boxThree)
  let addnodeButton = Button(boxFour, label="+")
  let plusButton = Button(boxFour, label="↪")
  let minusButton = Button(boxFour, label="↩")
  let searchButton = Button(boxThree, label="Find")
  let nodeCheck = CheckBox(boxThree, label="🔗")
  let noteCheck = CheckBox(boxThree, label="✏️")
  let keepCheck = CheckBox(boxThree, label="Keep")
  let ctxCheck = CheckBox(boxThree, label="Ctx")
  let defaultFont = Font(11, weight=wFontWeightNormal, family= 0)
  let defaultFont2 = Font(9, weight=wFontWeightNormal, family= 0)
  let helperButton = Button(boxThree, label="Setter")
  helperButton.disable()
  helperButton.hide()
  dataBox.setFont(defaultFont)
  dataList.setFont(defaultFont2)
  inputSearch.setFont(defaultFont2)
  inputList.setFont(defaultFont2)
  dataBox.setMargin(5) #hmmmmm 
  nodeCheck.setValue(true)
  dataBox.setStyle(align = wTextAlignJustify)








  var appliqueNotes = wLightSteelBlue
  var appliqueNodes = wMediumAquamarine
  var appliqueFind = wGold
  var appliqueAddNode = wLightMagenta



  var accel = AcceleratorTable()

  proc axelTableReset()=
    accel.clear()
    accel.add(wAccelNormal, wKey_Esc, idEsc)
    accel.add(wAccelNormal, wKey_F5, idRefresh)
    accel.add(wAccelNormal, wKey_F6, idDeepCut)
    accel.add(wAccelNormal, wKey_F7, idDeepCopy)
    accel.add(wAccelNormal, wKey_F8, idPaste)
    accel.add(wAccelCtrl, wKey_P, idNotesToNodes)
    accel.add(wAccelCtrl, wKey_M, idModify)
    accel.add(wAccelCtrl, wKey_S, idSave)
    accel.add(wAccelCtrl, wKey_Down, idDown)
    accel.add(wAccelCtrl, wKey_N, idFindNext)
    accel.add(wAccelCtrl, wKey_Q, idExit)
    accel.add(wAccelAlt, wKey_Down, idSwapDown)
    accel.add(wAccelAlt, wKey_Up, idSwapUp)
    accel.add(wAccelCtrl, wKey_Left, idLeft)
    accel.add(wAccelCtrl, wKey_Right, idRight)
    accel.add(wAccelCtrl, wKey_Up, idUp)
    accel.add(wAccelCtrl, wKey_R, idReplace)
    accel.add(wAccelCtrl, wKey_Enter, idPlusPlus)
    accel.add(wAccelCtrl, wKey_Delete, idRemove)
    accel.add(wAccelCtrl, wKey_Back, idMinus)
    frame.acceleratorTable = accel

  axelTableReset()

  proc layout() =
      panel.layout:
          boxOne:
              top = panel.top
              left = panel.left
              bottom = boxThree.top
              width = panel.width - 140 - (panel.width * 0.14)
          boxTwo:
              top = panel.top
              right = panel.right
              left = boxOne.right
              height = boxOne.height
              width = 140 + (panel.width * 0.14)
          boxThree:
              bottom = panel.bottom
              height = 50
              left = panel.left
              width = panel.width - 140 - (panel.width * 0.14)
          boxFour:
              bottom = panel.bottom
              height = 50
              left = boxThree.right
              right = panel.right
              width = 140 + (panel.width * 0.14)
      boxOne.layout:
          dataBox:
              top = boxOne.top
              left = boxOne.left
              bottom = boxOne.bottom
              width = boxOne.width
      boxTwo.layout:
          dataList:
              top = boxTwo.top
              left = boxTwo.left
              bottom = boxTwo.bottom
              width = boxTwo.width
      boxFour.layout:
          inputList:
              top = boxFour.top
              left = boxFour.left
          addnodeButton:
              top = boxFour.top
              left = inputList.right + 5
              width = inputList.width / 4
          plusButton:
              top = boxFour.top
              left = addnodeButton.right + 5
              width = inputList.width / 4
          minusButton:
              top = boxFour.top
              left = plusButton.right
              width = inputList.width / 4
      boxThree.layout:
          inputSearch:
              top = boxThree.top
              left = boxThree.left
              width = boxThree.width / 4
          searchButton:
              top = boxThree.top
              left = inputSearch.right + 5
              width = inputSearch.width / 2       
          nodeCheck:
              top = boxThree.top
              left = searchButton.right + 8
          noteCheck:
              top = boxThree.top
              left = nodeCheck.right + 8
          ctxCheck:
              top = boxThree.top
              left = noteCheck.right + 15

          keepCheck:
              top = boxThree.top
              left = ctxCheck.right + 5

          helperButton:
              top = boxThree.top
              right = boxThree.right




  # A E S T E T H I C

  proc setUnsaved(status : bool) =
    if status == true:
      unsaved = true
      saveMark = "*"
      frame.title = fmt"{saveMark}{namedrop}{ver}- [{archiveName}]{archMode}"
    else:
      unsaved = false
      saveMark = ""
      frame.title = fmt"{saveMark}{namedrop}{ver}- [{archiveName}]{archMode}"


  # A E S T E T H I C

  proc getInside() =
    if currentChildren.len() > 0:
      currentGrandParentid.add(currentParentId)
      currentParentId = tablex[currentNode].id
      currentChildren = tablex[currentParentId].children
      currentParentPath = currentParentPath & "/" & tablex[currentParentId].title


  proc getOutside():bool =
    if currentGrandParentId.len == 0:
      return false
    else:
      currentNode = currentParentId
      currentParentId = currentGrandParentid[^1]
      currentGrandParentid.delete(currentGrandParentid.high)
      currentChildren = tablex[currentParentId].children
      return true



  # A E S T E T H I C

  proc cSgetChildrenTitles(i : string):string =
    if stark in tablex[i].s:
      return tablex[i].title & "⭐"
    else:
      tablex[i].title



  proc getChildrenTitles():seq[string]=
    if currentChildren.len() > 0:
      for i in currentChildren:
        var rex = cSgetChildrenTitles(i)
        if tablex[i].children.len() == 0:
          result.add(rex)
        else:
          result.add("➕ " & rex)



  proc appendSearchTitles(rextitle : seq[string]):seq[string]=
    for i,v in rextitle:
      if i < searchTitles.len:
        result.add(v & "  🔗")
      else:
        result.add(v & "  ✏️")



  proc displayChildrenTitles() =
    dataList.clear()
    var rextitle = getChildrenTitles()
    if modeStatus == search:
      rextitle = appendSearchTitles(rextitle)
    if rextitle.len > 0:
      dataList.append(rextitle) 







  # A E S T E T H I C


  proc bookmarkingOutside() =
    if currentNode in bookmarkingSeq:
      return
    else:
      bookmarkingSeq.add(currentNode)

  proc bookmarkingCheck():string = #change
    if currentChildren.len > 0 and currentNode.len > 0:
      for i in currentChildren:
        if i in bookmarkingSeq:
          return i
      bookmarkingSeq.reset()
      return "!"
    else:
      bookmarkingSeq.reset()
      return "!"

  # A E S T E T H I C


  proc getInsideGUI() =
    if tablex[currentNode].children.len > 0:
      getInside()
      if bookmarkingCheck() == "!":
        currentNode = currentChildren[0]
        currentParentId = tablex[currentNode].parent
        displayChildrenTitles()
        dataList.setSelection(0)
      else:
        currentNode = bookmarkingCheck()
        currentParentId = tablex[currentNode].parent
        displayChildrenTitles()
        dataList.setSelection(find(currentChildren, currentNode))
      status.setStatusText(currentParentPath & "/" & tablex[currentNode].title)
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)
      frame.title = fmt"{saveMark}{namedrop}{ver}- [{archiveName}]{archMode}"
    else:
      getInside()
      status.setStatusText(currentParentPath & "/..")
      currentNode.reset() #important or parent will lose his note due to update
      dataList.clear()
      dataBox.clear()
      currentChildren.reset()
      datalist.append(fmt" .. / ({tablex[currentParentId].title})") #visual stub



  proc getOutsideGUI()=
    if currentNode.len > 0:
      bookmarkingOutside()
    if getOutside():
      displayChildrenTitles()
      dataList.setSelection(find(currentChildren, currentNode))
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)
      status.setStatusText(fmt"{currentParentPath}")
      currentParentPath.removeSuffix("/" & tablex[currentNode].title) #NEAT! Never change
      frame.title = fmt"{saveMark}{namedrop}{ver}- [{archiveName}]{archMode}"



  proc addChildGUI()=
    addchild(currentParentId,inputList.getValue())
    setUnsaved(true)
    inputList.clear()
    currentChildren = tablex[currentParentId].children
    displayChildrenTitles()
    currentNode = currentChildren[^1]
    dataList.setSelection(find(currentChildren,currentNode))
    dataBox.clear()
    dataBox.add(tablex[currentNode].data)



  proc removeChildGUI(node : string)=   
    var bookmark = dataList.getSelection()
    cleanupChild(node)
    removeChild(node)
    checkSpecialDelete()
    setUnsaved(true)
    currentChildren = tablex[currentParentId].children
    if currentChildren.len() > 0:
      displayChildrenTitles()
      if dataList.getCount() > bookmark:
        dataList.setSelection(bookmark)
        currentNode = currentChildren[bookmark]
      else:
        dataList.setSelection(bookmark-1)
        currentNode = currentChildren[bookmark-1]
      dataBox.clear()
      dataBox.add(tablex[currentNode].data)
    else:
      dataBox.clear()
      dataList.clear()
      currentNode.reset()




  # A E S T E T H I C


  proc bling() =
    if dataBox.hasFocus() :
      status.setStatusText(savefloppy)



  proc blang()=
    if dataBox.hasFocus() :
          status.setStatusText("")


  proc updateDataBox()=
    if currentNode.len() > 0 : #guard vs infamous canc bug
      if tablex[currentNode].data != dataBox.getValue():
        tablex[currentNode].data = dataBox.getValue()
        let now1 = now()
        tablex[currentNode].ledit = now1.format("yyyy-MM-dd-HH-mm-ss")
        setUnsaved(true)
    else:
      if dataBox.getValue() != "":
        addchild(currentParentId,"New Node :)")
        currentNode = tablex[currentParentId].children[^1]
        tablex[currentNode].data = dataBox.getValue()
        let now1 = now()
        tablex[currentNode].ledit = now1.format("yyyy-MM-dd-HH-mm-ss")
        currentChildren = tablex[currentParentId].children
        displayChildrenTitles()
        setUnsaved(true)


    
   




  # A E S T E T H I C

  proc cleanCopyVarsGUI() =
    menuContext.enable(menuContext.findText("Paste\tF8"))
    menuCopy.enable(menuCopy.findText("Paste\tF8"))
    pasteContext.enable(pasteContext.findText("Paste\tF8"))
    cleanCopyVars()


  proc singleCopyGUI() =
    if currentNode.len() > 0:
      cleanCopyVarsGUI()
      singleCopy(currentNode)
      status.setStatusText(fmt"copied Node ../{tablex[currentNode].title}")
      

  proc flatCopyGUI() =
    if currentChildren.len() > 0:
      cleanCopyVarsGUI()
      flatCopy(currentChildren)
      status.setStatusText(fmt"copied Context ../{tablex[currentParentId].title}")


  proc deepCopyGUI() =
    if currentNode.len() > 0:
      cleanCopyVarsGUI()
      deepCopy(currentNode)
      status.setStatusText(fmt"deep copied Node ../{tablex[currentNode].title}")


  proc deepCutGUI() =
    if currentNode.len() > 0:
      cleanCopyVarsGUI()
      deepCut(currentNode)
      status.setStatusText(fmt"deep cut Node ../{tablex[currentNode].title}")


  proc pasteGUI() =
    if modeStatus == addx and currentParentId.len() > 0:
      var pasteRes = paste(currentRootId, currentParentId)
      if pasteRes == true:
          inputList.clear()
          currentChildren = tablex[currentParentId].children
          displayChildrenTitles()
          currentNode = currentChildren[^1]
          dataList.setSelection(find(currentChildren,currentNode))
          dataBox.clear()
          dataBox.add(tablex[currentNode].data)
          status.setStatusText("Node pasted")
          setUnsaved(true)
      else:
        status.setStatusText("Cutting a node in itself is not allowed")




  # A E S T E T H I C

  proc loadSearchChildren() =
    currentChildren.reset()
    for i in searchResultsId:
      currentChildren.add(i)



  proc loadStarkChildren() =
    currentChildren.reset()
    for i in starkSeq:
      currentChildren.add(i)




  # A E S T E T H I C

  proc swapNextGUI()=
    if currentNode.len > 0:
      var pos = dataList.getSelection()
      if currentChildren.len() < 2:
        return
      else:
        if tablex[tablex[currentNode].parent].children[pos] == tablex[tablex[currentNode].parent].children[^1]:
          return
        else:
          swap(tablex[tablex[currentNode].parent].children[pos],tablex[tablex[currentNode].parent].children[pos+1])
          currentChildren = tablex[currentParentId].children
          displayChildrenTitles()
          dataList.setSelection(pos+1)
          currentNode = currentChildren[pos+1]
          setUnsaved(true)


  proc swapNextContextGUI()=
    var pos = dataList.getSelection()
    if modeStatus == search and searchResultsId.len() < 2:
      return
    elif modeStatus == search and searchResultsId[pos] == searchResultsId[^1]:
      return
    elif modeStatus == search:
      swap(searchResultsId[pos],searchResultsId[pos+1])
      loadSearchChildren()
      displayChildrenTitles()
      dataList.setSelection(pos+1)
      currentNode = currentChildren[pos+1]
    elif modeStatus == starkx and starkSeq.len() < 2:
      return
    elif modeStatus == starkx and starkSeq[pos] == starkSeq[^1]:
      return
    elif modeStatus == starkx:
      swap(starkSeq[pos],starkSeq[pos+1])
      loadStarkChildren()
      displayChildrenTitles()
      dataList.setSelection(pos+1)
      currentNode = currentChildren[pos+1]


  proc swapPreviousGUI()=
    if currentNode.len > 0:
      var pos = dataList.getSelection()
      if currentChildren.len() < 2:
        return
      else:
        if tablex[tablex[currentNode].parent].children[pos] == tablex[tablex[currentNode].parent].children[0]:
          return
        else:
          swap(tablex[tablex[currentNode].parent].children[pos],tablex[tablex[currentNode].parent].children[pos-1])
          currentChildren = tablex[currentParentId].children
          displayChildrenTitles()
          dataList.setSelection(pos-1)
          currentNode = currentChildren[pos-1]
          setUnsaved(true)




  proc swapPreviousContextGUI()=
    var pos = dataList.getSelection()
    if modeStatus == search and searchResultsId.len() < 2:
      return
    elif modeStatus == search and searchResultsId[pos] == searchResultsId[0]:
      return
    elif modeStatus == search:
      swap(searchResultsId[pos],searchResultsId[pos-1])
      loadSearchChildren()
      displayChildrenTitles()
      dataList.setSelection(pos-1)
      currentNode = currentChildren[pos-1]
    elif modeStatus == starkx and starkSeq.len() < 2:
      return
    elif modeStatus == starkx and starkSeq[pos] == starkSeq[0]:
      return
    elif modeStatus == starkx:
      swap(starkSeq[pos],starkSeq[pos-1])
      loadStarkChildren()
      displayChildrenTitles()
      dataList.setSelection(pos-1)
      currentNode = currentChildren[pos-1]


   
  # A E S T E T H I C

  proc notesToNodes()=
    for i in databox.getValue().splitlines:
      addchild(currentParentId,i)
    if currentNode.len > 0:
      tablex[currentNode].data.reset()
    dataList.setFocus()
    currentChildren = tablex[currentParentId].children
    displayChildrenTitles()
    currentNode = currentChildren[0]
    dataList.setSelection(0)
    dataBox.clear()
    dataBox.setValue(tablex[currentNode].data)


  proc notesToSubNodes()=
    var temp2 = databox.getValue()
    if temp2.countLines() <= tablex[currentParentId].children.len():
      for i, v in enumerate temp2.splitlines:
        addchild(tablex[currentParentId].children[i],v)
      if currentNode.len > 0:
        tablex[currentNode].data.reset()
      dataList.setFocus()
      currentChildren = tablex[currentParentId].children
      displayChildrenTitles()
      currentNode = currentChildren[0]
      dataList.setSelection(0)
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)
    else:
      status.setStatusText("Lines to import should be equal or fewer of number of Nodes")


  proc notesToSubNodesPivot()=
    if inputList.getValue() != "":
      var temp3 = inputList.getValue()
      inputList.setValue("")
      var temp2 = databox.getValue()
      if temp2.countLines() <= tablex[currentParentId].children.len():
        for i, v in enumerate temp2.splitlines:
          addchild(tablex[currentParentId].children[i],temp3)
          if tablex[tablex[tablex[currentParentId].children[i]].children[^1]].data != "":
            tablex[tablex[tablex[currentParentId].children[i]].children[^1]].data  = tablex[tablex[tablex[currentParentId].children[i]].children[^1]].data  & "\r\n" & v
          else:
            tablex[tablex[tablex[currentParentId].children[i]].children[^1]].data  = v
        if currentNode.len > 0:
          tablex[currentNode].data.reset()
        dataList.setFocus()
        currentChildren = tablex[currentParentId].children
        displayChildrenTitles()
        currentNode = currentChildren[0]
        dataList.setSelection(0)
        dataBox.clear()
        dataBox.setValue(tablex[currentNode].data)
      else:
        status.setStatusText("Lines to import should be equal or fewer of number of Nodes")
    else:
      status.setStatusText("Add text in the Add Node field to Pivot data on it")



  proc notesToNotes()=
    var temp2 = databox.getValue()
    if temp2.countLines() <= tablex[currentParentId].children.len():
      if currentNode.len > 0:
        tablex[currentNode].data.reset()
      for i, v in enumerate temp2.splitlines:
        if tablex[tablex[currentParentId].children[i]].data != "":
          tablex[tablex[currentParentId].children[i]].data = tablex[tablex[currentParentId].children[i]].data & "\r\n" & v
        else:
          tablex[tablex[currentParentId].children[i]].data = v
      dataList.setFocus()
      currentChildren = tablex[currentParentId].children
      displayChildrenTitles()
      currentNode = currentChildren[0]
      dataList.setSelection(0)
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)
    else:
      status.setStatusText("Lines to import should be equal or fewer of number of Nodes")


  # A E S T E T H I C

  proc toggleStarkGUI(currentNode:string) =
    toggleStark(currentNode)
    setUnsaved(true)
    displayChildrenTitles()



  # A E S T E T H I C


  proc getSingleNodeAsBlob() =
    var tempclip : string
    if modeStatus == addx or modeStatus == search or modeStatus == starkx:
      if currentNode.len() > 0:
        tempclip = tablex[currentNode].title
        wSetClipboard(DataObject(tempclip))


  proc getCurrentListAsBlob() =
    var tempclip : seq[string]
    if modeStatus == addx:
      if currentChildren.len() > 0:
        for i in currentChildren:
          tempclip.add(tablex[i].title)
        var rex = tempclip.join("\n")
        wSetClipboard(DataObject(rex))
    if modeStatus == search:
      if searchResultsId.len() > 0:
        for i in searchResultsId:
          tempclip.add(tablex[i].title)
        var rex = tempclip.join("\n")
        wSetClipboard(DataObject(rex))
    if modeStatus == starkx:
      if starkSeq.len() > 0:
        for i in starkSeq:
          tempclip.add(tablex[i].title)
        var rex = tempclip.join("\n")
        wSetClipboard(DataObject(rex))


  # A E S T E T H I C



  var offset : int
  var track = 0

  proc findNextGUI() =
    var next : int
    var pos1 : int
    var pos2 : int
    if tablex[currentNode].data.toLowerAscii.find(searchTerm) != -1:
      var xyz = findNext(currentNode, searchTerm, track)
      pos1 = xyz[0]
      pos2 = xyz[1]
      track = pos2
      var runelenz = tablex[currentNode].data[0 .. pos1].runelen - 1
      offset = pos1 - runelenz
      pos1 = pos1 - offset
      pos2 = pos2 - offset
    else:
      track = 0
    dataBox.setFocus()
    dataBox.setSelection(pos1,pos2)
    dataBox.showPosition(pos1)



  proc replaceGUI() =
    var aa = dataBox.getSelection().a
    var bb = dataBox.getSelection().b
    if dataBox.getValue[aa + offset .. bb + offset].toLowerAscii == searchTerm:
      var replacer = inputList.getValue()
      dataBox.remove(dataBox.getSelection())
      dataBox.writeText(replacer)
      tablex[currentNode].data = databox.getValue()
      track = 0
      setUnsaved(true)
    findNextGUI()
    inputList.setFocus()



  proc replaceAllGUI()=
    replaceAll(currentNode, searchTerm, inputList.getValue())
    dataBox.clear()
    dataBox.setValue(tablex[currentNode].data)
    setUnsaved(true)



  proc removeSearchElement() = #lol?
    if modeStatus == search:
      if searchResultsId.len > 0:
        if currentNode.len > 0:
          var bookmark = dataList.getSelection()
          dataBox.clear()
          dataList.clear()
          searchResultsId.delete(find(searchResultsId,currentNode))
          if currentNode in searchTitles:
            searchTitles.delete(find(searchTitles,currentNode))
          if currentNode in searchNotes:
            searchNotes.delete(find(searchNotes,currentNode))
          if searchResultsId.len > 0:
            dataList.setFocus()
            loadSearchChildren()
            displayChildrenTitles()
            if dataList.getCount() > bookmark:
              dataList.setSelection(bookmark)
              currentNode = currentChildren[bookmark]
            else:
              dataList.setSelection(bookmark-1)
              currentNode = currentChildren[bookmark-1]           
            currentParentId = tablex[currentNode].parent
            dataList.setFocus()
            dataBox.setValue(tablex[currentNode].data)
          else:
            currentNode.reset()
            currentParentId.reset()
            dataList.setFocus()
            loadSearchChildren()
            displayChildrenTitles()
    if modeStatus == starkx:
      if starkSeq.len > 0:
        if currentNode.len > 0:
          var bookmark = dataList.getSelection()
          dataBox.clear()
          dataList.clear()
          toggleStarkGUI(currentNode)
          if starkSeq.len > 0:
            dataList.setFocus()
            loadStarkChildren()
            displayChildrenTitles()
            if dataList.getCount() > bookmark:
              dataList.setSelection(bookmark)
              currentNode = currentChildren[bookmark]
            else:
              dataList.setSelection(bookmark-1)
              currentNode = currentChildren[bookmark-1]           
            currentParentId = tablex[currentNode].parent
            dataList.setFocus()
            dataBox.setValue(tablex[currentNode].data)
          else:
            currentNode.reset()
            currentParentId.reset()
            dataList.setFocus()
            loadStarkChildren()
            displayChildrenTitles()


  # A E S T E T H I C


  proc orderAZGUI() =
    if currentChildren.len > 0:
      if modeStatus == addx:
        tablex[currentParentId].children= orderAZ(tablex[currentParentId].children)
        currentChildren = tablex[currentParentId].children
      elif modeStatus == search:
        searchResultsId = orderAZ(searchResultsId)
        loadSearchChildren()
      elif modeStatus == starkx:
        starkSeq = orderAZ(starkSeq)
        loadStarkChildren()
      displayChildrenTitles()
      dataList.setSelection(find(currentChildren,currentNode))
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)



  proc orderLEGUI() =
    if currentChildren.len > 0:
      if modeStatus == addx:
        tablex[currentParentId].children= orderLE(tablex[currentParentId].children)
        currentChildren = tablex[currentParentId].children
      elif modeStatus == search:
        searchResultsId = orderLE(searchResultsId)
        loadSearchChildren()
      elif modeStatus == starkx:
        starkSeq = orderLE(starkSeq)
        loadStarkChildren()
      displayChildrenTitles()
      dataList.setSelection(find(currentChildren,currentNode))
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)





  # A E S T E T H I C



  proc contextSearchNodes(id : string, combomode : int) =
    if combomode == 0:
      if searchTerm != searchTerm.toLowerAscii() :
        var currentPar = id
        var currentChild = tablex[currentPar].children
        for i in currentChild:
          if tablex[i].title.find(searchTerm) > -1 :
            searchTitles.add(tablex[i].id)
          if tablex[i].children.len() > 0:
            contextSearchNodes(i, combomode)
        searchResultsId = searchTitles & searchNotes
        searchResultsId = searchResultsId.deduplicate
      else:
        var currentPar = id
        var currentChild = tablex[currentPar].children
        for i in currentChild:
          if tablex[i].title.toLowerAscii.find(searchTerm) > -1 :
            searchTitles.add(tablex[i].id)
          if tablex[i].children.len() > 0:
            contextSearchNodes(i, combomode)
        searchResultsId = searchTitles & searchNotes
        searchResultsId = searchResultsId.deduplicate
    
    elif combomode == 1:
      if searchTerm != searchTerm.toLowerAscii() :
        var currentPar = id
        var currentChild = tablex[currentPar].children
        for i in currentChild:
          if tablex[i].data.find(searchTerm) > -1 :
            searchNotes.add(tablex[i].id)
          if tablex[i].children.len() > 0:
            contextSearchNodes(i, combomode)
        searchResultsId = searchTitles & searchNotes
        searchResultsId = searchResultsId.deduplicate
      else:
        var currentPar = id
        var currentChild = tablex[currentPar].children
        for i in currentChild:
          if tablex[i].data.toLowerAscii.find(searchTerm) > -1 :
            searchNotes.add(tablex[i].id)
          if tablex[i].children.len() > 0:
            contextSearchNodes(i, combomode)
        searchResultsId = searchTitles & searchNotes
        searchResultsId = searchResultsId.deduplicate
    
    elif combomode == 2:
      if searchTerm != searchTerm.toLowerAscii() :
        var currentPar = id
        var currentChild = tablex[currentPar].children
        for i in currentChild:
          if tablex[i].title.find(searchTerm) > -1 :
            searchTitles.add(tablex[i].id)
          if tablex[i].data.find(searchTerm) > -1 :
            if tablex[i].id notin searchTitles:
              searchNotes.add(tablex[i].id)
          if tablex[i].children.len() > 0:
            contextSearchNodes(i, combomode)
        searchResultsId = searchTitles & searchNotes
        searchResultsId = searchResultsId.deduplicate
      else:
        var currentPar = id
        var currentChild = tablex[currentPar].children
        for i in currentChild:
          if tablex[i].title.toLowerAscii.find(searchTerm) > -1 :
            searchTitles.add(tablex[i].id)
          if tablex[i].data.toLowerAscii.find(searchTerm) > -1 :
            if tablex[i].id notin searchTitles:
              searchNotes.add(tablex[i].id)
          if tablex[i].children.len() > 0:
            contextSearchNodes(i, combomode)
        searchResultsId = searchTitles & searchNotes
        searchResultsId = searchResultsId.deduplicate



  proc comboLogic():int =
    if noteCheck.isChecked and nodeCheck.isChecked:
      return 2
    elif noteCheck.isChecked:
      return 1
    else:
      return 0



  # A E S T E T H I C



  proc wrapperSearchNodes() =
    if keep == false:
      searchResultsId.reset()
      searchTitles.reset()
      searchNotes.reset()
    if ctx == true and currentParentId.len > 0 :
      if tablex[currentParentId].children.len > 0:
        contextSearchNodes(currentParentId, comboLogic())
    else:
      contextSearchNodes(currentRootId, comboLogic())





  # A E S T E T H I C

  proc exportSingleNoteGUI()=
    if exportSingleNote(currentNode):
      status.setStatusText("Note Exported to: " & getString(prefs["exportPath"]))
    else:
      status.setStatusText(fmt"Please set up an [Export Path] in the [Preferences] panel")

  proc exportContext1to1GUI()=
    var retz : bool
    if modeStatus == addx:
      retz = exportContext1to1(tablex[tablex[currentNode].parent].children)
    if modeStatus == search and searchResultsId.len() > 0:
      retz = exportContext1to1(searchResultsId)
    if modeStatus == starkx and starkSeq.len() > 0:
      retz = exportContext1to1(starkSeq)
    if retz:
      status.setStatusText("Note Exported to: " & getString(prefs["exportPath"]))
    else:
      status.setStatusText(fmt"Please set up an [Export Path] in the [Preferences] panel")

  proc exportContextGUI() =
    var retz : bool
    var titleCTX : string
    if tablex[tablex[currentNode].parent].title.len() > 0:
      titleCTX = tablex[tablex[currentNode].parent].title
    else:
      titleCTX = "Note"
    if modeStatus == addx:
      retz = exportContext(titleCTX, tablex[tablex[currentNode].parent].children)
    elif modeStatus == search and searchResultsId.len() > 0:
      retz = exportContext(titleCTX, searchResultsId)
    elif modeStatus == starkx and starkSeq.len() > 0:
      retz = exportContext(titleCTX, starkSeq)
    if retz:
      status.setStatusText("Note Exported to: " & getString(prefs["exportPath"]))
    else:
      status.setStatusText(fmt"Please set up an [Export Path] in the [Preferences] panel")



  proc exportGlobalGUI(node : string)=
    if exportGlobal(node):
      status.setStatusText("Note Exported to: " & getString(prefs["exportPath"]))
    else:
      status.setStatusText(fmt"Please set up an [Export Path] in the [Preferences] panel")


  proc exportGlobal1to1GUI(id : string) =
    if modeStatus == addx:
      if exportGlobal1to1beta(id):
        status.setStatusText("Note Exported to: " & getString(prefs["exportPath"]))
      else:
        status.setStatusText(fmt"Please set up an [Export Path] in the [Preferences] panel")

  proc backupMakerGUI() =
    if backupMaker():
      status.setStatusText("Note Exported to: " & getString(prefs["exportPath"]))
    else:
      status.setStatusText(fmt"Please set up an [Export Path] in the [Preferences] panel")





  # A E S T E T H I C


  proc checkDobuleCheckandTripleCheckUnsaved() =
    if unsaved == true:
      setUnsaved(true)
    else:
      setUnsaved(false)



  proc checkUnsavedExit():bool =
    if unsaved == true:
      var answer = MessageDialog(frame,"You have unsaved changes.Save before quit? ", "Unsaved Changes", wYesNoCancel or wIconQuestion).display()
      case answer
      of widYes:
        save(getString(prefs["archivePath"]))
        frame.delete
        return true
      of widNo:
        frame.delete
        return true
      of widCancel:
        return false
      else:
        return true
    else:
      return true


  proc checkUnsaved():bool =
    if unsaved == true:
      var answer = MessageDialog(frame,"You have unsaved changes.Save before quit? ", "Unsaved Changes", wYesNoCancel or wIconQuestion).display()
      case answer
      of widYes:
        save(getString(prefs["archivePath"]))
        return true
      of widNo:
        return true
      of widCancel:
        return false
      else:
        return true
    else:
      return true




  # A E S T E T H I C

  proc setDisabled() =
    if dataBox.isenabled() == false:
      boxOne.setBackgroundColor(color=wLightGrey)
    if dataList.isenabled() == false:
      boxTwo.setBackgroundColor(color=wLightGrey)
    if inputSearch.isenabled() == false:
      boxThree.setBackgroundColor(color=wLightGrey)
    if inputList.isenabled() == false:
      boxFour.setBackgroundColor(color=wLightGrey)



  proc setColorW() =
    if dataBox.hasFocus():
      boxOne.setBackgroundColor(color=appliqueNotes)
      boxTwo.setBackgroundColor(-1)
      boxThree.setBackgroundColor(-1)
      boxFour.setBackgroundColor(-1)
    if dataList.hasFocus():
      boxOne.setBackgroundColor(-1)
      boxTwo.setBackgroundColor(color=appliqueNodes)
      boxThree.setBackgroundColor(-1)
      boxFour.setBackgroundColor(-1)    
    if inputSearch.hasFocus():
      boxOne.setBackgroundColor(-1)
      boxTwo.setBackgroundColor(-1)
      boxThree.setBackgroundColor(color=appliqueFind)
      boxFour.setBackgroundColor(-1)
    if inputList.hasFocus():
      boxOne.setBackgroundColor(-1)
      boxTwo.setBackgroundColor(-1)
      boxThree.setBackgroundColor(-1)
      boxFour.setBackgroundColor(color=appliqueAddNode)
    setDisabled()




  # A E S T E T H I C


  proc defaultTheme() =
    prefs["notesBgColor"] = 16777215
    prefs["nodesBgColor"] = 16777215
    prefs["findBgColor"] = 16777215
    prefs["addNodeBgColor"] = 16777215
    prefs["notesFontColor"] = 0
    prefs["nodesFontColor"] = 0
    prefs["findFontColor"] = 0
    prefs["addNodeFontColor"] = 0
    prefs["appliqueNotesColor"] = int(0x00BC8F8F)
    prefs["appliqueNodesColor"] = int(0x0099CC32)
    prefs["appliqueFindColor"] = int(0x00327FCC)
    prefs["appliqueAddNodeColor"] = int(0x00E78BE7)
    dataBox.setFont(defaultFont)
    dataList.setFont(defaultFont2)
    inputSearch.setFont(defaultFont2)
    inputList.setFont(defaultFont2)
    prefs["notesFontFaceName"] = ""
    prefs["nodesFontFaceName"] = ""
    prefs["findFontFaceName"] = ""
    prefs["addNodeFontFaceName"] = ""
    prefs["notesFontWeight"] = 400
    prefs["notesFontSize"] = 11
    prefs["nodesFontWeight"] = 400
    prefs["nodesFontSize"] = 9
    prefs["findFontWeight"] = 400
    prefs["findFontSize"] = 9
    prefs["addNodeFontWeight"] = 400
    prefs["addNodeFontSize"] = 9






  proc initColors() = #lol change pls
    if prefs["notesFontColor"] != -1 :
      dataBox.setForegroundColor(color = getInt(prefs["notesFontColor"]))
    if prefs["nodesFontColor"] != -1 :
      dataList.setForegroundColor(color = getInt(prefs["nodesFontColor"]))
    if prefs["findFontColor"] != -1 :
      inputSearch.setForegroundColor(color = getInt(prefs["findFontColor"]))
    if prefs["addNodeFontColor"] != -1 :
      inputList.setForegroundColor(color = getInt(prefs["addNodeFontColor"])) 

    if prefs["notesBgColor"] != -1 :
      dataBox.setBackgroundColor(color = getInt(prefs["notesBgColor"]))
    if prefs["nodesBgColor"] != -1 :
      dataList.setBackgroundColor(color = getInt(prefs["nodesBgColor"]))
    if prefs["findBgColor"] != -1 :
      inputSearch.setBackgroundColor(color = getInt(prefs["findBgColor"]))
    if prefs["addNodeBgColor"] != -1 :
      inputList.setBackgroundColor(color = getInt(prefs["addNodeBgColor"]))

    if prefs["appliqueNotesColor"] != -1 :
      appliqueNotes = getInt(prefs["appliqueNotesColor"])
    if prefs["appliqueNodesColor"] != -1 :
      appliqueNodes = getInt(prefs["appliqueNodesColor"])
    if prefs["appliqueFindColor"] != -1 :
      appliqueFind = getInt(prefs["appliqueFindColor"])
    if prefs["appliqueAddNodeColor"] != -1 :
      appliqueAddNode = getInt(prefs["appliqueAddNodeColor"])
      
   

  proc initFonts() =
    if prefs["notesFontFaceName"] != "" :
      var iniweight = getInt(prefs["notesFontWeight"])
      var iniface = getString(prefs["notesFontFaceName"])
      var inisize = getFloat(prefs["notesFontSize"])
      var initFont = Font(inisize, weight=iniweight, faceName=iniface)
      dataBox.setFont(initFont)
    if prefs["nodesFontFaceName"] != "" :
      var iniweight = getInt(prefs["nodesFontWeight"])
      var iniface = getString(prefs["nodesFontFaceName"])
      var inisize = getFloat(prefs["nodesFontSize"])
      var initFont2 = Font(inisize, weight=iniweight, faceName=iniface)
      dataList.setFont(initFont2)
    if prefs["findFontFaceName"] != "" :
      var iniweight = getInt(prefs["findFontWeight"])
      var iniface = getString(prefs["findFontFaceName"])
      var inisize = getFloat(prefs["findFontSize"])
      var initFont3 = Font(inisize, weight=iniweight, faceName=iniface)
      inputSearch.setFont(initFont3)
    if prefs["addNodeFontFaceName"] != "" :
      var iniweight = getInt(prefs["addNodeFontWeight"])
      var iniface = getString(prefs["addNodeFontFaceName"])
      var inisize = getFloat(prefs["addNodeFontSize"])
      var initFont4 = Font(inisize, weight=iniweight, faceName=iniface)
      inputList.setFont(initFont4)







  # A E S T E T H I C


  proc modifyOff()=
    if modFlag == true:
      modFlag = false
      inputList.clear()
      if modeStatus == addx:
        boxFour.label = "Add Node: "
        boxFour.hide()
        boxFour.show()
      if modeStatus == search:
        boxFour.label = "Replace: "
        boxFour.hide()
        boxFour.show()


  proc modifyNode()=
    if modFlag == true and currentNode == modCheck :
      tablex[currentNode].title = inputList.getValue()
      let now1 = now() 
      tablex[currentNode].ledit = now1.format("yyyy-MM-dd-HH-mm-ss")
      inputList.clear()
      displayChildrenTitles()
      dataList.setSelection(find(currentChildren,currentNode))
      dataList.setFocus()
      setUnsaved(true)
      status.setStatusText("Node Modified")
      modifyOff()
    else:
      modifyOff()


  proc activateModifyNode() =
    if currentNode.len() > 0 :
      modFlag = true
      boxFour.label = "Rename Node:"
      boxFour.hide()
      boxFour.show()
      inputList.enable()
      inputList.setFocus()
      modCheck = currentNode
      setColorW()
      inputList.setValue(tablex[currentNode].title)
      inputList.setSelection(0,tablex[currentNode].title.len())




  # A E S T E T H I C

  proc refreshNode() =
    if currentNode.len() > 0:
      dataBox.clear()
      dataBox.add(tablex[currentNode].data) 



  # A E S T E T H I C

  proc initNinjaRootGUI() =
    if modeStatus == docx:
      initNinjaRoot(doctitles, docxnotes)
    if modeStatus == prefx:
      initNinjaRoot(prefstitles, prefnotes)
    currentChildren = tablex["ninjaroot"].children
    displayChildrenTitles()
    currentParentId = "ninjaroot"
    currentNode = currentChildren[0]
    dataList.enable()
    dataList.setFocus()
    dataList.setSelection(find(currentChildren,currentNode))
    dataBox.clear()
    dataBox.add(tablex[currentNode].data)
    boxTwo.label = "Node List:"
    boxTwo.hide() 
    boxTwo.show()  
    setColorW()
    if modeStatus == prefx:
      helperButton.show()
      helperButton.enable()
      helperButton.connect(wEvent_Button) do (event: wEvent):

        if dataList.getSelection() == 0:
          var dirsnz = DirDialog(frame, message="Choose Export Directory", defaultPath = getAppDir(), style = wDdDirMustExist).display()
          tablex[currentNode].data = "The following folder is set for export " & dirsnz
          refreshNode()
          prefs["exportPath"] = dirsnz

        if dataList.getSelection() == 1:
          try:
            var fontsnz = FontDialog(frame).display()
            tablex[currentNode].data = fmt"The following Font was set: {fontsnz.getFacename()} - {$fontsnz.getWeight()} - {$fontsnz.getPointSize()}" 
            refreshNode()
            prefs["notesFontSize"] = fontsnz.getPointSize()
            prefs["notesFontWeight"] = fontsnz.getWeight()
            prefs["notesFontFaceName"] = fontsnz.getFacename()
            initFonts()
          except:
            discard

        if dataList.getSelection() == 2:
          try:
            var fontsnz = FontDialog(frame).display()
            tablex[currentNode].data = fmt"The following Font was set: {fontsnz.getFacename()} - {$fontsnz.getWeight()} - {$fontsnz.getPointSize()}" 
            refreshNode()
            prefs["nodesFontSize"] = fontsnz.getPointSize()
            prefs["nodesFontWeight"] = fontsnz.getWeight()
            prefs["nodesFontFaceName"] = fontsnz.getFacename()
            initFonts()
          except:
            discard

        if dataList.getSelection() == 3:
          try:
            var fontsnz = FontDialog(frame).display()
            tablex[currentNode].data = fmt"The following Font was set: {fontsnz.getFacename()} - {$fontsnz.getWeight()} - {$fontsnz.getPointSize()}" 
            refreshNode()
            prefs["findFontSize"] = fontsnz.getPointSize()
            prefs["findFontWeight"] = fontsnz.getWeight()
            prefs["findFontFaceName"] = fontsnz.getFacename()
            initFonts()
          except:
            discard

        if dataList.getSelection() == 4:
          try:
            var fontsnz = FontDialog(frame).display()
            tablex[currentNode].data = fmt"The following Font was set: {fontsnz.getFacename()} - {$fontsnz.getWeight()} - {$fontsnz.getPointSize()}" 
            refreshNode()
            prefs["addNodeFontSize"] = fontsnz.getPointSize()
            prefs["addNodeFontWeight"] = fontsnz.getWeight()
            prefs["addNodeFontFaceName"] = fontsnz.getFacename()
            initFonts()
          except:
            discard


        if dataList.getSelection() >= 5 and dataList.getSelection() < 17 :
          try:
            var colorsnz = ColorDialog(frame).display()
            tablex[currentNode].data = "The following color was set: " & $colorsnz
            refreshNode()
            prefs[prefhelper[dataList.getSelection()]] = colorsnz
            initColors()
          except:
            discard

        if dataList.getSelection() == 17 :
          try:
            tablex[currentNode].data = "Salmon Theme Set"
            refreshNode()
            salmonTheme()
            initColors()
          except:
            discard
   
        if dataList.getSelection() == 18 :
          try:
            tablex[currentNode].data = "Teal Theme Set"
            refreshNode()
            tealTheme()
            initColors()
          except:
            discard

        if dataList.getSelection() == 19 :
          try:
            tablex[currentNode].data = "Savana Theme Set"
            refreshNode()
            savanaTheme()
            initColors()
          except:
            discard

        if dataList.getSelection() == 20 :
          try:
            tablex[currentNode].data = "Metal Theme Set"
            refreshNode()
            metalTheme()
            initColors()
          except:
            discard

        if dataList.getSelection() == 21 :
          try:
            tablex[currentNode].data = "Default Theme (White) Set"
            refreshNode()
            defaultTheme()
            initColors()
          except:
            discard



    if modeStatus == docx:
      status.setStatusText("[Documentation Mode] press Esc to Exit")
      frame.title = fmt"{saveMark}{namedrop}{ver}- [Documentation Mode]"
    if modeStatus == prefx:
      status.setStatusText("[Preferences Mode] press Esc to Exit")
      frame.title = fmt"{saveMark}{namedrop}{ver}- [Preferences Mode]"





  # A E S T E T H I C


  proc generateGrandParents(childId : string) = 
    var parId = tablex[childId].parent
    if parId == currentRootId:
      tempGrandParentId.add(currentRootId)
      return
    else:
      tempGrandParentId.add(parId)
      generateGrandParents(parId)





  # A E S T E T H I C




  proc archiveElement()=
    if currentNode.len > 0:
      deepCopy(currentNode)
      cleanupChild(currentCopyId)
      tablex["archroot"].children.add(currentCopyId)
      tablex[currentCopyId].parent = "archroot"
      cleanCopyVars()
      inputList.clear()
      currentChildren = tablex[currentParentId].children
      displayChildrenTitles()
      currentNode = currentChildren[^1]
      dataList.setSelection(find(currentChildren,currentNode))
      dataBox.clear()
      dataBox.add(tablex[currentNode].data)
      status.setStatusText("Node pasted")
      starkSeqCheckArchive()
      setUnsaved(true)





  # A E S T E T H I C


  proc closedGUI() =
    modeStatus.reset()
    menuFile.disable()
    menuEdit.disable()
    menuNode.disable()
    menuCopy.disable()
    menuContext.disable()
    menuUtils.disable()
    menuHelp.disable()
    pasteContext.disable()
    plusButton.disable()
    minusButton.disable()
    keepCheck.disable()
    ctxCheck.disable()
    noteCheck.disable()
    nodeCheck.disable()
    searchButton.disable()
    addNodeButton.disable()
    boxFour.label = "Disabled: "
    boxFour.hide()
    boxFour.show()
    boxTwo.label = "Disabled:"
    boxTwo.hide() 
    boxTwo.show()  
    boxOne.label = "Disabled: "
    boxOne.hide()
    boxOne.show()
    boxThree.label = "Disabled: "
    boxThree.hide()
    boxThree.show()
    dataBox.clear()
    dataList.clear()
    inputList.clear()
    inputSearch.clear()
    dataBox.disable()
    dataList.disable()
    inputList.disable()
    inputSearch.disable()
    currentGrandParentid.reset()
    currentNode.reset()
    currentParentId.reset()
    currentParentPath.reset()
    searchTitles.reset()
    searchNotes.reset()
    searchResultsId.reset()
    tempGrandParentId.reset()
    bookmarkingSeq.reset()
    menuBar.refresh()
    keep.reset()
    modifyOff()



  proc openGUI() =
    modeStatus.reset()
    menuFile.enable()
    menuEdit.enable()
    menuNode.enable()
    menuCopy.enable()
    menuContext.enable()
    menuUtils.enable()
    menuHelp.enable()
    pasteContext.enable()
    plusButton.enable()
    minusButton.enable()
    keepCheck.enable()
    searchButton.enable()
    addNodeButton.enable()
    ctxCheck.enable()
    noteCheck.enable()
    nodeCheck.enable()
    dataBox.clear()
    dataList.clear()
    inputList.clear()
    dataBox.enable()
    dataList.enable()
    inputList.enable()
    inputSearch.enable()
    menuFile.enable(menuFile.findText("Save\tCtrl+S"))
    menuFile.enable(menuFile.findText("Save As .."))
    menuFile.enable(menuFile.findText("Add View"))
    menuFile.enable(menuFile.findText("Preferences"))
    menuEdit.enable(menuEdit.findText("Zoom in Node\tCtrl+Enter"))
    menuEdit.enable(menuEdit.findText("Zoom out Node\tCtrl+Backspace")) 
    menuEdit.enable(menuEdit.findText("Notes to Nodes\tCtrl+P"))
    menuEdit.enable(menuEdit.findText("Find Next\tCtrl+N"))
    menuEdit.enable(menuEdit.findText("Replace\tCtrl+R"))
    menuEdit.enable(menuEdit.findText("Replace all"))
    menuEdit.enable(menuEdit.findText("Notes to Nodes\tCtrl+P"))
    menuCopy.enable(menuCopy.findText("Paste\tF8"))
    menuNode.enable(menuNode.findText("Add Node\tCtrl+Down"))
    menuNode.enable(menuNode.findText("Add Node\tCtrl+Down"))
    menuCopy.enable(menuCopy.findText("Paste\tF8"))
    menuUtils.enable(menuUtils.findText("Bookmarks List"))
    menuContext.enable(menuContext.findText("Paste\tF8"))
    pasteContext.enable(pasteContext.findText("Paste\tF8"))
    modifyOff()



  # A E S T E T H I C



  proc activateNew() =
    frame.title = fmt"{saveMark}{namedrop}{ver}- [New Archive / Open Archive]"
    status.setStatusText("No archive detected. Create it or open an existing one")
    menuFile.enable()
    menuFile.disable(menuFile.findText("Save\tCtrl+S"))
    menuFile.disable(menuFile.findText("Save As .."))
    menuFile.disable(menuFile.findText("Preferences"))
    menuFile.disable(menuFile.findText("Add View"))



  proc activateStark() =
    modeStatus = starkx
    starkSeqCheckArchive()
    frame.title = fmt"{saveMark}{namedrop}{ver}- [Bookmarks Mode]"
    menuNode.disable(menuNode.findText("Add Node\tCtrl+Down"))
    menuEdit.disable()
    menuUtils.disable(menuUtils.findText("Bookmarks List"))
    menuCopy.disable(menuCopy.findText("Paste\tF8"))
    menuContext.disable(menuContext.findText("Paste\tF8"))
    if menuNode.findText("Delete Node\tCtrl+Del") != -1:
      menuNode[menuNode.findText("Delete Node\tCtrl+Del")].setText("Remove Node from list\tCtrl+Del")
      menuContext[menuContext.findText("Delete Node\tCtrl+Del")].setText("Remove Node from list\tCtrl+Del")
    plusButton.disable()
    minusButton.disable()
    inputList.disable()
    inputSearch.disable()
    ctxCheck.disable()
    keepCheck.disable()
    boxTwo.label = "Bookmarks:"
    boxTwo.hide() 
    boxTwo.show()  
    boxOne.label = "Note Box:"
    boxOne.hide()
    boxOne.show()
    dataBox.clear()
    dataList.clear()
    loadStarkChildren()
    displayChildrenTitles()
    currentGrandParentid.reset()
    currentNode = currentChildren[0]
    currentParentId = tablex[currentNode].parent
    dataList.setSelection(0)
    dataBox.setValue(tablex[currentNode].data)
    dataList.setFocus()
    status.setStatusText("[Bookmarks Mode] press Esc to Exit")



  proc activateSearch() =
    modeStatus = search
    frame.title = fmt"{saveMark}{namedrop}{ver}-{archMode} [Find Mode] Searching: '{searchTerm}'"
    menuNode.disable(menuNode.findText("Add Node\tCtrl+Down"))
    menuEdit.disable(menuEdit.findText("Notes to Nodes\tCtrl+P"))
    menuEdit.disable(menuEdit.findText("Notes to Sub-Nodes"))
    menuEdit.disable(menuEdit.findText("Notes to line-by-line Notes"))
    menuEdit.disable(menuEdit.findText("Zoom in Node\tCtrl+Enter"))
    menuEdit.disable(menuEdit.findText("Zoom out Node\tCtrl+Backspace"))
    menuCopy.disable(menuCopy.findText("Paste\tF8"))
    menuContext.disable(menuContext.findText("Paste\tF8"))
    if menuNode.findText("Delete Node\tCtrl+Del") != -1:
      menuNode[menuNode.findText("Delete Node\tCtrl+Del")].setText("Remove Node from list\tCtrl+Del")
      menuContext[menuContext.findText("Delete Node\tCtrl+Del")].setText("Remove Node from list\tCtrl+Del")
    status.setStatusText("[Find Mode] press Esc to Exit")
    plusButton.disable()
    minusButton.disable()
    keepCheck.enable()
    boxFour.label = "Replace:"
    boxFour.hide()
    boxFour.show()
    boxTwo.label = "Find Results:"
    boxTwo.hide() 
    boxTwo.show()  
    boxOne.label = "Note Box:"
    boxOne.hide()
    boxOne.show()
    boxThree.label = "Find:"
    boxThree.hide()
    boxThree.show()
    dataBox.clear()
    dataList.clear()
    loadSearchChildren()
    displayChildrenTitles()
    currentGrandParentid.reset()
    currentNode = currentChildren[0]
    currentParentId = tablex[currentNode].parent
    dataList.setSelection(0)
    dataBox.setValue(tablex[currentNode].data)
    findNextGUI()
    inputSearch.setFocus()



  proc reloadSearch() =
    dataBox.clear()
    dataList.clear()
    loadSearchChildren()
    displayChildrenTitles()
    currentGrandParentid.reset()
    currentNode = currentChildren[0]
    currentParentId = tablex[currentNode].parent
    dataList.setSelection(0)
    dataBox.setValue(tablex[currentNode].data)
    findNextGUI()
    inputSearch.setFocus()




  # A E S T E T H I C





  proc addMode()=
    if currentParentId == "ninjaroot" and tablex[currentRootId].children.len() > 0:
      dataList.clear()
      dataBox.clear()
      currentParentId = currentRootId
      currentNode = tablex[currentRootId].children[0]
      currentChildren = tablex[currentParentId].children
      displayChildrenTitles()
      dataList.setSelection(0)
      dataBox.setValue(tablex[currentNode].data)
      removeChild("ninjaroot")
    elif currentParentId == "ninjaroot" and tablex[currentRootId].children.len() == 0:
      currentParentId = currentRootId
      status.setStatusText(fmt"{currentParentPath}/..")
      removeChildGUI("ninjaroot")
    elif currentNode.len() > 0:
      dataList.clear()
      tempGrandParentId.reset()
      generateGrandParents(currentNode)
      tempGrandParentId.reverse(tempGrandParentId.low,tempGrandParentId.high)
      currentParentId = tempGrandParentId[^1]
      currentGrandParentid = tempGrandParentId[0 .. ^ 2]
      currentChildren = tablex[currentParentId].children
      displayChildrenTitles()
      dataList.setSelection(find(currentChildren,tablex[currentNode].id))
      dataBox.clear()
      dataBox.setValue(tablex[currentNode].data)
      currentParentPath = "/" & generatePathUtilsPar(currentNode)
      status.setStatusText(currentParentPath & "/" & tablex[currentNode].title)
    elif currentNode.len() == 0 and tablex[currentRootId].children.len() > 0:
      dataList.clear()
      dataBox.clear()
      currentNode = tablex[currentRootId].children[0]
      currentParentId = currentRootId
      currentChildren = tablex[currentParentId].children
      currentGrandParentid.reset()
      currentParentPath = ""
      displayChildrenTitles()
      dataList.setSelection(0)
      dataBox.setValue(tablex[currentNode].data)
    elif tablex[currentRootId].children.len() == 0:
      currentParentId = currentRootId
      currentGrandParentid.reset()
      currentChildren.reset()
      status.setStatusText(fmt"{currentParentPath}/..")
    if tablex.haskey("ninjaroot"):
      removeChild("ninjaroot")
    searchTitles.reset()
    searchNotes.reset()
    searchResultsId.reset()
    tempGrandParentId.reset()
    keep.reset()
    keepCheck.setValue(false)
    inputSearch.clear()
    bookmarkingSeq.reset()
    modeStatus = addx
    frame.title = fmt"{saveMark}{namedrop}{ver}- [{archiveName}]{archMode}"
    menuEdit.disable(menuEdit.findText("Find Next\tCtrl+N"))
    menuEdit.disable(menuEdit.findText("Replace\tCtrl+R"))
    menuEdit.disable(menuEdit.findText("Replace all"))
    if menuNode.findText("Delete Node\tCtrl+Del") == -1:
      menuNode[menuNode.findText("Remove Node from list\tCtrl+Del")].setText("Delete Node\tCtrl+Del")
      menuContext[menuContext.findText("Remove Node from list\tCtrl+Del")].setText("Delete Node\tCtrl+Del")
    boxFour.label = "Add Node:"
    boxFour.hide()
    boxFour.show()
    boxTwo.label = "Node List:"
    boxTwo.hide() 
    boxTwo.show()  
    boxOne.label = "Note Box:"
    boxOne.hide()
    boxOne.show()
    boxThree.label = "Find:"
    boxThree.hide()
    boxThree.show()
    keepCheck.disable()
    status.setStatusText("")
    dataList.setFocus()
    setColorW()



  # A E S T E T H I C



  proc loadGUI(path : string) =
    var xkz = load(path)
    if failedToLoad == true:
      failedToLoad.reset()
      counter = 0
      starkSeq.reset()
      tablex.reset()
      closedGUI()
      activateNew()
    else:
      counter = 0
      starkSeq.reset()
      tablex.reset()
      counter = xkz[0]
      starkSeq = xkz[1]
      tablex = xkz[2]
      starkSeqCheck()
      archiveName = extractFilename(getString(prefs["archivePath"]))
      unsaved = false
      closedGUI()
      openGUI()
      addmode()





  proc newHandler() =
    let filesnz = FileDialog(frame, message="Create a new archive", defaultDir = getAppDir(), defaultFile = "koWloon", style = wFdSave or wFdOverwritePrompt, wildcard = "KGN files (*.kgn)|*.kgn").display()
    if filesnz.len != 0:
      if tablex.len() > 0:
        tablex.reset()
      if counter > 0:
        counter = 0
      var filex = filesnz[0] & ".kgn"
      var helloworld = Thingy()
      helloworld.id = "root"
      helloworld.title = "root"
      helloworld.s.incl(root)
      var helloworld2 = Thingy()
      helloworld2.id = "archroot"
      helloworld2.title = "archroot"
      tablex["root"] = helloworld
      tablex["archroot"] = helloworld2  
      prefs["archivePath"] = filex
      save(getString(prefs["archivePath"]))
      loadGUI(getString(prefs["archivePath"]))



  proc openHandler() =
    let filesnz = FileDialog(frame, message="Open an archive", defaultDir = getAppDir(), style = wFdOpen or wFdFileMustExist, wildcard = "*.kgn").display()
    if filesnz.len != 0:
      prefs["archivePath"] = filesnz[0]
      loadGUI(filesnz[0])


  proc saveAsHandler() =
    let filesnz = FileDialog(frame, message="Save as a new archive", defaultDir = getAppDir(), defaultFile = "koWloon", style = wFdSave or wFdOverwritePrompt, wildcard = "KGN files (*.kgn)|*.kgn").display()
    if filesnz.len != 0:
      var filex = filesnz[0] & ".kgn"
      prefs["archivePath"] = filex
      setUnsaved(false)
      save(getString(prefs["archivePath"]))
      status.setStatusText("Saved as " & getString(prefs["archivePath"]))
      loadGUI(filex)


  # A E S T E T H I C



  proc toggleArchive()=
    if currentRootId == "root":
      currentRootId = "archroot"
      archMode = "  .:Archive:."
    else:
      currentRootId = "root"
      archMode = ""
    currentNode.reset()
    currentChildren.reset()
    currentParentId.reset()
    currentGrandParentid.reset()
    addmode()


  # A E S T E T H I C



  dataBox.wEvent_Text do (event: wEvent):
    frame.startTimer(0.75) #fast enough?
    bling()

  frame.wEvent_Timer do (event: wEvent):
    updateDataBox()
    frame.stopTimer()
    blang()


  dataList.wEvent_ListBox do (event: wEvent):
    setColorW()
    modifyOff()
    if dataList.getSelection() != -1:
      if modeStatus == search:
        currentNode = currentChildren[dataList.getSelection()]
        currentParentId = tablex[currentNode].parent
        dataBox.clear()
        dataBox.add(tablex[currentNode].data)
        findNextGUI()
        dataBox.showPosition(0)
        dataList.setFocus()
        status.setStatusText("/" & generatePathUtils(currentNode))
      elif modeStatus == addx and currentChildren.len > 0:
        currentNode = currentChildren[dataList.getSelection()]
        #currentParentId = tablex[currentNode].parent #pilot
        status.setStatusText(currentParentPath & "/" & tablex[currentNode].title)
        dataBox.clear()
        dataBox.add(tablex[currentNode].data)
        dataBox.showPosition(0)
        dataList.setFocus()
      elif modeStatus == starkx:
        currentNode = currentChildren[dataList.getSelection()]
        currentParentId = tablex[currentNode].parent
        dataBox.clear()
        dataBox.add(tablex[currentNode].data)
        dataBox.showPosition(0)
        dataList.setFocus()
        status.setStatusText("/" & generatePathUtils(currentNode))
      elif modeStatus == docx or modeStatus == prefx:
        currentNode = currentChildren[dataList.getSelection()]
        dataBox.clear()
        dataBox.add(tablex[currentNode].data) 
        dataBox.showPosition(0)
        dataList.setFocus()


  inputSearch.wEvent_TextEnter do (event: wEvent):
    if inputSearch.getValue() == searchTerm and searchTerm.len > 0:
      findNextGUI()
      inputSearch.setFocus()
    else:
      searchTerm = inputSearch.getValue()
      if searchTerm.len > 0 and tablex[currentRootId].children.len > 0:
        wrapperSearchNodes()
        if searchResultsId.len() > 0:
          if modeStatus == addx:
            openGUI()
            activateSearch()
          elif modeStatus == search:
            reloadSearch()
        else:
          status.setStatusText("Found no results :(")
          if currentChildren.len == 0:
            currentNode.reset()
            currentParentId.reset()
      else:
        status.setStatusText("Please have at least one node to search, and search at least one character")



  searchButton.connect(wEvent_Button) do (event: wEvent):
    if inputSearch.getValue() == searchTerm and searchTerm.len > 0:
      findNextGUI()
      inputSearch.setFocus()
    else:
      searchTerm = inputSearch.getValue()
      wrapperSearchNodes()
      if searchTerm.len > 0 and tablex[currentRootId].children.len > 0:
        if searchResultsId.len() > 0:
          if modeStatus == addx:
            openGUI()
            activateSearch()
          elif modeStatus == search:
            reloadSearch()
        else:
          status.setStatusText("Found no results :(")
          if currentChildren.len == 0:
            currentNode.reset()
            currentParentId.reset()
      else:
        status.setStatusText("Please have at least one node to search, and search at least one character")




  inputList.wEvent_TextEnter do (event: wEvent):
    if inputList.hasFocus():
      if modFlag == false:
        if modeStatus == addx:
          addChildGUI()
          status.setStatusText("New node added")
        elif modeStatus == search:
          replaceGUI()
      else:
        modifyNode()  




  dataList.wEvent_ListBoxDoubleClick do (event: wEvent):
    if modeStatus == addx:
      if currentNode.len() > 0:
        if dataList.getSelection in 0 .. currentChildren.len()-1:
          getInsideGUI()
    elif modeStatus == search or modeStatus == starkx :
      if currentNode.len() > 0:
        if dataList.getSelection in 0 .. currentChildren.len()-1:
          openGUI()
          addmode()

  frame.idPlus do ():
    if modeStatus == addx:
      if currentNode.len() > 0:
        getInsideGUI()
    elif modeStatus == search or modeStatus == starkx :
      openGUI()
      addmode()


  frame.idPlusPlus do ():
    if modeStatus == addx:
      if currentNode.len() > 0:
        getInsideGUI()
    elif modeStatus == search or modeStatus == starkx :
      openGUI()
      addmode()


  addnodeButton.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Add node")

  addnodeButton.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")



  plusButton.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Zoom in to subnodes")

  plusButton.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")


  minusButton.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Zoom out to parent node")

  minusButton.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")


  searchButton.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Search")

  searchButton.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")


  nodeCheck.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Restricts search to Node only")

  nodeCheck.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")


  noteCheck.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Restricts search to Note only")

  noteCheck.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")



  ctxCheck.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Restricts search to current Node and its subnodes")

  ctxCheck.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")


  keepCheck.wEvent_MouseEnter do (event: wEvent):
    status.setStatusText("Stacks new Searches on top of results of old ones")

  keepCheck.wEvent_MouseLeave do (event: wEvent):
    status.setStatusText("")


  plusButton.connect(wEvent_Button) do (event: wEvent):
    if currentNode.len() > 0:
     getInsideGUI()

  minusButton.connect(wEvent_Button) do (event: wEvent):
    if modeStatus == addx:
      getOutsideGUI()


  addnodeButton.connect(wEvent_Button) do (event: wEvent):
    if modFlag == false:
      if modeStatus == addx:
        addChildGUI()
        status.setStatusText("New node added")
      elif modeStatus == search:
        replaceGUI()
    else:
      modifyNode()  






  noteCheck.wEvent_CheckBox do (event: wEvent):
    if noteCheck.isChecked == false:
      nodeCheck.setValue(true)

  nodeCheck.wEvent_CheckBox do (event: wEvent):
    if nodeCheck.isChecked == false:
      noteCheck.setValue(true)



  keepCheck.wEvent_CheckBox do (event: wEvent):
    if keepCheck.isChecked:
      keep = true
      status.setStatusText("Keep your current results for incremental searches")
    else:
      keep = false
      status.setStatusText("Keep disabled")

  ctxCheck.wEvent_CheckBox do (event: wEvent):
    if ctxCheck.isChecked:
      ctx = true
      status.setStatusText(fmt"Search only from current context inward")
    else:
      ctx = false
      status.setStatusText("Global search enabled")




  frame.wEvent_Close do (event: wEvent):
    if checkUnsavedExit():
      frame.delete
    else:
      event.veto()


  frame.idSingleCopy do ():
    singleCopyGUI()


  frame.idFlatCopy do ():
    flatCopyGUI()

  frame.idDeepCopy do ():
    deepCopyGUI()


  frame.idDeepCut do ():
    deepCutGUI()


  frame.idPaste do ():
    pasteGUI()


  dataBox.wEvent_SetFocus do (event: wEvent):
    setColorW()
    event.skip()

  inputSearch.wEvent_SetFocus do (event: wEvent):
    setColorW()
    event.skip()

  inputList.wEvent_SetFocus do (event: wEvent):
    setColorW() 
    event.skip() 


  boxTwo.wEvent_ContextMenu do (event: wEvent):
    if currentNode.len > 0:
      if modeStatus == addx or modeStatus == search or modeStatus == starkx:
        if dataList.hitTest(event.mousePos[0],event.mousePos[1]) != -1:
          datalist.setSelection(dataList.hitTest(event.mousePos[0],event.mousePos[1]))
          currentNode = currentChildren[dataList.getSelection()]
          status.setStatusText(currentParentPath & "/" & tablex[currentNode].title)
          frame.popupMenu(menuContext)
        else:
          frame.popupMenu(pasteContext)


  frame.idModify do ():
      activateModifyNode()

  frame.idReplace do ():
    replaceGUI()

  frame.idDocx do ():
    closedGUI()
    modeStatus = docx
    initNinjaRootGUI()


  frame.idPrefs do ():
    closedGUI()
    modeStatus = prefx
    initNinjaRootGUI()


  frame.idReplaceAll do ():
    replaceAllGUI()



  frame.idMinus do ():
    if modeStatus == addx:
      getOutsideGUI()

  frame.idNotesToNodes do ():
    notesToNodes()

  frame.idNotesToSubNodes do ():
    notesToSubNodes()

  frame.idNotesToSubNodesPivot do ():
    notesToSubNodesPivot()

  frame.idNotesToNotes do ():
    notesToNotes()


  frame.idUp do ():
    if inputList.hasFocus():
      dataList.setFocus()
      setColorW()
    if inputSearch.hasFocus():
      dataBox.setFocus()
      setColorW()

  frame.idDown do ():
    if dataBox.hasFocus():
      inputSearch.setFocus()
      setColorW()
    if dataList.hasFocus():
      inputList.setFocus()
      setColorW()

  frame.idLeft do ():
    if dataList.hasFocus():
      dataBox.setFocus()
      setColorW()
    if inputList.hasFocus():
      inputSearch.setFocus()
      setColorW()

  frame.idRight do ():
    if dataBox.hasFocus():
      dataList.setFocus()
      setColorW()
    if inputSearch.hasFocus():
      inputList.setFocus()
      setColorW()


  frame.idSwapDown do ():
    if currentNode.len() > 0:
      if dataList.hasFocus():
        if modeStatus == addx:
          swapNextGUI()
        elif modeStatus == search or modeStatus == starkx :
          swapNextContextGUI()



  frame.idSwapUp do ():
    if currentNode.len() > 0:
      if dataList.hasFocus():
        if modeStatus == addx:
          swapPreviousGUI()
        elif modeStatus == search or modeStatus == starkx :
          swapPreviousContextGUI()


  frame.idRefresh do ():
    refreshNode()

  frame.idRemove do ():
    if modeStatus == addx:
      if dataList.getCount() > 0 and currentNode.len() > 0:
        removeChildGUI(currentNode)
        status.setStatusText("Node deleted")
    elif modeStatus == search or modeStatus == starkx :
      removeSearchElement()


  frame.idClipboard do ():
    getSingleNodeAsBlob()


  frame.idClipboards do ():
    getCurrentListAsBlob()

  frame.idFindNext do ():
    if modeStatus == search:
      findNextGUI()

  frame.idBackup do ():
    backupMakerGUI()


  frame.idExportNote do ():
    if currentNode.len() > 0:
      exportSingleNoteGUI()
    else:
      status.setStatusText("Select a node")

  frame.idExportContext do ():
    if currentNode.len() > 0:
      exportContextGUI()
    else:
      status.setStatusText("Select a node")

  frame.idExportContext1to1 do ():
    if currentNode.len() > 0:
      exportContext1to1GUI()
    else:
      status.setStatusText("Select a node")

  frame.idExportGlobal1to1 do ():
    if currentNode.len() > 0:
      exportGlobal1to1GUI(currentNode)
    else:
      status.setStatusText("Select a node")

  frame.idExportGlobal do ():
    if currentNode.len() > 0:
      exportGlobalGUI(currentNode)

  frame.idExit do ():
    if checkUnsavedExit():
      frame.delete


  frame.idOrderAZ do ():
    if currentNode.len > 0:
      orderAZGUI()

  frame.idOrderLE do ():
    if currentNode.len > 0:
      orderLEGUI()


  frame.idAddView do ():
    main(false)



  frame.idEsc do ():
    if modeStatus == prefx:
      helperButton.disable()
      helperButton.hide()
      openGUI()
      addmode()
    elif modeStatus != addx:
      openGUI()
      addmode()
    testes()


  frame.wEvent_SetFocus do (event: wEvent):
    checkDobuleCheckandTripleCheckUnsaved()
    if currentChildren.len > 0:
      if modeStatus == addx:
        currentChildren = tablex[currentParentId].children
        displayChildrenTitles()
        if currentNode in currentChildren:
          refreshNode()
      if modeStatus == starkx:
        currentChildren = starkSeq
        displayChildrenTitles()
        if currentNode in currentChildren:
          refreshNode()

  

  frame.idToggleStarks do ():
    if currentNode.len > 0:
      toggleStarkGUI(currentNode)
      dataList.setSelection(find(currentChildren,tablex[currentNode].id))




  frame.idMail do ():
    if currentNode.len > 0:
      var temp = tablex[currentNode].data.replace("\n", "%0d%0a")
      ShellExecute(0, "open", fmt"mailto:empty@empty.com?subject={tablex[currentNode].title}&body={temp}", nil, nil, 5)


  frame.idMailContext do ():
    if currentChildren.len > 0:
      var temp = mailtoContext(currentChildren)
      ShellExecute(0, "open", fmt"mailto:empty@empty.com?subject={tablex[currentParentId].title}&body={temp}", nil, nil, 5)


  frame.idArchiveElement do ():
    if currentNode.len > 0:
      archiveElement()


  frame.idToggleArchive do ():
    toggleArchive()


  frame.idStarkList do ():
    if starkSeq.len > 0:
      openGUI()
      activateStark()

  frame.idNew do ():
    if checkUnsaved():
      newHandler()

  frame.idOpen do ():
    if checkUnsaved():
      openHandler()

  frame.idSave do ():
    save(getString(prefs["archivePath"]))
    setUnsaved(false)
    status.setStatusText("Saved")

  frame.idSaveAs do ():
    if checkUnsaved():
      saveAsHandler()

  frame.idAbout do ():
    createChildThreadAbouts()



  frame.idCheckUpdates do ():
    createChildThreadUpdate()



  initFonts()
  initColors()
  if bootstarter == true:
    loadGUI(getString(prefs["archivePath"]))
  else:
    addMode()





  panel.wEvent_Size do ():
    layout()

  layout()
  frame.center()
  frame.show()
  app.mainLoop()



main(true)