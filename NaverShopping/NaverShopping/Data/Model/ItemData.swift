//
//  ItemData.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/4/25.
//

import Foundation
import RealmSwift

final class ItemData: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var mallName: String
    @Persisted var lprice: String
    
    convenience init(item: Item) {
        self.init()
        self.id = item.productId
        self.title = item.title
        self.link = item.link
        self.image = item.image
        self.mallName = item.mallName
        self.lprice = item.lprice
    }
    
}
