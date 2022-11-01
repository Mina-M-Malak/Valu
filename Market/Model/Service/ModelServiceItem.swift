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
        let category: String
        private let price: Double
        private let imageURLString: String
        let rate: RateModel
    }
    
    struct RateModel: Codable {
        let rate: Double
        let count: Int
    }
    
}

extension Model.Service.Item: Codable {
    
    private enum CodingKeys: String, CodingKey {
        
        case identifier = "id"
        case title , description , price , category
        case imageURLString = "image"
        case rate = "rating"
    }
    
}

extension Model.Service.Item: Equatable { }

extension Model.Service.RateModel: Equatable { }

extension Model.Service.Item {
    
    var imageURL: URL? {
        return URL(string: imageURLString)
    }
    
    var priceString: String? {
        return "\(price) EGP"
    }

}
