//
//  FeedController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties

	private lazy var profileImageView: UIImageView = {
		let image = UIImageView()
		image.backgroundColor = .blue
		image.setDimensions(width: 30, height: 30)
		image.layer.cornerRadius = 32 / 2
		return image
	}()

	private lazy var highlightButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "highlight-icon-blue"), for: .normal)
		return button
	}()

	private lazy var imageLogo: UIImageView = {
		let logo = UIImageView()
		logo.image = UIImage(named: "twitter-logo-blue")
		return logo
	}()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.titleView = imageLogo
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: highlightButton)

        view.backgroundColor = .white
    }
}
