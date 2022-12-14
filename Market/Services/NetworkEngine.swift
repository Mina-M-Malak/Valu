//
//  NetworkEngine.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation

import RxSwift

import Alamofire
import RxAlamofire

struct Request {
    
    enum InitError: Swift.Error {
        
        case base
        case relative
        
    }
    
    fileprivate enum Method {
    
        case get
        
    }
    
    let url: URL
    fileprivate let method: Method
    
}

extension Request {
    
    init(base: String,
         relativePath: String) throws {
        guard var urlComponents = URLComponents(string: base) else {
            throw InitError.base
        }
        urlComponents.path = relativePath
        guard let url = urlComponents.url else {
            throw InitError.relative
        }
        self.init(url: url, method: .get)
    }
    
    init(base: URL,
         relativePath: String) throws {
        guard var urlComponents = URLComponents(url: base,
                                                resolvingAgainstBaseURL: true)
            else {
            throw InitError.base
        }
        urlComponents.path = relativePath
        guard let url = urlComponents.url else {
            throw InitError.relative
        }
        self.init(url: url, method: .get)
    }
    
}

extension Request.Method {
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
}

protocol NetworkEngine {
    
    func perform(request: Request) -> Observable<Data>
    
    func cancelAllRequets()
    
}

extension Session: NetworkEngine {
    
    func perform(request: Request) -> Observable<Data> {
        return RxAlamofire.requestData(request.method.alamofireMethod,
                                       request.url)
            .map({ (_, data) -> Data in
                return data
            })
    }
    
    func cancelAllRequets() {
        session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            let cancel: (URLSessionTask) -> Void = { (task) in
                task.cancel()
            }
            dataTasks.forEach(cancel)
            uploadTasks.forEach(cancel)
            downloadTasks.forEach(cancel)
        }
    }
    
}
