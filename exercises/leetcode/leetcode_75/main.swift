/*

TODO:

You are given two strings word1 and word2. Merge the strings by adding letters
in alternating order, starting with word1. If a string is longer than the other,
append the additional letters onto the end of the merged string.

Return the merged string.

Constraints:

 1 <= word1.length, word2.length <= 100
 word1 and word2 consist of lowercase English letters.

*/

class Solution {
    public static func mergeAlternately(_ word1: String, _ word2: String) -> String {
        precondition(1 <= word1.count && word1.count <= 100)
        precondition(1 <= word2.count && word2.count <= 100)

        let chars1 = Array(word1)
        let chars2 = Array(word2)

        let maxSize = max(chars1.count, chars2.count)
        var output = ""

        for i in 0 ..< maxSize {
            if i < chars1.count { output.append(chars1[i]) }
            if i < chars2.count { output.append(chars2[i]) }
        }

        return output
    }

    public static func mergeAlternately2(_ word1: String, _ word2: String) -> String {
        precondition(1 <= word1.count && word1.count <= 100)
        precondition(1 <= word2.count && word2.count <= 100)



        let maxSize = max(word1.count, word2.count)
        var output = ""

        for i in 0 ..< maxSize {
            if i < word1.count { output.append(word1[word1.index(word1.startIndex, offsetBy: i)]) }
            if i < word2.count { output.append(word2[word2.index(word2.startIndex, offsetBy: i)]) }
        }

        return output
    }
}

func runTests() {
    let testCases: [(String, String, String)] = [
            ("abc", "pqr", "apbqcr"),
            ("ab", "pqrs", "apbqrs"),
            ("abcd", "pq", "apbqcd"),
        ]

    for (word1, word2, result) in testCases {
        precondition(Solution.mergeAlternately(word1, word2) == result, "word1: \(word1), word2: \(word2), result: \(result)")
    }

    for (word1, word2, result) in testCases {
        precondition(Solution.mergeAlternately2(word1, word2) == result, "word1: \(word1), word2: \(word2), result: \(result)")
    }

    print("Tests passed.")
}

runTests()

/*

NOTES:
    - Iterating over size of bigger word, as we can just stop iteration of short word with cheap comparison.
    - Unfortunately did not find solution without branch predictions (confirmed with godbolt).
    - Testing done inline as standard package init workflow with Tests is overkill for LeetCode single functions.
      Precondition is not ideal form for testing as it is unnecessarly verbose, but it gets the job done.
*/