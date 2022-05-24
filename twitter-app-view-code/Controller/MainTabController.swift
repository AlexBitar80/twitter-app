//
//  MainTabController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemCyan
        tabBar.unselectedItemTintColor = .systemCyan
        tabBar.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        configureViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        let feed = FeedController()
        let explore = ExploreController()
        let notifications = NotificationsController()
        let conversations = ConversationsController()

        viewControllers = [
            ambedInNavigationController(vc: feed, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill")),
            ambedInNavigationController(vc: explore, image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")),
            ambedInNavigationController(vc: notifications, image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill")),
            ambedInNavigationController(vc: conversations, image: UIImage(systemName: "envelope"), selectedImage: UIImage(systemName: "envelope.fill"))
        ]
    }
    
    private func ambedInNavigationController(vc: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
}
