import std / [tables]

import watermelon
import cigarette



proc starkSeqCheck*() =
  var starkCopy = starkSeq
  for i,v in starkCopy:
    if tablex.hasKey(v) == false or stark notin tablex[v].s:
      starkSeq.delete(i)


proc starkSeqCheckArchive*() =
  var starkCopy = starkSeq
  for i,v in starkCopy:
    if generatePathUtilsForStarkCheck(v) == "archroot":
      starkSeq.delete(i)
      tablex[v].s.excl(stark)





proc checkSpecialDelete*() =
  starkSeqCheck()