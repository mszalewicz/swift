import Foundation

func checkNumber(_ input: Int) -> String {
    let mapping = [
        (3, "fizz"),
        (5, "buzz"),
        (7, "kazz"),
    ]

    var result = ""
    var firstWord = true

    for (denominator, text) in mapping {
        if input % denominator == 0 {
            if !firstWord {
                result += " "
            }

            result += text
            firstWord = false
        }
    }

    return result
}

guard
    CommandLine.arguments.count == 2,
    let number = Int(CommandLine.arguments[1])
else {
    print("Usage: program <input>")
    exit(1)
}

print(checkNumber(number))