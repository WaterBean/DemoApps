//
//  WishData.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/5/25.
//

import Foundation
import RealmSwift

final class WishData: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var date: Date
    @Persisted var price: Int
    @Persisted(originProperty: "wishes") var folder: LinkingObjects<FolderData>
    
    convenience init(name: String, date: Date, price: Int) {
        self.init()
        self.id = UUID()
        self.name = name
        self.date = date
        self.price = price
    }
    
}

final class FolderData: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted(indexed: true) var name: String
    @Persisted var wishes: List<WishData>

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
