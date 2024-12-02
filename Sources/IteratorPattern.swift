import SwiftUI

struct ArrayIterator<T>: IteratorProtocol {
    private let items: [T]
    private var index = 0

    init(items: [T]) {
        self.items = items
    }

    mutating func next() -> T? {
        guard index < items.count else { return nil }
        defer { index += 1 }
        return items[index]
    }
}

struct CustomCollection<T>: Sequence {
    private var items: [T] = []

    mutating func addItem(_ item: T) {
        items.append(item)
    }

    func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator(items: items)
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            var collection = CustomCollection<String>()
            collection.addItem("Apple")
            collection.addItem("Banana")
            collection.addItem("Cherry")

            for item in collection {
                print(item)
            }
        }
    }
}

#Preview {
    ContentView()
}
