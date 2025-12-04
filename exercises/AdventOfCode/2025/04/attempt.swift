import Foundation

struct Complex: Hashable {
    var re: Int
    var im: Int

    static func + (lhs: Complex, rhs: Complex) -> Complex {
        return Complex(re: lhs.re + rhs.re, im: lhs.im + lhs.re)
    }

    enum Rotation {
        case deg90, deg180, deg270
    }

    func rotate(_ degrees: Rotation) -> Complex {
        switch degrees {
        case .deg90: return Complex(re: -im, im: re)
        case .deg180: return Complex(re: -re, im: -im)
        case .deg270: return Complex(re: im, im: -re)
        }
    }
}

func main() {
    let input = try? String(contentsOfFile: "./input", encoding: .utf8)
    let lines = input!.split(whereSeparator: \.isNewline)

    let maxX = lines[0].count
    let maxY = lines.count

    var validCoordinates = Set<Complex>()

    for x in 0..<maxX {
        for y in 0..<maxY {

            let currLine = lines[y]
            if currLine[currLine.index(currLine.startIndex, offsetBy: x)] == "@" {
                validCoordinates.insert(Complex(re: x, im: y))
            }
        }
    }

    for y in 0..<maxY {
        for x in 0..<maxX {
            if validCoordinates.contains(Complex(re: x, im: y)) {
                print("@", terminator: "")
            } else {
                print(".", terminator: "")
            }
        }
        print()
    }

    for valid in validCoordinates {
        print("y: \(valid.im), x: \(valid.re)")
    }

    var result = 0
    candidates: for coordinate in validCoordinates {
        var countNeighbours = 0
        print("---------------------------------------------------------------------------")
        print("x:", coordinate.re, "y:", coordinate.im)

        for neighbour in [
            coordinate + Complex(re: 0, im: -1),
            coordinate + Complex(re: 0, im: 1),
            coordinate + Complex(re: -1, im: 0),
            coordinate + Complex(re: 1, im: 0),
            coordinate + Complex(re: -1, im: -1),
            coordinate + Complex(re: 1, im: -1),
            coordinate + Complex(re: -1, im: 1),
            coordinate + Complex(re: 1, im: 1),
        ] {
            if validCoordinates.contains(neighbour) {
                print("neigh:", neighbour.re, neighbour.im, countNeighbours)
                countNeighbours += 1
                if countNeighbours == 4 {
                    print("hop")
                    continue candidates
                }
            }
        }

        print("x:", coordinate.re, "y:", coordinate.im, "neighbours:", countNeighbours)
        result += 1
    }

    print(result)
}

main()
