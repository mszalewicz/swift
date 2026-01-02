/*

TODO:

You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.

Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return true if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule and false otherwise.

Example 1:

Input: flowerbed = [1,0,0,0,1], n = 1
Output: true

Example 2:

Input: flowerbed = [1,0,0,0,1], n = 2
Output: false



Constraints:

    1 <= flowerbed.length <= 2 * 104
    flowerbed[i] is 0 or 1.
    There are no two adjacent flowers in flowerbed.
    0 <= n <= flowerbed.length

*/

class Solution {
    static func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        if flowerbed.count == 0 {
            return false
        }

        if flowerbed.count == 1 && flowerbed[0] == 0 && n == 1 {
            return true
        }

        var plantable = 0
        var previousPlanted = Int.min

        check: for (i, flower) in flowerbed.enumerated() {
            if flower == 0 {
                if previousPlanted == i - 1 {
                    continue check
                }

                if i > 0 {
                    if flowerbed[i - 1] == 1 {
                        continue check
                    }
                }

                if i < flowerbed.count - 1 {
                    if flowerbed[i + 1] == 1 {
                        continue check
                    }
                }

                plantable += 1
                previousPlanted = i
            }
        }

        return plantable >= n
    }
}

func tests() {
    let tests = [
        ([], 1, false),
        ([0], 1, true),
        ([1, 0], 1, false),
        ([0, 1], 1, false),
        ([1, 0, 0, 0, 1], 1, true),
        ([0, 0, 0], 1, true),
        ([0, 0, 0], 2, true),
        ([0, 0, 0], 3, false),
    ]

    for (i, (flowerbed, n, expected)) in tests.enumerated() {
        let computed = Solution.canPlaceFlowers(flowerbed, n)
        let passed = (computed == expected)

        switch passed {
        case true:
            print("Test \(i+1) successful")
        case false:
            print("Test \(i+1) failed: expected = \(expected), got = \(computed)")
        }
    }
}

print()
tests()
print()
