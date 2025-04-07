//
//  WishRepository.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/5/25.
//

import Foundation
import RealmSwift

protocol WishRepository {
    
    func getAllFolder() -> [Folder]
    func getFolder(id: UUID) -> Folder
    func addFolder(name: String)
    
    func getWishes(folderId: UUID) -> [Wish]
    func addWish(name: String, price: Int, date: Date, folderId: UUID)
    func deleteWish(id: UUID)
}

final class RealmWishRepository: WishRepository {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
        let a = realm.objects(FolderData.self)
    }
    
    func getAllFolder() -> [Folder] {
        return realm.objects(FolderData.self).map { convert(folderData: $0) }
    }
    
    func getFolder(id: UUID) -> Folder {
        let folderData = realm.object(ofType: FolderData.self, forPrimaryKey: id)!
        return convert(folderData: folderData)
    }
    
    func addFolder(name: String) {
        let folder = FolderData(name: name)
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("추가 실패")
        }
    }
    
    func getWishes(folderId: UUID) -> [Wish] {
        let folder = realm.object(ofType: FolderData.self, forPrimaryKey: folderId)!
        
        return folder.wishes.map { convert(wishData: $0) }
    }
    
    func addWish(name: String, price: Int, date: Date, folderId: UUID) {
        let folder = realm.object(ofType: FolderData.self, forPrimaryKey: folderId)!
        let wish = WishData(name: name, date: date, price: price)
        do {
            try realm.write {
                folder.wishes.append(wish)
            }
        } catch {
            print("위시 저장 실패")
        }
        
    }
    
    func deleteWish(id: UUID) {
        let wish = realm.object(ofType: WishData.self, forPrimaryKey: id)!

        do {
            try realm.write {
                realm.delete(wish)
            }
        } catch {
            print("위시 삭제 실패")
        }
    }
    
    private func convert(folderData: FolderData) -> Folder {
        let wishes = Array(folderData.wishes.map { self.convert(wishData: $0) })
        return Folder(id: folderData.id, name: folderData.name, wishes: wishes)
    }
    
    private func convert(wishData: WishData) -> Wish {
        Wish(id: wishData.id, name: wishData.name, price: wishData.price, date: wishData.date)
    }
    
    
}

