//
//  SceneDelegate.swift
//  ARFaceMask
//
//  Created by Emre on 6.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let rootController = FaceMaskController()
        window?.rootViewController = UINavigationController(rootViewController: rootController)

    }


}

