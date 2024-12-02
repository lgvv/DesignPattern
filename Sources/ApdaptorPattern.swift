import SwiftUI

class Adaptee {
    func printText(_ text: String) {
        print("Legacy Printer: \(text)")
    }
}

protocol Target {
    func printData(data: String)
}

class Adapter: Target {
    private let adaptee: Adaptee

    init(adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    func printData(data: String) {
        adaptee.printText(data)
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            let adaptee = Adaptee()
            let adapter = Adapter(adaptee: adaptee)

            adapter.printData(data: "Hello, Adapter Pattern!")
        }
    }
}

#Preview {
    ContentView()
}
