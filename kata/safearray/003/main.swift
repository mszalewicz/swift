import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return if indices.contains(index) { self[index] } else { nil }
    }
}

let test = [1, 2, 3]

if let number = test[safe: 1] {
    print(number)
}

let empty = test[safe: 76543]
print(empty ?? "no number")

guard
    let empty2 = test[safe: 76543],
    true
else {
    print("Index out of bounds")
    exit(1)
}