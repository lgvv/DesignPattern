import UIKit
import SwiftUI
import Combine

private struct Model {
    var name: String
    var count: Int
}

private class ViewController: UIViewController {
    
    // MARK: - State
    
    @Published var model: Model = .init(name: "김철수", count: 0)
    
    private var cancellables: Set<AnyCancellable>
    
    // MARK: - Action
    
    enum Action {
        case up
        case down
    }
    
    // MARK: - Mutation
    
    func send(action: Action) {
        switch action {
        case .up:
            model.count += 1
        case .down:
            model.count -= 1
        }
    }
    
    private func bind() {
        $model
            .sink { [weak self] model in
                guard let self else { return }
                self.label.text = model.name + "의 숫자는" + "\(model.count)"
            }.store(in: &cancellables)
    }
    
    init() {
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
        send(action: .up)
    }
    
    private lazy var downButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(upButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc
    private func downButtonTapped() {
        send(action: .down)
    }
    
    private let label = UILabel()
}

