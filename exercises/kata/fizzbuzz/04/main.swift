import Foundation

guard CommandLine.arguments.count > 1,
    let number = Int(CommandLine.arguments[1])
else {
    print("Usage: program <number>")
    exit(1)
}

let mapping = [
    (3, "fizz"),
    (5, "buzz"),
    (7, "bleach"),
]

for (denominator, result) in mapping {
    if number % denominator == 0 {
        print(result, " ", terminator: "")
    }
}

print()
