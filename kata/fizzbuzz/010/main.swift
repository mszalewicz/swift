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

for (denominator, text) in mapping {
    if input % denominator == 0 {
        print(text, terminator: "\n")
    }
}