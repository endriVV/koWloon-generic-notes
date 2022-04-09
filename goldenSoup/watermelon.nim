import std / [tables]



type
  MyFlag* = enum
    stark
    root
    synchro
    tracked


type
  Thingy* = ref object
    id*: string
    title*: string
    data*: string
    children* : seq[string]
    parent* : string
    ledit* : string
    s* : set[MyFlag]
    m* : seq[string]

var tablex* = initTable[string, Thingy]()
var counter* : int
var starkSeq* : seq[string]