import Foundation

let input = try? String(contentsOfFile: "./input", encoding: .utf8)

var counter = 0

for line in input!.split(whereSeparator: \.isNewline) {
    var tens = line[line.startIndex]
    var ones = line[line.index(line.startIndex, offsetBy: 1)]

    for i in 1..<line.count - 1 {
        let newNumber = line[line.index(line.startIndex, offsetBy: i)]

        if newNumber > tens {
            tens = newNumber
            ones = line[line.index(line.startIndex, offsetBy: i + 1)]
            continue
        }

        if newNumber > ones {
            ones = newNumber
        }
    }

    if line.last! > ones {
        ones = line.last!
    }

    counter += Int(String(tens) + String(ones))!
}

print(counter)
