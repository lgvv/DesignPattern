import UIKit
import SwiftUI

protocol TaskDelegate: AnyObject {
    func didCompleteTask()
}

private protocol ViewModelCommand {
    func send(action: ViewModel.Action)
}

private final class ViewModel: ViewModelCommand, TaskDelegate {
    
    enum Action {
        case buttonTapped
    }
    
    func send(action: Action) {
        switch action {
        case .buttonTapped:
            let worker = Worker()
            worker.delegate = self
            worker.start()
        }
    }
    
    func didCompleteTask() {
        print("viewmodel: receive task working")
    }
}

private class Worker {
    weak var delegate: TaskDelegate?
    
    func start() {
        print("worker: start working")
        delegate?.didCompleteTask()
    }
}

private struct ContentView: View {
    private let viewModel: ViewModelCommand = ViewModel()
    
    var body: some View {
        Button("Execute") {
            viewModel.send(action: .buttonTapped)
        }
    }
}

#Preview {
    ContentView()
}
                                                   
                                                    
