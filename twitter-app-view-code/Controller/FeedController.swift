//
//  FeedController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class FeedController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        let imageView = UIImageView(image: UIImage(named: "twitter-logo"))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.titleView = imageView
        
        view.backgroundColor = .white
    }
}
