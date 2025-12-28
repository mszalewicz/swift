import Foundation

let mapping: [(Int, String)] = [
    (3, "fizz"),
    (5, "buzz"),
    (7, "clang"),
]

let args = CommandLine.arguments

if args.count != 2 {
    print("Invalid number of arguments passed.\nUsage: /bin *integer*")
    exit(1)
}

guard let number = Int(CommandLine.arguments[1]) else {
    print("Passed argument is not a valid integer.\nExiting.")
    exit(1)
}

for (key, value) in mapping {
    if number % key == 0 {
        print(value, terminator: " ")
    }
}

