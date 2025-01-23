//
//  UserStatus.swift
//  SeSACDay22Assignment
//
//  Created by 한수빈 on 1/23/25.
//

import UIKit

final class UserStatusManager {
    
    private init () { }
    
    enum UserStatus: Codable {
        case login
        case logout
        
        func replaceScene() -> Void {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            let rootVC = switch self {
            case .login: UINavigationController(rootViewController: ProfileViewController())
            case .logout: OnboardingViewController()
            }
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
    
    enum Level: String, Codable {
        case high = "상"
        case medium = "중"
        case low = "하"
    }
    
    static var status: UserStatus {
        get {
            guard let statusData = UserDefaults.standard.data(forKey: Key.status.rawValue),
                  let status = try? JSONDecoder().decode(UserStatus.self, from: statusData) else { return .logout }
            return status
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: Key.status.rawValue)
            }
        }
    }
    
    static var level: Level {
        get {
            guard let levelData = UserDefaults.standard.data(forKey: Key.level.rawValue),
                  let level = try? JSONDecoder().decode(Level.self, from: levelData) else { return .high }
            return level
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: Key.level.rawValue)
            }
        }
    }
    
    static var nickname: String {
        get {
            let nickname = UserDefaults.standard.string(forKey: Key.nickname.rawValue) ?? ""
            return nickname
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    static var birthday: String {
        get {
            let birthday = UserDefaults.standard.string(forKey: Key.birthday.rawValue) ?? ""
            return birthday
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.birthday.rawValue)
        }
    }
    
    enum Key: String {
        case status
        case level
        case nickname
        case birthday
    }
}


//@propertyWrapper
//struct Store<T> {
//    let key: String
//    let defaultValue: T
//
//    var wrappedValue: T {
//        get {
//            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: key)
//        }
//    }
//}
