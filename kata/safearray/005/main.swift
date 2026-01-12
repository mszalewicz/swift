import Foundation

extension Collection {
    subscript(maybe index: Index) -> Element? {
        return if indices.contains(index) { self[index] } else { nil }
    }
}

let number_collection = [1, 2, 3]

if let num = number_collection[maybe: 2] {
    print(num)
}

let no_num = number_collection[maybe: 12000]

print(no_num ?? "index out of range")