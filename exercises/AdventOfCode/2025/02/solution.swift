import Foundation

func substringRepeatedTwice(_ text: String) -> String {
    if text.count % 2 != 0 { return "" }

    let boundary = text.count / 2

    let start = text.startIndex
    let halfPoint = text.index(start, offsetBy: boundary)

    for i in 0..<boundary {
        if text[text.index(start, offsetBy: i)] != text[text.index(halfPoint, offsetBy: i)] {
            return ""
        }
    }

    return String(text.prefix(boundary))
}


func main() {
    let filePath = "./input"
    let input = try? String(contentsOfFile: filePath, encoding: .utf8)

    var result1 = 0

    for entry in input!.split(separator: ",") {
        let numbers = entry.split(separator: "-")
        let start = Int(numbers[0])!
        let end = Int(numbers[1])!

        for number in start...end {
            let result = substringRepeatedTwice(String(number))

            if result == "" {
               continue
            }

            result1 += number
        }
    }

    print(result1)
}

main()