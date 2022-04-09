#I like hardcoding my strings, sue me I have lawyers

var doctitles* : seq[string]
var docxnotes* : seq[string]

doctitles.add("General")
doctitles.add("Shortcuts")
doctitles.add("Notes")
doctitles.add("Find")
doctitles.add("Delete Node")
doctitles.add("Copying Nodes")
doctitles.add("Export")
doctitles.add("Archive")
doctitles.add("Minor Functionality")
doctitles.add("Non Core Functionality")
doctitles.add("Known limitations")


docxnotes.add("""
Welcome to koWloon (generic) notes:""" & "\r\n" & """
""" & "\r\n" & """
- The basic premise of this app is that a Note (anything on the left panel) is always attached to a Node (right panel).""" & "\r\n" & """
- Nodes acts like the title for the note. """ & "\r\n" & """
- The present note is attached to the General node on the right -> """ & "\r\n" & """
""" & "\r\n" & """
- Nodes also act like folders / subfolders, and can have multiple subnodes.""" & "\r\n" & """
- If a node contains subnotes it will be marked with a ➕ prefix
""")

docxnotes.add("""
The program is structured with four main panels always visible. """ & "\r\n" & """
- [CTRL + Arrows] shortcuts allow for fast keyboard navigation between panels. """ & "\r\n" & """
- [CTRL + Enter] and [CTRL + Backspace] perform fast navigation in and outside nodes. """ & "\r\n" & """ 
More shortcuts are discoverable in the menu descriptions.
""")

docxnotes.add("""
- Changes to Notes are auto-committed to a Node on a timer, a floppy visual indicator on the statusbar will signal this action.
""")

docxnotes.add("""
- Find is by default case unsensitive when search is lowercase and Case Sensitive when search has one or more upppercase.""" & "\r\n" & """
- Find is by default global and searching [Nodes only]. [Combo] options can set the search for [Notes only] or both [Nodes and Notes]. """ & "\r\n" & """
- [Ctx] control can limit search only from current node onwards. """ & "\r\n" & """
- [Keep] control can stacks multiple successive searches on the find result panel. """ & "\r\n" & """
- Find highlights found Nodes as 🔗 and found Notes as ✏️
""")

docxnotes.add("""
- [Delete Node] will remove a Node and massively all its subnotes. """ & "\r\n" & """
since changes are committed only when [Save] is expressely activated, a mistaken delete can be reverted by just exiting the program without saving.
""")

docxnotes.add("""
- [Copy] functionality is provided to copy either a single node or the visible nodes in the current context or deep copying a node and all its subnodes.
""")

docxnotes.add("""
- [Export] functionality is provided to export to plain text a single node or the visible nodes in the current context or a node and all its subnodes. """ & "\r\n" & """
- Before exporting, please set up [exportPath] option found in the [Preferences] menu.""" & "\r\n" & """
""" & "\r\n" & """
- [Export 1on1] both in context and deep versions will generate a single file for each node. """ & "\r\n" & """
- It can take a long time to complete this kind of export when many nodes are involved. """ & "\r\n" & """
- it is suggested to use it when the number of nodes is limited or use the alternative non 1on1 export options.
""")

docxnotes.add("""
- [Archive] will tranfer a Node to a hidden Archive Node, to browse it find the Archive list on the menus.
""")


docxnotes.add("""
- [Notes to Node]  Will transform each line of a note in a new node.""" & "\r\n" & """
- [Node(s) to Clipboard] Will copy to clipboard the name of the current Node(s).""" & "\r\n" & """
- [Order Nodes A-Z] Will order the current Nodes from A to Z. """ & "\r\n" & """
- [Order Nodes Last-Edit] Will order the current Nodes in order of last editing.""" & "\r\n" & """
- [Add View] Will open a new window with view on the same .kgn data.
- [Backup] Will make a copy in your [Export Path] of the data archive in .kgn format and exported plain text.
""")

