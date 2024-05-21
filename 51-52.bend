# This file solves both Leetcode Problem #51 (solveNQueens), and Problem #52 (totalNQueens)

object Attack {col, diag1, diag2}

def next(x):
  open Attack: x
  return Attack{col: x.col, diag1: x.diag1 / 2, diag2: (x.diag2 * 2) & 0x8fffff}

def add(x, y):
  open Attack: x
  open Attack: y
  return Attack{
    col: x.col | y.col,
    diag1: x.diag1 | y.diag1,
    diag2: x.diag2 | y.diag2
  }

def sum(x):
  open Attack: x
  return x.col | x.diag1 | x.diag2

def from(col):
  return Attack{
    col: col,
    diag1: col,
    diag2: col
  }


def getQueens(n, row, attack):
  if row > n:
    return List/Nil 
  else:
    bend i = 1, c = 0:
      when c < n:
        if((sum(attack) & i) == 0):
          list = mergeLists(
            numberToList((row, c), 
              getQueens(n, row+1, next(add(attack, from(i))))
            ), 
            fork(i * 2, c + 1)
          )
        else:
          list = fork(i * 2, c + 1) 
      else: 
        list = List/Nil
    return list

def filter(list, n):
  fold list:
    case List/Cons:
      if len(list.head) == n:
        return List/Cons{
          head: list.head,
          tail: list.tail
        }
      else:
        return list.tail
    case List/Nil:
      return List/Nil

def len(list):
  fold list:
    case List/Cons:
      return 1 + list.tail
    case List/Nil:
      return 0

def numberToList(num , multipliers):
  fold multipliers:
    case List/Cons:
      return List/Cons{
        head: List/Cons{
          head: num,
          tail: multipliers.head
        },
        tail: multipliers.tail
      }
    case List/Nil:
      return List/Cons{
        head: List/Cons{
          head:num,
          tail:List/Nil
        },
        tail: List/Nil
      }

def mergeLists(list1, list2):
  fold list1:
    case List/Cons:
      return List/Cons{
        head: list1.head,
        tail: list1.tail
      }
    case List/Nil:
      return list2

def listToString(list, n):
  fold list:
    case List/Cons:
      (*, col) = list.head
      bend i = 0:
        when i < n:
          if i == col:
            str = String/Cons{
              head: 'Q',
              tail: fork(i + 1)
            }
          else:
            str = String/Cons{
              head: '.',
              tail: fork(i + 1)
            }
        else:
          str = String/Nil
      return List/Cons{
        head: str,
        tail: list.tail
      }
    case List/Nil:
      return List/Nil

def solveNQueens(n):
  myList = filter(getQueens(n, 0 , from(0)), n)
  fold myList:
    case List/Cons:
      return List/Cons{
        head: listToString(myList.head, n),
        tail: myList.tail
      }
    case List/Nil:
      return List/Nil

def totalNQueens(n):
  return len(filter(getQueens(n, 0 , from(0)), n))

def main():
  return totalNQueens(15)