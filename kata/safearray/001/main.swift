extension Collection {
    subscript(safe index: Index) -> Element? {
        return if indices.contains(index) { self[index] } else { nil }
    }
}

let numbers = [1, 2, 3]

if let number = numbers[safe: 2] {
    print(number)
}

let noEntry = numbers[safe: 100]
print(noEntry ?? "no number found")