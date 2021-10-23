//
//  AppDelegate.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 22/10/2021.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var launchRouter: LaunchRouting?
    public var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let router = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = router
        router.launch(from: window)
        return true
    }

}

