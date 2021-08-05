//
//  SceneDelegate.swift
//  Ball Runner
//
//  Created by Gui Reis on 20/07/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let navigationController = UINavigationController(rootViewController: MenuViewController())
//        navigationController.navigationBar.isHidden = true
//
//        self.window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//
        self.window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MenuViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

