//
//  NotificationsController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class NotificationsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    func configureUI() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Notifications"

        view.backgroundColor = .white
    }
}
