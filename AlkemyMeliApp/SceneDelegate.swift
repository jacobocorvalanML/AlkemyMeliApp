//
//  SceneDelegate.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 14/09/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let vc: TabBarController = TabBarController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        
//        let searchViewController = SearchViewController()
//        let navController = UINavigationController(rootViewController: searchViewController)
//
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
    }




}

