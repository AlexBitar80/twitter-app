//
//  MainTabController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.blueTwitter
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        view.backgroundColor = .blueTwitter
        authenticateUserAndConfigureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
            configureViewControllers()
            setConstraints()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Did log user out...")
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped() {
        print(1234)
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(actionButton)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setConstraints() {
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
    }
    
    func configureViewControllers() {
        let feed = FeedController()
        let explore = ExploreController()
        let notifications = NotificationsController()
        let conversations = ConversationsController()
        
        let feedNav = ambedInNavigationController(vc: feed,
                                                   image: UIImage(systemName: "house"),
                                                   selectedImage: UIImage(systemName: "house.fill"))
        
        let exploreNav = ambedInNavigationController(vc: explore,
                                                      image: UIImage(systemName: "magnifyingglass.circle"),
                                                      selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        let notificationsNav = ambedInNavigationController(vc: notifications,
                                                            image: UIImage(systemName: "bell"),
                                                            selectedImage: UIImage(systemName: "bell.fill"))
        
        let conversationsNav = ambedInNavigationController(vc: conversations,
                                                            image: UIImage(systemName: "envelope"),
                                                            selectedImage: UIImage(systemName: "envelope.fill"))

        viewControllers = [feedNav, exploreNav, notificationsNav, conversationsNav]
    }
    
    private func ambedInNavigationController(vc: UIViewController, image: UIImage?,
                                              selectedImage: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
}
