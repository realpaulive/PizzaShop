//
//  TabBarController.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpAppearance()
        setUpTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let items = tabBar.items else { return }
        items[0].title = "Меню"
        items[1].title = "Контакты"
        items[2].title = "Профиль"
        items[3].title = "Корзина"
    }
    
    private func setUpAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func setUpTabBar() {
        let vc = MenuViewController()
        let networkService = NetworkService()
        let presenter = MenuPresenter(view: vc, networkService: networkService)
        vc.presenter = presenter
        
        let menuVC = createNavController(viewController: vc, imageName: "Menu")
        
        let contactsVC = createNavController(viewController: UIViewController(), imageName: "Contacts")
        contactsVC.visibleViewController?.title = "Контакты"
        contactsVC.navigationBar.prefersLargeTitles = true
        
        let profileVC = createNavController(viewController: UIViewController(), imageName: "Profile")
        profileVC.visibleViewController?.title = "Профиль"
        profileVC.navigationBar.prefersLargeTitles = true
       
        let cartVC = createNavController(viewController: UIViewController(), imageName: "Cart")
        cartVC.visibleViewController?.title = "Корзина"
        cartVC.navigationBar.prefersLargeTitles = true

        viewControllers = [menuVC, contactsVC, profileVC, cartVC]
    }
    
    private func createNavController(viewController: UIViewController, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: imageName)
        tabBar.tintColor = .systemPink
        return navController
    }
}

