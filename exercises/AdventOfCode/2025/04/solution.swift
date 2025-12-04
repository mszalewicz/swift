import Foundation

struct Coordinate: Hashable {
    var y: Int
    var x: Int

    static func + (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
        return Coordinate(y: lhs.y + rhs.y, x: lhs.x + rhs.x)
    }
}

let input = try String(contentsOfFile: "./input", encoding: .utf8)
let lines = input.split(whereSeparator: \.isNewline)

let maxX = lines[0].count
let maxY = lines.count

var validCoordinates = Set<Coordinate>()

for y in 0..<maxY {
    for x in 0..<maxX {
        let currLine = lines[y]
        if currLine[currLine.index(currLine.startIndex, offsetBy: x)] == "@" {
            validCoordinates.insert(Coordinate(y: y, x: x))
        }
    }
}

let MAX_NEIGHBOURS = 4
var result = 0
var coordinatesToRemove = Set<Coordinate>()

repeat {
    coordinatesToRemove.removeAll()

    search: for coordinate in validCoordinates {
        var countNeighbours = 0

        for neighbour in [
            coordinate + Coordinate(y: 0, x: -1),
            coordinate + Coordinate(y: 0, x: 1),
            coordinate + Coordinate(y: -1, x: 0),
            coordinate + Coordinate(y: 1, x: 0),
            coordinate + Coordinate(y: -1, x: -1),
            coordinate + Coordinate(y: 1, x: -1),
            coordinate + Coordinate(y: -1, x: 1),
            coordinate + Coordinate(y: 1, x: 1),
        ] {
            if validCoordinates.contains(neighbour) {
                if countNeighbours == MAX_NEIGHBOURS - 1 {
                    continue search
                }
                countNeighbours += 1
            }
        }

        result += 1
        coordinatesToRemove.insert(coordinate)
    }

    for toBeRemoved in coordinatesToRemove {
        validCoordinates.remove(toBeRemoved)
    }
} while !coordinatesToRemove.isEmpty


print(result)