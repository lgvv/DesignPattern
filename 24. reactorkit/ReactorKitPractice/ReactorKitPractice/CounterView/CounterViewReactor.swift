//
//  CounterViewReactor.swift
//  ReactorKitPractice
//
//  Created by Hamlit Jason on 2022/07/23.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class CounterViewReactor: Reactor {
    /// 초기 상태를 정의합니다.
    let initialState = State()
    
    /// 사용자 행동을 정의합니다.
    ///
    /// 사용자에게 받을 액션
    enum Action {
        case increase
        case decrease
    }
    
    /// 처리 단위를 정의합니다.
    ///
    /// 액션을 받았을 때 변화
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    /// 현재 상태를 기록합니다.
    ///
    /// 어떠한 변화를 받은 상태!
    struct State {
        var value = 0
        var isLoading = false
    }
    
    /// Action이 들어온 경우 어떤 처리를 할 것인지 분기
    ///
    /// Mutation에서 정의한 작업 단위들을 사용하여 Observable로 방출
    ///
    /// 액션에 맞게 행동해!
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([ // concat은 평등하게 먼저 들어온 옵저버블을 순서대로 방출
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        }
    }
    
    /// 이전 상태와 처리 단위를 받아서 다음 상태를 반환하는 함수
    ///
    /// mutate(action: )이 실행되고 난 후 바로 해당 메소드를 실행
    ///
    /// 변화에 맞게끔 값을 설정해!
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
