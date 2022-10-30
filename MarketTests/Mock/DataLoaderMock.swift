//
//  DataLoaderMock.swift
//  MarketTests
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation

@testable import Market

import Alamofire

import RxSwift

final class DataLoaderMock {
    
    static func localMock() throws -> ListDataLoader {
        return Local()
    }
    
    static func realMock() throws -> ListDataLoader {
        return try DataLoader(base: "https://fakestoreapi.com",
                              engine: Session(configuration: URLSessionConfiguration.default))
    }
    
}

extension DataLoaderMock {
    
    final class Local: ListDataLoader {
        
        func loadItems() -> Observable<[ModelType]> {
            return Observable.just(type(of: self).loadItems())
        }
        
        static func loadItems() -> [ModelType] {
            do {
            guard let path = Bundle(for: self).path(forResource: "items_v2", ofType: "json") else {
                fatalError("File not found")
            }
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Model.Service.Item].self, from: data)
            }
            catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
