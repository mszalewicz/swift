import Foundation

extension Collection {
    subscript(maybe index: Index) -> Element? {
        return if indices.contains(index) { self[index] } else { nil }
    }
}

let test = [1, 2, 3]

if let num = test[maybe: 1] {
    print(num)
}

let empty_num = test[maybe: 99]

print(empty_num ?? "no number")