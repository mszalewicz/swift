
//  Get RGB values from #hex value
func rgb(_ hex: String) -> String {
    let start = hex.index(hex.startIndex, offsetBy: 1)
    let rEnd = hex.index(start, offsetBy: 2)
    let gStart = rEnd
    let gEnd = hex.index(gStart, offsetBy: 2)
    let bStart = gEnd
    let bEnd = hex.index(bStart, offsetBy: 2)

    let rHex = String(hex[start..<rEnd])
    let gHex = String(hex[gStart..<gEnd])
    let bHex = String(hex[bStart..<bEnd])

    let r = UInt8(rHex, radix: 16) ?? 0
    let g = UInt8(gHex, radix: 16) ?? 0
    let b = UInt8(bHex, radix: 16) ?? 0

    return "R: \(r)\nG: \(g)\nB: \(b)"
}

//  Custom colors for the printing test results
struct Color {
    static let violet = "\u{001B}[38;2;161;100;196m"
    static let green = "\u{001B}[38;2;100;196;166m"
    static let reset = "\u{001B}[0;0m"
}