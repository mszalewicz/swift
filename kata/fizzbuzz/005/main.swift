import Foundation

guard CommandLine.arguments.count == 2,
    let number = Int(CommandLine.arguments[1])
else {
    print("Usage: program <number>")
    exit(1)
}

let mapping: [(Int, String)] = [
    (3, "fizz"),
    (5, "buzz"),
    (7, "pong"),
]

for (key, value) in mapping {
    if number % key == 0 {
        print(value, " ", terminator: "")
    }
}

print()