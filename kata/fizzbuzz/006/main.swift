import Foundation

func checkNumber(_ number: Int) -> String {
    var result = ""

    let mapping: [(Int, String)] = [
        (3, "fizz"),
        (5, "buzz"),
        (7, "bring"),
    ]

    var firstEntry = true

    for (key, value) in mapping {
        if number % key == 0 {
            if !firstEntry {
                result += " "
            }

            result += value
            firstEntry = false
        }
    }

    return result
}

guard
    CommandLine.arguments.count == 2,
    let input = Int(CommandLine.arguments[1])
else {
    print("Usage: program <number>")
    exit(1)
}

print(checkNumber(input))