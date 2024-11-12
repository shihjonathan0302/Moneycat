//
//  SceneDelegate.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var realmManager = RealmManager()  // Existing RealmManager instance

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // Temporarily clear and reload default categories
//            realmManager.clearAndReloadDefaultCategories()  // Step 2 - Place it here
            
            // Set the root view to ContentView and inject the RealmManager into the environment
            let contentView = ContentView()
                .environmentObject(realmManager)  // Pass RealmManager here

            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
