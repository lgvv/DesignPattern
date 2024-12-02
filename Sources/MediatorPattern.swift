import SwiftUI

protocol MediatorProtocol: AnyObject {
    func send(message: String, from colleague: Colleague)
}

class Mediator: MediatorProtocol {
    private var colleagues: [Colleague] = []
    
    func register(colleague: Colleague) {
        colleagues.append(colleague)
    }
    
    func send(message: String, from colleague: Colleague) {
        for receiver in colleagues where receiver !== colleague {
            receiver.receive(message: message)
        }
    }
}

class Colleague {
    let name: String
    private weak var mediator: MediatorProtocol?
    
    init(name: String, mediator: MediatorProtocol) {
        self.name = name
        self.mediator = mediator
    }
    
    func send(message: String) {
        print("\(name) sends message: \(message)")
        mediator?.send(message: message, from: self)
    }
    
    func receive(message: String) {
        print("\(name) received message: \(message)")
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // 사용 예시
            let mediator = Mediator()

            let colleague1 = Colleague(name: "Alice", mediator: mediator)
            let colleague2 = Colleague(name: "Bob", mediator: mediator)

            mediator.register(colleague: colleague1)
            mediator.register(colleague: colleague2)

            colleague1.send(message: "Hello, Bob!")
            colleague2.send(message: "Hi, Alice!")

        }
    }
}

#Preview {
    ContentView()
}
