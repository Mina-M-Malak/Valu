//
//  ModelServiceItem.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation

extension Model.Service {
    
    struct Item {
        
        let identifier: Int
        let title: String
        let description: String
        let price: Double
        private let imageURLString: String
        
    }
    
}

extension Model.Service.Item: Codable {
    
    private enum CodingKeys: String, CodingKey {
        
        case identifier = "id"
        case title , description , price
        case imageURLString = "image"
        
    }
    
}

extension Model.Service.Item: Equatable { }

extension Model.Service.Item {
    
    var imageURL: URL? {
        return URL(string: imageURLString)
    }

}
