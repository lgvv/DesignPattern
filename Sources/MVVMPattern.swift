import UIKit
import SwiftUI
import Combine

private struct Model {
    var name: String
    var count: Int
}

private class ViewModel: ObservableObject {
    @Published var model: Model = .init(name: "김철수", count: 0)
    
    enum Action {
        case up
        case down
    }
    
    func send(action: Action) {
        switch action {
        case .up:
            model.count += 1
        case .down:
            model.count -= 1
        }
    }
}

private struct SwiftUIView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Count Up") {
                viewModel.send(action: .up)
            }
            Button("Count Down") {
                viewModel.send(action: .down)
            }
            Text(viewModel.model.name + "의 숫자는" + "\(viewModel.model.count)")
        }
    }
}

private class ViewController: UIViewController {
    private let viewModel: ViewModel
    private var cancellables: Set<AnyCancellable>
    
    private func bind() {
        viewModel.$model
            .sink { [weak self] model in
                guard let self else { return }
                self.label.text = model.name + "의 숫자는" + "\(model.count)"
            }.store(in: &cancellables)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.cancellables = .init()
        
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private lazy var upButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(upButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc
    private func upButtonTapped() {
        viewModel.send(action: .up)
    }
    
    private lazy var downButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(upButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc
    private func downButtonTapped() {
        viewModel.send(action: .down)
    }
    
    private let label = UILabel()
}

