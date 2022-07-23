//
//  ViewController.swift
//  ReactorKitPractice
//
//  Created by Hamlit Jason on 2022/07/23.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

class CounterViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let counterViewReactor = CounterViewReactor()
    
    lazy var increaseButton = UIButton()
    lazy var countLabel = UILabel()
    lazy var decreaseButton = UIButton()
    lazy var loadingIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bind(reactor: counterViewReactor)
    }
    
    func bind(reactor: CounterViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: CounterViewReactor) {
        increaseButton.rx.tap
            .map { CounterViewReactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { CounterViewReactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: CounterViewReactor) {
        reactor.state
            .map { "\($0.value)" }
            .distinctUntilChanged()
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.isLoading }
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

extension CounterViewController {
    var margin: CGFloat {
        get { return 10.0 }
    }
    
    func setupView() {
        view.addSubview(increaseButton)
        increaseButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        increaseButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(margin)
        }
        
        view.addSubview(countLabel)
        countLabel.text = "0"
        
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(decreaseButton)
        decreaseButton.setImage(UIImage(systemName: "minus"), for: .normal)
        
        decreaseButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(-margin)
        }
        
        view.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(100)
        }
    }
}

