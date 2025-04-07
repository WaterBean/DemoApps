//
//  Wish.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/5/25.
//

import Foundation

struct Wish: Hashable, Identifiable {
    let id: UUID
    let name: String
    let price: Int
    let date: Date
    
    init(id: UUID, name: String, price: Int, date: Date) {
        self.id = id
        self.name = name
        self.price = price
        self.date = date
    }
}

struct Folder: Hashable {
    let id: UUID
    let name: String
    var wishes: [Wish]
    init(id: UUID, name: String, wishes: [Wish]) {
        self.id = id
        self.name = name
        self.wishes = wishes
    }
//
//    init(name: String, wishes: [Wish]) {
//        let id = UUID()
//        self.name = name
//        self.wishes = wishes
//    }
//    
//    init(folderData: FolderData) {
//        self.id = folderData.id
//        self.name = folderData.name
//        self.wishes = Array(_immutableCocoaArray: folderData.wishes)
//    } 상호 데이터 변환 로직을.... 모델에서 가지고 있는게 맞을까?
}
