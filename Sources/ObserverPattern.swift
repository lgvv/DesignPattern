import SwiftUI
import Combine

private class ViewModel: ObservableObject {
    var publisher = PassthroughSubject<String, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        publisher.sink { [weak self] value in
            print("Received: \(value)")
        }.store(in: &cancellables)
    }
}

private struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Button("Execute") {
            viewModel.publisher.send("Hello")
            viewModel.publisher.send("World")
        }
    }
}

#Preview {
    ContentView()
}
