import Foundation

let filePath = "./input"

let input = try String(contentsOfFile: filePath, encoding: .utf8)

let MAX = 100
var position = 50
var countZeros = 0

for line in input.split(whereSeparator: \.isNewline) {
    let direction = line.first
    let number = Int(line.dropFirst())!

    let sign = { if direction == "L" { return 1 } else { return -1 } }()

    let shifted = sign * number + position
    position = (shifted % MAX + MAX) % MAX

    if position == 0 { countZeros += 1 }
}

print(countZeros)