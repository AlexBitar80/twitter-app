//
//  FeedController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    // MARK: - Properties

	var user: User? {
		didSet {
			configureLeftBarButton()
		}
	}

	private lazy var profileImageView: UIImageView = {
		let image = UIImageView()
		image.setDimensions(width: 30, height: 30)
		image.layer.cornerRadius = 32 / 2
		image.layer.masksToBounds = true
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
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: highlightButton)

        view.backgroundColor = .white
    }

	func configureLeftBarButton() {
		guard let user = user else { return }

		profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)

		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
	}
}
