import Foundation

let input = try? String(contentsOfFile: "./input", encoding: .utf8)

struct Range: Comparable {
    var min: Int
    var max: Int

    static func < (lhs: Range, rhs: Range) -> Bool {
        if lhs.min < rhs.min {
            return true
        } else if lhs.min == rhs.min {
            if lhs.max < rhs.max {
                return true
            }
        }
        return false
    }
}

extension Array where Element == Range {
    mutating func safeInsert(_ element: Range, at index: Int) {
        if index <= self.count {
            self.insert(element, at: index)
        } else {
            self.append(element)
        }
    }
}

var ranges = [Range]()

let parts = input!.split(separator: "\n\n")
let rangesPart = parts[0]
let checkValuesPart = parts[1]

for range in rangesPart.split(whereSeparator: \.isNewline) {
    let numbers = range.split(separator: "-")
    let min = Int(numbers[0])!
    let max = Int(numbers[1])!

    ranges.append(Range(min: min, max: max))
}

ranges.sort()

var changesToBeMade: Bool

repeat {
    changesToBeMade = false

    for i in 0..<ranges.count - 1 {
        if ranges[i + 1].min <= ranges[i].max {
            if ranges[i].max <= ranges[i + 1].max {
                ranges.insert(Range(min: ranges[i].min, max: ranges[i + 1].max), at: i + 2)
            } else {
                ranges.insert(Range(min: ranges[i].min, max: ranges[i].max), at: i + 2)
            }

            ranges.remove(at: i+1)
            ranges.remove(at: i)
            changesToBeMade = true
            break
        }
    }

} while changesToBeMade

var part1 = 0

for value in checkValuesPart.split(whereSeparator: \.isNewline) {
    let number = Int(value)!

    for range in ranges {
        if range.min <= number && number <= range.max {
            part1 += 1
            break
        }
    }
}

var part2 = 0

for range in ranges {
    part2 += range.max - range.min + 1
}


print("Part 1:", part1)
print("Part 2:", part2)