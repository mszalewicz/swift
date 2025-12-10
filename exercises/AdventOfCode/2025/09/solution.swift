import Foundation

let input = try! String(contentsOfFile: "./input", encoding: .utf8)

struct Point {
    var x: Int
    var y: Int
}

var points: [Point] = []

for line in input.split(whereSeparator: \.isNewline) {
    let numsText = line.split(separator: ",")

    points.append(Point(x: Int(numsText[0])!, y: Int(numsText[1])!))
}

var biggestArea = 0

for point1 in points {
    for point2 in points {
        if point1.x != point2.x && point1.y != point2.y {
            let newArea = (abs(point1.x - point2.x) + 1) * (abs(point1.y - point2.y) + 1)

            if newArea > biggestArea {
                biggestArea = newArea
            }
        }
    }
}

print(biggestArea)