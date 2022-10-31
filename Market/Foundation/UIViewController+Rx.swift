//
//  UIViewController+Rx.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    public var viewWillAppearObservable: Observable<Bool> {
        return sentMessage(#selector(Base.viewWillAppear(_:)))
            .map({ (animated: [Any]) -> Bool in
                return animated.first as? Bool ?? false
            })
    }
    
}
