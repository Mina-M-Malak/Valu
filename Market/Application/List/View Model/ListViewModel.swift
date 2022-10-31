//
//  ListViewModel.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation

import RxSwift
import RxRelay
import RxSwiftExt
import RxOptional
import Action

protocol ListDataLoader {
    
    typealias ModelType = Model.Service.Item
    
    func loadItems() -> Observable<[ModelType]>
    
}

extension DataLoader: ListDataLoader { }

protocol ListViewModelProtocol {
    
    typealias ModelType = Model.Service.Item
}

final class ListViewModel: ListViewModelProtocol {
    
    let dataLoader: ListDataLoader
    
    private let disposeBag = DisposeBag()
    
    private let receivedDataSubject = BehaviorRelay<[ModelType]>(value: [])
    
    private let dataSubject = PublishSubject<[ModelType]>()
    var data: Observable<[ModelType]> {
        return dataSubject
            .asObservable()
            .distinctUntilChanged()
    }
    var error: Observable<Swift.Error> {
        return fetchAction.underlyingError
    }
    
    var isLoading: Observable<Bool> {
        return fetchAction.executing
    }
    
    let searchTerm = BehaviorRelay<String>(value: "")
    
    private(set) lazy var fetchAction: Action<Void, [ModelType]> =
    createFetchAction()
    
    init(dataLoader: ListDataLoader) {
        self.dataLoader = dataLoader
        
        fetchAction
            .elements
            .bind(to: receivedDataSubject)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(receivedDataSubject,
                                 searchTerm)
            .map({ (items, term) -> [ModelType] in
                guard !term.isEmpty else {
                    return items
                }
                let term = term.lowercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                return items.filter(matching: Predicate { $0.title.lowercased().contains(term) } || Predicate { $0.description.lowercased().contains(term) } )
            })
            .distinctUntilChanged()
            .bind(to: dataSubject)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - Create
extension ListViewModel {
    private func createFetchAction() -> Action<Void, [ModelType]> {
        return Action { [unowned self] () -> Observable<[ModelType]> in
            return dataLoader.loadItems()
        }
    }
}
