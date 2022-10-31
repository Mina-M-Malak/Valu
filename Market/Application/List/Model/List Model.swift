//
//  List Model.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation
import RxDataSources

struct ListSection {
    
    var header: String = "section"
    var items: [Model.Service.Item]
    
}

//MARK: - IdentifiableType
extension Model.Service.Item: IdentifiableType {
    
    var identity: Int {
        return identifier
    }
    
}

//MARK: - AnimatableSectionModelType
extension ListSection: AnimatableSectionModelType {

    var identity: String {
        return header
    }
    
    init(original: ListSection, items: [Model.Service.Item]) {
        self = original
        self.items = items
    }

}
