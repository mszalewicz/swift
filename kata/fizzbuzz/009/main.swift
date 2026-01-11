import Foundation

guard
    CommandLine.arguments.count == 2,
    let input = Int(CommandLine.arguments[1])
else {
    print("Usage: program <number>")
    exit(1)
}

let mapping = [
    (3, "fizz"),
    (5, "buzz"),
    (7, "pazz"),
]

var firstWord = true
var result = ""

for (denominator, value) in mapping {
    if input % denominator == 0 {
        if !firstWord {
            result += " "
        }

        result += value
        firstWord = false
    }
}

print(result)