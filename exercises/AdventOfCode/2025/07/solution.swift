import Foundation

func indicesInRangeSafe(_ range: Range<String.Index>, in text: String) -> [Int] {
    let start = range.lowerBound
    let end = range.upperBound

    // Convert bounds to integers
    let startInt = text.distance(from: text.startIndex, to: start)
    let endInt = text.distance(from: text.startIndex, to: end)

    // Clamp to string length to avoid out-of-bounds
    let textCount = text.count
    let safeStart = max(0, min(startInt, textCount))
    let safeEnd = max(0, min(endInt, textCount))

    return Array(safeStart..<safeEnd)
}

let input = try? String(contentsOfFile: "./input", encoding: .utf8)

var positions = [Int]()

let lines = input!.split(whereSeparator: \.isNewline)
let start = lines[0]
let map = lines[1..<lines.count]

positions.append(start.distance(from: start.startIndex, to: start.firstIndex(of: "S")!))

let MinPosition = 0
let MaxPosition = start.count - 1


var solution1 = 0

for row in map {
    var positionsToDelete = [Int]()
    let splittersPositions = row.enumerated().compactMap { index, char in char == "^" ? index : nil }

    for (index, laserPosition) in positions.enumerated() {
        for splitterPosition in splittersPositions {
            if laserPosition == splitterPosition {
                positionsToDelete.append(index)

                let leftSplit = laserPosition - 1
                let rightSplit = laserPosition + 1

                if MinPosition <= leftSplit && positions.firstIndex(of: leftSplit) == nil {
                    positions.append(leftSplit)
                }

                if rightSplit <= MaxPosition && positions.firstIndex(of: rightSplit) == nil {
                    positions.append(rightSplit)
                }

                solution1 += 1
            }
        }
    }

    for i in positionsToDelete.reversed() {
        // print(positions)
        // print(positionsToDelete)
        // print(i)
        positions.remove(at: i)
    }

}

print(solution1)