docxnotes.add("""
WIP
""")

docxnotes.add("""
 - Single notes can be up to 32k in size (which is comparable to 10 pages of a Word document afaik), Notes could go over that size if treated as RTF, but the feature is yet to be implemented
""" & "\r\n" & """
 - Scrolling and updating of the Node List panel can result slow or sluggish on some older computers.
""")


# A E S T E T H I C


var prefstitles* : seq[string]
var prefnotes* : seq[string]
var prefhelper* : seq[string]


prefstitles.add("Export Path")   #this order must not be changed
prefstitles.add("Notes Box Font")
prefstitles.add("Nodes List Font")
prefstitles.add("Find Field Font")
prefstitles.add("Add Note Field Font")
prefstitles.add("Notes Box Font Color")
prefstitles.add("Nodes List Font Color")
prefstitles.add("Find Field Font Color")
prefstitles.add("Add Note Field Font Color")
prefstitles.add("Notes Box Bg Color")
prefstitles.add("Nodes List Bg Color")
prefstitles.add("Find Field Bg Color")
prefstitles.add("Add Note Field Bg Color")
prefstitles.add("Notes Box Applique")
prefstitles.add("Nodes List Applique")
prefstitles.add("Find Field Applique")
prefstitles.add("Add Note Field Applique")
prefstitles.add("Salmon Color Theme")
prefstitles.add("Teal Color Theme")
prefstitles.add("Savana Color Theme")
prefstitles.add("Metal Color Theme")
prefstitles.add("Default Theme")


prefnotes.add("Sets the folder to [Export] in plain text and [Backup]. Use [Setter] button to set")   #this order must not be changed
prefnotes.add("Sets the Font for the Notes Box. Use [Setter] button to set")
prefnotes.add("Sets the Font for the Nodes List. Use [Setter] button to set")
prefnotes.add("Sets the Font for the Find Field. Use [Setter] button to set")
prefnotes.add("Sets the Font for the Add Note Field. Use [Setter] button to set")
prefnotes.add("Sets the Font Color for the Notes Box. Use [Setter] button to set")
prefnotes.add("Sets the Font Color for the Nodes List. Use [Setter] button to set")
prefnotes.add("Sets the Font Color for the Find Field. Use [Setter] button to set")
prefnotes.add("Sets the Font Color for the Add Note Field. Use [Setter] button to set")
prefnotes.add("Sets the Background Color for the Notes Box. Use [Setter] button to set")
prefnotes.add("Sets the Background Color for the Nodes List. Use [Setter] button to set")
prefnotes.add("Sets the Background Color for the Find Field. Use [Setter] button to set")
prefnotes.add("Sets the Background Color for the Add Note Field. Use [Setter] button to set")
prefnotes.add("Sets the Color of the Focus component of the Notes Box")
prefnotes.add("Sets the Color of the Focus component of the Nodes List")
prefnotes.add("Sets the Color of the Focus component of the Find Field")
prefnotes.add("Sets the Color of the Focus component of the Add Note Field")
prefnotes.add("Sets the Color Scheme of the app to Salmon")
prefnotes.add("Sets the Color Scheme of the app to Teal")
prefnotes.add("Sets the Color Scheme of the app to Savana")
prefnotes.add("Sets the Color Scheme of the app to Metal")
prefnotes.add("Resets the Color Scheme to Default")



prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("notesFontColor")
prefhelper.add("nodesFontColor")
prefhelper.add("findFontColor")
prefhelper.add("addNodeFontColor")
prefhelper.add("notesBgColor")
prefhelper.add("nodesBgColor")
prefhelper.add("findBgColor")
prefhelper.add("addNodeBgColor")
prefhelper.add("appliqueNotesColor")
prefhelper.add("appliqueNodesColor")
prefhelper.add("appliqueFindColor")
prefhelper.add("appliqueAddNodeColor")
prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("..")
prefhelper.add("..")