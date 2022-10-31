//
//  ObservableType+Action.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation
import RxSwift
import Action

public extension RxSwift.ObservableType {
    
    func bind<ValueType>(to action: Action<ValueType, ValueType>) -> Disposable where ValueType == Element {
        return bind(to: action.inputs)
    }
    
    func bind<ValueType, OutputValueType>(to action: Action<ValueType, OutputValueType>) -> Disposable where ValueType == Element {
        return bind(to: action.inputs)
    }
    
    func bind<ValueType, InputValueType, OutputValueType>(to action: Action<InputValueType, OutputValueType>, inputTransform: @escaping (ValueType) -> (InputValueType)) -> Disposable where ValueType == Element {
        return self
            .map({ (input: ValueType) -> InputValueType in
                return inputTransform(input)
            })
            .bind(to: action.inputs)
    }
    
}
