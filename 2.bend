# This problem solves Leetcode Problem #2 (addTwoNumbers)
def addTwoNumbers(l1, l2):
  listb = l2
  carry = 0
  fold l1 with listb, carry:
    case List/Cons:
      match listb:
        case List/Cons:
          return List/Cons{
            head: (l1.head + listb.head + carry) % 10,
            tail: l1.tail(listb.tail, (l1.head + listb.head + carry) > 9)
          }
        case List/Nil:
          return List/Cons{
            head: (l1.head + carry) % 10,
            tail: l1.tail(listb, (l1.head + carry) > 9)
          }
    case List/Nil:
      fold listb with carry:
        case List/Cons:
          return List/Cons{
            head: (listb.head + carry) % 10,
            tail: listb.tail((listb.head + carry) > 9)
          }
        case List/Nil:
          if carry > 0:
            return List/Cons{
              head:carry,
              tail:List/Nil
            }
          else:
            return List/Nil

def main():
  l1 = [9,9,9,9]
  l2 = [9,9,9,9]
  return addTwoNumbers(l1, l2)