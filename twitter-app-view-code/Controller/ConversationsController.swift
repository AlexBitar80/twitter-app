//
//  ConversationsController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class ConversationsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    func configureUI() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.title = "Conversations"

        view.backgroundColor = .white
    }
}
