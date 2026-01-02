/*

TODO:

There are n kids with candies. You are given an integer array candies, where each candies[i] represents the number of candies the ith kid has, and an integer extraCandies, denoting the number of extra candies that you have.

Return a boolean array result of length n, where result[i] is true if, after giving the ith kid all the extraCandies, they will have the greatest number of candies among all the kids, or false otherwise.

Note that multiple kids can have the greatest number of candies.

    n == candies.length
    2 <= n <= 100
    1 <= candies[i] <= 100
    1 <= extraCandies <= 50

*/

class Solution {
    static func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {
        let maxCandies = candies.max() ?? 0

        return candies.map { $0 + extraCandies >= maxCandies }
    }
}

func runTests() {
    let testCases: [(candies: [Int], maxCandices: Int, output: [Bool])] = [
        ([2, 3, 5, 1, 3], 3, [true, true, true, false, true]),
        ([4, 2, 1, 1, 2], 1, [true, false, false, false, false]),
        ([12, 1, 12], 10, [true, false, true]),
    ]

    for (i, (candies, maxCandies, output)) in testCases.enumerated() {
        let computed = Solution.kidsWithCandies(candies, maxCandies)
        let passed = (computed == output)

        switch passed {
        case true:
            print("Test \(i+1) passed.\n")
        case false:
            print("Test \(i+1) error: expected= \(output), computed= \(computed)\n")
        }
    }
}

print()
runTests()
print()