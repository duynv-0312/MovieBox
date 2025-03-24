//
//  SceneDelegate.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        showTabbar(window: window)
    }
}

extension SceneDelegate {
    private func showTabbar(window: UIWindow?) {
        guard let window = window else { return }
        let vc = TabBarViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
