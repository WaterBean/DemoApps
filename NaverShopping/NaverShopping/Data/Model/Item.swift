//
//  Item.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//


struct ItemResponse: Decodable {
    let total: Int
    var start: Int
    var items: [Item]
}


struct Item: Decodable {
    let productId: String
    let title: String
    let link: String
    let image: String
    let mallName: String
    let lprice: String
    
    init(productId: String, title: String, link: String, image: String, mallName: String, lprice: String) {
        self.productId = productId
        self.title = title
        self.link = link
        self.image = image
        self.mallName = mallName
        self.lprice = lprice
    }
    
    init(itemData: ItemData) {
        self.productId = itemData.id
        self.title = itemData.title
        self.link = itemData.link
        self.image = itemData.image
        self.mallName = itemData.mallName
        self.lprice = itemData.lprice
    }
}
