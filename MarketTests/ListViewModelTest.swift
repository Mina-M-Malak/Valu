//
//  ListViewModelTest.swift
//  MarketTests
//
//  Created by Mina Malak on 30/10/2022.
//

import XCTest

@testable import Market

import RxSwift
import Action
import RxTest

class ListViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var viewModel: ListViewModel!
    var mocked: [ListViewModel.ModelType]!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        mocked = DataLoaderMock.Local.loadItems()
    }
    
    func test_local_data_fetch() {
        do {
            viewModel = try ListViewModel(dataLoader: prepareLocalDataLoader())
            let data = scheduler.createObserver([ListViewModel.ModelType].self)
            
            viewModel
                .data
                .bind(to: data)
                .disposed(by: disposeBag)
            
            scheduler.createColdObservable([.next(1, ())])
                .bind(to: viewModel.fetchAction)
                .disposed(by: disposeBag)
            scheduler.start()
            
            XCTAssertEqual(data.events, [.next(1, mocked)])
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_local_data_search() {
        do {
            viewModel = try ListViewModel(dataLoader: prepareLocalDataLoader())
            let data = scheduler.createObserver([ListViewModel.ModelType].self)
            
            viewModel
                .data
                .bind(to: data)
                .disposed(by: disposeBag)
            
            scheduler.createColdObservable([.next(10, ())])
                .bind(to: viewModel.fetchAction)
                .disposed(by: disposeBag)
            scheduler.createColdObservable([
                .next(20, "laptop"),
                .next(30, "laptop"),
                .next(40, "Slim-fitting"),
                .next(50, "laptop"),
                .next(60, ""),
            ])
                .bind(to: viewModel.searchTerm)
                .disposed(by: disposeBag)
            scheduler.start()
            
            let laptopSample = mocked.filter(matching: Predicate { $0.title.contains("laptop") } || Predicate { $0.description.contains("laptop") } )
            let slimFitSample = mocked.filter(matching: Predicate { $0.title.contains("Slim-fitting") } || Predicate { $0.description.contains("Slim-fitting") } )
            
            XCTAssertEqual(data.events, [
                .next(10, mocked),
                .next(20, laptopSample),
                .next(40, slimFitSample),
                .next(50, laptopSample),
                .next(60, mocked),
            ])
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }

}

extension ListViewModelTests {
    
    private func prepareLocalDataLoader() throws -> ListDataLoader {
        try DataLoaderMock.localMock()
    }
    
    private func prepareRealDataLoader() throws -> ListDataLoader {
        try DataLoaderMock.realMock()
    }
    
}
