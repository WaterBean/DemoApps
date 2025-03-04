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
}
