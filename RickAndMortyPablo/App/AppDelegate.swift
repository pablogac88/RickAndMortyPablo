//
//  AppDelegate.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//

import UIKit
import SwinjectStoryboard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        // Set first navigation with DI
        let storyboard = SwinjectStoryboard.create(name: NavigationScene.characterList.rawValue, bundle: nil)
        navigationController = UINavigationController(rootViewController: storyboard.instantiateInitialViewController() as! CharacterListViewController)
        navigationController?.isNavigationBarHidden = true
        window.rootViewController = navigationController
        
        return true
    }
}

