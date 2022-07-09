//
//  UploadTweetController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 07/07/22.
//

import UIKit

class UploadTweetController: UIViewController {
	// MARK: - Properties

	private let user: User

	private lazy var actionButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .blueTwitter
		button.setTitle("Tweet", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		button.setTitleColor(UIColor.white, for: .normal)
		button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
		button.layer.cornerRadius = 32 / 2
		return button
	}()

	private lazy var profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.setDimensions(width: 48, height: 48)
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 48 / 2
		return imageView
	}()

	private let captionTextView = CaptionTextView()

	// MARK: - Lifecycle

	init(user: User) {
		self.user = user

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		configureUI()
	}

	// MARK: - Selectors

	@objc func handleCancel() {
		dismiss(animated: true, completion: nil)
	}

	@objc func handleUploadTweet() {
		guard let caption = captionTextView.text else { return }

		TweetService.shared.uploadTweets(caption: caption) { error, _ in
			if let error = error {
				print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
				return
			}

			self.dismiss(animated: true, completion: nil)
		}
	}

	// MARK: - Helpers

	private func configureUI() {
		view.backgroundColor = .white

		configureNavigationBar()

		let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
		stack.backgroundColor = .white
		stack.axis = .horizontal
		stack.spacing = 12

		view.addSubview(stack)

		stack.anchor(
			top: view.safeAreaLayoutGuide.topAnchor,
			left: view.leftAnchor,
			right: view.rightAnchor,
			paddingTop: 16,
			paddingLeft: 16,
			paddingRight: 16
		)
		profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
	}

	func configureNavigationBar() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.scrollEdgeAppearance = appearance

		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .cancel,
			target: self,
			action: #selector(handleCancel)
		)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
	}
}
