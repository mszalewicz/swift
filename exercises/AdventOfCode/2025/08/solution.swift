import Foundation

let input = try! String(contentsOfFile: "./input", encoding: .utf8)

struct Coordinate: Equatable {
    var name: String
    var X: Double
    var Y: Double
    var Z: Double
}

struct Distance: Comparable {
    var coordinateX: Coordinate
    var coordinateY: Coordinate
    var length: Double

    static func < (lhs: Distance, rhs: Distance) -> Bool {
        if lhs.length < rhs.length { return true }
        return false
    }
}

func calculateDistance(lhs: Coordinate, rhs: Coordinate) -> Distance {
    let dx = lhs.X - rhs.X
    let dy = lhs.Y - rhs.Y
    let dz = lhs.Z - rhs.Z

    let length = sqrt(dx * dx + dy * dy + dz * dz)

    return Distance(
        coordinateX: lhs,
        coordinateY: rhs,
        length: length
    )
}

func pad(_ input: String, _ len: Int) -> String {
    if input.count >= len { return input }

    let padLen = len - input.count
    var padded = input

    for _ in 0..<padLen {
        padded += " "
    }

    return padded
}

// Unique circuit identifier is current time, using DispatchTime.rawValue

var coordinates: [Coordinate] = []
var coordinatesInCircuits: [String: UInt64] = [:]
var circuits: [UInt64: Int] = [:]
var distances: [Distance] = []

for row in input.split(whereSeparator: \.isNewline) {
    let inputCoordinates = row.split(separator: ",")

    let coordinate = Coordinate(
        name: String(row),
        X: Double(String(inputCoordinates[0]))!,
        Y: Double(String(inputCoordinates[1]))!,
        Z: Double(String(inputCoordinates[2]))!
    )

    coordinates.append(coordinate)
}

while coordinates.count != 1 {
    let coordinateX = coordinates[0]

    for coordinateY in coordinates[1..<coordinates.count] {
        distances.append(calculateDistance(lhs: coordinateX, rhs: coordinateY))
    }

    coordinates.remove(at: 0)
}

distances.sort()

var id: UInt64 = 1
let MAXCONNECTIONS = 999

for (connection, distance) in distances.enumerated() {
    var checkDone = false

    let isCoordinateXInCircuit = coordinatesInCircuits.keys.contains(distance.coordinateX.name)
    let isCoordinateYInCircuit = coordinatesInCircuits.keys.contains(distance.coordinateY.name)

    if !isCoordinateXInCircuit && !isCoordinateYInCircuit && checkDone == false {
        let circuitIdentifier = id
        id += 1

        coordinatesInCircuits[distance.coordinateX.name] = circuitIdentifier
        coordinatesInCircuits[distance.coordinateY.name] = circuitIdentifier

        circuits[circuitIdentifier] = 2
        checkDone = true
    }

    if isCoordinateXInCircuit && isCoordinateYInCircuit && checkDone == false {
        if coordinatesInCircuits[distance.coordinateX.name]
            == coordinatesInCircuits[distance.coordinateY.name]
        {
            checkDone = true
        } else {

            let leftSet = coordinatesInCircuits[distance.coordinateX.name]!
            let rightSet = coordinatesInCircuits[distance.coordinateY.name]!

            for key in coordinatesInCircuits.keys {
                if coordinatesInCircuits[key] == rightSet {
                    coordinatesInCircuits[key] = leftSet
                }
            }

            circuits[leftSet]! += circuits[rightSet]!
            circuits.removeValue(forKey: rightSet)

            checkDone = true
        }
    }

    if isCoordinateXInCircuit && checkDone == false {
        let circuitIdentifier = coordinatesInCircuits[distance.coordinateX.name]
        coordinatesInCircuits[distance.coordinateY.name] = circuitIdentifier
        circuits[circuitIdentifier!]! += 1

        checkDone = true
    }

    if isCoordinateYInCircuit && checkDone == false {
        let circuitIdentifier = coordinatesInCircuits[distance.coordinateY.name]
        coordinatesInCircuits[distance.coordinateX.name] = circuitIdentifier
        circuits[circuitIdentifier!]! += 1

        checkDone = true
    }


    if connection == MAXCONNECTIONS {
        var solution1 = 1

        for relevant in (circuits.sorted { $1.value < $0.value }).prefix(3) {
            solution1 *= relevant.value
        }

        print("Solution 1:", solution1)

    }

    if circuits.first!.value == 1000 {
        print("Solution 2:", Int(distance.coordinateX.X * distance.coordinateY.X))
        break
    }
}
