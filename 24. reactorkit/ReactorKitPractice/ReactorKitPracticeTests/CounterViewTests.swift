//
//  ReactorKitPracticeTests.swift
//  ReactorKitPracticeTests
//
//  Created by Hamlit Jason on 2022/07/23.
//

import XCTest
@testable import ReactorKitPractice
import RxTest
import RxSwift

class CounterViewTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDownWithError() throws { }
    
    // MARK: - View -> Reactor
    // View에서 Reactor Action을 잘 넘기는지 테스트
    func test_Action_View_to_Reactor() {
        // given
        let reactor = CounterViewReactor()
        let viewController = CounterViewController()
        reactor.isStubEnabled = true
        viewController.reactor = reactor
        
        // when
        viewController.increaseButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(reactor.stub.actions.last, .increase)
        
        // then
        viewController.decreaseButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(reactor.stub.actions.last, .decrease)
    }
    
    // MARK: - Reactor -> View
    // Reactor에서 변경된 상태(State)가 View에도 정상적으로 반영되는지 확인.
    func test_State_Reactor_to_View() {
        // given
        let reactor = CounterViewReactor()
        let viewController = CounterViewController()
        reactor.isStubEnabled = true
        viewController.reactor = reactor
        
        // when
        reactor.stub.state.value = CounterViewReactor.State(value: 0, isLoading: true)
        
        // then
        XCTAssertEqual(viewController.loadingIndicator.isAnimating, true)
        XCTAssertEqual(viewController.countLabel.text, "0")
    }
    
    // MARK: - Reactor
    // action을 받으면 비지니스 로직(Mutation)이 잘 처리되어 State값이 기대값으로 변하는지 확인.
    func test_Reactor() {
        let reactor = CounterViewReactor()
        
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        // when
        reactor.action.onNext(.increase)
        
        // then
        XCTAssertEqual(reactor.currentState.isLoading, true)
    }
    
}
