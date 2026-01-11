import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return if indices.contains(index) { self[index] } else { nil }
    }
}

let test = [1, 2, 3]

if let num = test[safe: 1] {
    print(num)
}

let empty_num = test[safe: 99]

print(empty_num ?? "no number")