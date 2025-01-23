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
    
    static var userStatus: UserStatus {
        get {
            guard let statusData = UserDefaults.standard.data(forKey: Key.userStatus.rawValue),
                  let status = try? JSONDecoder().decode(UserStatus.self, from: statusData) else { return .logout }
            print(statusData,status)
            return status
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: Key.userStatus.rawValue)
            }
        }
    }
    
    private enum Key: String {
        case userStatus
    }
}
