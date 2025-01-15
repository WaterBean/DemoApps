//
//  Item.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//


struct ItemResponse: Decodable {
    let total: Int
    let start: Int
    var items: [Item]
}


struct Item: Decodable {
    let title: String
    let image: String
    let mallName: String
    let lprice: String
}
