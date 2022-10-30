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

extension Model.Service.Item: IdentifiableType {
    
    var identity: Int {
        return self.identifier
    }
    
}

extension ListSection: AnimatableSectionModelType {

    var identity: String {
        return self.header
    }
    
    init(original: ListSection, items: [Model.Service.Item]) {
        self = original
        self.items = items
    }

}
