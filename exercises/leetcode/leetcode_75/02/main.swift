/*

TODO:

For two strings s and t, we say "t divides s" if and only if s = t + t + t + ... + t + t (i.e., t is concatenated with itself one or more times).

Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.

Constraints:

1 <= str1.length, str2.length <= 1000
str1 and str2 consist of English uppercase letters

*/

/*

NOTES:
    - using preconditions as part of defensive programming: fail fast
    - providing my first solution;
      optimal solution with comparing str1 + str2 = str2 + str1 is elegant, but I did not found it myself;

*/

import Foundation

class Solution {
    static func gcdOfStrings(_ str1: String, _ str2: String) -> String {
        precondition(
            1 <= str1.count && str1.count <= 1000,
            "Error: str1 length = \(str1.count) , mandatory range [1, 1000]."
        )

        precondition(
            str1.allSatisfy { $0.isUppercase && $0.isLetter && $0.isASCII },
            "Error: str1 must contain only uppercase letters."
        )

        precondition(
            1 <= str2.count && str2.count <= 1000,
            "Error: str2 length = \(str2.count)  , mandatory range [1, 1000]."
        )

        precondition(
            str2.allSatisfy { $0.isUppercase && $0.isLetter && $0.isASCII },
            "Error: str2 must contain only uppercase letters."
        )

        // Special case where strings have same length but are not equal
        if str1.count == str2.count {
            if str1 != str2 { return "" }
        }

        // Other strings:
        let biggerString: String
        let smallerString: String

        switch str1.count > str2.count {
        // Performant, because of copy-on-write for String in Swift :
        case true:
            biggerString = str1
            smallerString = str2
        case false:
            biggerString = str2
            smallerString = str1
        }

        var numberOfParts = 1
        var partLength = biggerString.count / numberOfParts

        check: while partLength > 0 {
            if partLength > smallerString.count {
                numberOfParts += 1
                partLength = biggerString.count / numberOfParts
                continue check
            }

            if (biggerString.count % partLength == 0) && (smallerString.count % partLength == 0) {
                var i = 0
                var position = 0
                var foundAnswer = true

                while position < biggerString.count {
                    if position < smallerString.count {
                        let letter = smallerString[smallerString.index(smallerString.startIndex, offsetBy: position)]
                        let valueTooCheck = biggerString[biggerString.index(biggerString.startIndex, offsetBy: i)]
                        if letter != valueTooCheck {
                            foundAnswer = false
                            break
                        }
                    }

                    let letter = biggerString[biggerString.index(biggerString.startIndex, offsetBy: position)]
                    let valueTooCheck = biggerString[biggerString.index(biggerString.startIndex, offsetBy: i)]
                    if letter != valueTooCheck {
                        foundAnswer = false
                        break
                    }

                    i = (i + 1) % partLength
                    position += 1
                }

                if foundAnswer {
                    let start = biggerString.startIndex
                    let end   = biggerString.index(biggerString.startIndex, offsetBy: partLength)

                    let slice = biggerString[start..<end]
                    return String(slice)
                }
            }

            numberOfParts += 1
            partLength = biggerString.count / numberOfParts
        }

        return ""
    }
}

func runTests() {
    let testCases: [(String, String, String)] = [
        ("U", "UUU", "U"),
        ("TTT", "T", "T"),
        ("LLL", "LLL", "LLL"),
        ("ABCABC", "ABC", "ABC"),
        ("AAB", "AABAAB", "AAB"),
        ("YYDY", "YYDYYYDY", "YYDY"),
        ("CCCXCCCCCCXCCC", "CCCXCCC", "CCCXCCC"),
        ("ABABAB", "ABAB", "AB"),
        ("LEET", "CODE", ""),
        ("CODE", "LEET", ""),
        ("ABCD", "ABCD", "ABCD"),
        ("ABC", "ABCDEF", ""),
        ("ABCDEF", "ABC", ""),
    ]

    for (i, (word1, word2, expectedResult)) in testCases.enumerated() {
        let computed = Solution.gcdOfStrings(word1, word2)

        if computed != expectedResult {
            print(
                "Test \(i+1) error: word1= \(word1), word2= \(word2), expected= \(expectedResult), computed= \(computed)"
            )

            exit(1)
        }
    }
}

//  TESTING

let start = DispatchTime.now()

runTests()

let end = DispatchTime.now()

let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
let timeInterval = Double(nanoTime) / 1_000_000_000

separator()
print("Tests passed.")
separator()
print("Execution time: \(timeInterval) s")
separator()

func separator() {
    print()
    print(String(repeating: "-", count: 60))
    print()
}
