import std / [tables]

import watermelon
#import realestate



proc starkSeqCheck*() =
  var starkCopy = starkSeq
  for i,v in starkCopy:
    if tablex.hasKey(v) == false or stark notin tablex[v].s:
      starkSeq.delete(i)




proc checkSpecialDelete*() =
  starkSeqCheck()