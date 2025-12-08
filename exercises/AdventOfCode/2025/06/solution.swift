import Foundation

let input = try? String(contentsOfFile: "./input", encoding: .utf8)

var problems = [Int]()
var operations = [String]()

for (i, line) in input!.split(whereSeparator: \.isNewline).enumerated() {
    if i == input!.split(whereSeparator: \.isNewline).count - 1 {
        for entry in line.split(whereSeparator: \.isWhitespace) {
            operations.append(String(entry))
        }
        break
    }

    for entry in line.split(whereSeparator: \.isWhitespace) {
        problems.append(Int(String(entry))!)
    }
}

let howManySets = operations.count
let setLength = problems.count / operations.count

var result1 = 0

for x in 0..<howManySets {
    var setResult = problems[x]

    for y in 1..<setLength {
        switch operations[x] {
        case "*":
            setResult *= problems[x + y * howManySets]
        case "+":
            setResult += problems[x + y * howManySets]
        default:
            print("different operation")
            exit(1)
        }
    }

    result1 += setResult
}

print(result1)