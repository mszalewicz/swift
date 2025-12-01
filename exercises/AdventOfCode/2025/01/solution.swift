import Foundation

let filePath = "./input"

let input = try String(contentsOfFile: filePath, encoding: .utf8)

let MAX = 100
var position = 50
var countZeros = 0
var countZerosPassed = 0
var lastSign = 1

for line in input.split(whereSeparator: \.isNewline) {
    let direction = line.first
    let step = Int(line.dropFirst())!

    let sign = { if direction == "L" { return -1 } else { return 1 } }()
    let shifted = sign * step + position

    let x: Int

    if direction == "R" {
        x = (position + step) / MAX
    } else {

        switch position {
        case 0:
            x = step / MAX
        default:
            x = (100 - position + step) / MAX
        }

    }

    countZerosPassed += x

    position = (shifted % MAX + MAX) % MAX
    if position == 0 { countZeros += 1 }
}

print("Part1: ", countZeros)
print("Part2: ", countZerosPassed)