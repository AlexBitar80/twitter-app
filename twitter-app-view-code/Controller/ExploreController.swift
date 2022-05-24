//
//  ExplorerController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class ExploreController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Explore"
        view.backgroundColor = .white
    }
}
