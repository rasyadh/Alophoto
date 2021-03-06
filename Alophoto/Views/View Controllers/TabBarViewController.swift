//
//  TabBarViewController.swift
//  Alophoto
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "tabBarView"
        self.tabBar.tintColor = UIColor.primary
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        self.viewControllers = [
            setViewControllerTabItem(
                storyboardName: "Home",
                title: Localify.get("home.title"),
                image: UIImage(named: "tab_home_inactive")!.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(named: "tab_home_active")!.withRenderingMode(.alwaysOriginal)
            ),
            setViewControllerTabItem(
                storyboardName: "Profile",
                title: Localify.get("profile.title"),
                image: UIImage(named: "tab_user_inactive")!.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(named: "tab_user_active")!.withRenderingMode(.alwaysOriginal)
            ),
        ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBar.barTintColor = UIColor.primary
    }
    
    // MARK: - Private function
    private func setViewControllerTabItem(storyboardName: String, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let viewController = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController()
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        viewController?.tabBarItem = tabItem
        
        return viewController!
    }
}
