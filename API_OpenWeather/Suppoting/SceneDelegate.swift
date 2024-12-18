//
//  SceneDelegate.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 12/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        
//        let rootViewController = ViewController()
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        
//        window.rootViewController = navigationController
//        
//        self.window = window
//        self.window?.makeKeyAndVisible()
//    }
//    
// }
