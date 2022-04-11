import tables
import watermelon

var count2 = 0
var count3 = 0
var count4 = 0
var count5 = 0


proc test3(parent : string) =
  for i in tablex[parent].children:
    if tablex[parent].id != tablex[i].parent:
      count3 = count3 + 1
    else:
      count4 = count4 + 1
    if tablex[i].children.len > 0:
      test3(i)



proc test2(parent : string) =
  count2 = count2 + tablex[parent].children.len()
  for i in tablex[parent].children:
    if tablex[i].children.len > 0:
      test2(i)


proc test4() =
  for i in starkSeq:
    if tablex.hasKey(i) == false or stark notin tablex[i].s:
      count5 += 1




proc testes*() =
  echo "Elems in tablex: " & $(len(tablex) - 2)
  test2("root")
  echo "Nr. of Nodes: " & $count2
  count2 = 0
  test2("archroot")
  echo "Nr. of Archive Nodes: " & $count2


  test3("root")
  echo "Nr. of malformend Nodes: " & $count3
  echo "Nr. of wellformed Nodes: " & $count4
  count3 = 0
  count4 = 0
  test3("archroot")
  echo "Nr. of malformend archive Nodes: " & $count3
  echo "Nr. of wellformed archive Nodes: " & $count4
  

  test4()
  echo "Nr. of StarSeq elems who are not stark: " & $count5
  count2 = 0
  count3 = 0
  count4 = 0
  count5 = 0
