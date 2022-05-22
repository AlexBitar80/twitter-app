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
        
        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        self.tabBar.backgroundColor = .white
        
        let feed = FeedController()
        feed.tabBarItem.image = UIImage(systemName: "house")
        
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let notifications = NotificationsController()
        notifications.tabBarItem.image = UIImage(systemName: "bell")
        
        let conversations = ConversationsController()
        conversations.tabBarItem.image = UIImage(systemName: "envelope")
        
        setViewControllers([feed, explore, notifications, conversations], animated: false)
    }
}
