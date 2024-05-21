# This problem solves Leetcode Problem #1 (twoSum)
def findWanted(idx, target, list):
  i = +0
  fold list with i:
    case List/Cons:
      if (list.head == target) & (i > idx):
        return i
      else:
        return list.tail(i + 1)
    case List/Nil:
      return -1

def twoSum(nums, target):
  i = +0
  list = nums
  fold list with i:
    case List/Cons:
      hold = findWanted(i, target - list.head, nums)
      if (hold != -1):
        return [i, hold]
      else:
        return list.tail(i + 1)
    case List/Nil:
      return -1

def main():
  return twoSum([3,3], 6)