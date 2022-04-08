import strutils
import math
import algorithm
#import std/random   #for testing
#randomize()

proc divmod*(a, b: int):tuple[res,remainder:int] =
  var res = a div b      
  var remainder = a mod b
  return (res,remainder)


proc base64encode*(number : int, alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"): string=
    var number = number
    var reminder : int
    var base : string
    var sign : string

    if number < 0:
        sign = "-"
        number = -number

    if 0 <= number and number < len(alphabet):
        return sign & alphabet[number]

    while number != 0:
        (number, reminder) = divmod(number, len(alphabet))
        base = $alphabet[reminder] & base
    return  sign & base


proc base64decode*(input : string, alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):int =
    var sign : bool
    var reverse : string
    if input[0] == '-':
        sign = true
        reverse = input[1 .. ^1]
    else:
        reverse = input
    reverse.reverse()
    var pos : int
    var rez : int
    for i in reverse:
        rez += alphabet.find(i) * len(alphabet)^pos
        pos = pos + 1
    if sign == true:
        return -rez
    else:
        return rez

#works with different bases
#var alpha36= "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"


#[ 
#TESTING


for i in 0 .. 1000:
    var rand = rand(1000000)
    var randn = -rand
    assert rand == base64decode(base64encode(rand))
    assert randn == base64decode(base64encode(randn))

]#


