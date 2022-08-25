//
//  ProfielHeader.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 13/07/22.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject {
	func handleDismissal()
}

class ProfileHeader: UICollectionReusableView {
	// MARK: - Properties
	static let reuseIdentifier = "profileHeader"

	var user: User? {
		didSet {
			configure()
		}
	}

	weak var delegate: ProfileHeaderDelegate?

	private let fillterBar = ProfileFillterView()

	private lazy var containerView: UIView = {
		let view = UIView()

		view.backgroundColor = .blueTwitter
		view.addSubview(backButton)

		backButton.setDimensions(width: 30, height: 30)
		backButton.anchor(
			top: view.topAnchor,
			left: view.leftAnchor,
			paddingTop: 42,
			paddingLeft: 16
		)
		return view
	}()

	private lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
		button.tintColor = .white
		button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
		return button
	}()

	private lazy var profileImageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.backgroundColor = .lightGray
		image.clipsToBounds = true
		image.layer.borderColor = UIColor.white.cgColor
		image.setDimensions(width: 80, height: 80)
		image.layer.cornerRadius = 80 / 2
		image.layer.borderWidth = 4
		return image
	}()

	private lazy var editProfileFollowButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .white
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.setTitleColor(UIColor.blueTwitter, for: .normal)
		button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
		button.tintColor = UIColor.blueTwitter
		button.setDimensions(width: 100, height: 36)
		button.layer.cornerRadius = 36 / 2
		button.layer.borderWidth = 1.25
		button.layer.borderColor = UIColor.blueTwitter.cgColor
		return button
	}()

	private lazy var fullnameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 20)
		return label
	}()

	private lazy var usernameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.font = UIFont.systemFont(ofSize: 16)
		return label
	}()

	private lazy var bioLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 3
		label.text = "iOS Developer"
		label.font = UIFont.systemFont(ofSize: 16)
		return label
	}()

	private let underlineView: UIView = {
		let view = UIView()
		view.backgroundColor = .blueTwitter
		return view
	}()

	private lazy var followingLabel: UILabel = {
		let label = UILabel()
		let tapped = UIGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
		label.addGestureRecognizer(tapped)
		label.isUserInteractionEnabled = true
		return label
	}()

	private lazy var followersLabel: UILabel = {
		let label = UILabel()
		let tapped = UIGestureRecognizer(target: self, action: #selector(handleFollwersTapped))
		label.addGestureRecognizer(tapped)
		label.isUserInteractionEnabled = true
		return label
	}()

    private lazy var userDetailStack = UIStackView(
		arrangedSubviews: [
			fullnameLabel,
			usernameLabel,
			bioLabel
		]
	)

	private lazy var followStack = UIStackView(
		arrangedSubviews: [
			followingLabel,
			followersLabel
		]
	)

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		fillterBar.delegate = self
		backgroundColor = .white

		setupViews()
		setConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Selectors

	@objc func handleDismissal() {
		delegate?.handleDismissal()
	}

	@objc func handleEditProfileFollow() {
		print("handleEditProfileFollow")
	}

	@objc func handleFollowingTapped() {
		print("handleFollowingTapped")
	}

	@objc func handleFollwersTapped() {
		print("handleFollwersTapped")
	}

	// MARK: - Helpers

	func configure() {
		guard let user = user else { return }

		let viewModel = ProfileHeaderViewModel(user: user)

		profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)

		editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)

		followersLabel.attributedText = viewModel.followersString
		followingLabel.attributedText = viewModel.followingString

		fullnameLabel.text = viewModel.fullnameText
		usernameLabel.text = viewModel.usernameText
	}

	func setupViews() {
		addSubview(containerView)
		addSubview(editProfileFollowButton)
		addSubview(profileImageView)
		addSubview(userDetailStack)
		addSubview(fillterBar)
		addSubview(underlineView)
		addSubview(followStack)
	}

    // swiftlint:disable function_body_length
	private func setConstraints() {
		containerView.anchor(
			top: topAnchor,
			left: leftAnchor,
			right: rightAnchor,
			height: 108
		)

		editProfileFollowButton.anchor(
			top: containerView.bottomAnchor,
			right: rightAnchor,
			paddingTop: 12,
			paddingRight: 12
		)

		profileImageView.anchor(
			top: containerView.bottomAnchor,
			left: leftAnchor,
			paddingTop: -24,
			paddingLeft: 8
		)

		userDetailStack.axis = .vertical
		userDetailStack.setCustomSpacing(4, after: fullnameLabel)
		userDetailStack.setCustomSpacing(10, after: usernameLabel)

		userDetailStack.anchor(
			top: profileImageView.bottomAnchor,
			left: leftAnchor,
			right: rightAnchor,
			paddingTop: 8,
			paddingLeft: 12,
			paddingRight: 12
		)

		fillterBar.anchor(
			left: leftAnchor,
			bottom: bottomAnchor,
			right: rightAnchor,
			height: 50
		)

		underlineView.anchor(
			left: leftAnchor,
			bottom: bottomAnchor,
			width: frame.width / 3,
			height: 2
		)

		followStack.spacing = 8
		followStack.distribution = .fillEqually
		followStack.axis = .horizontal

		followStack.anchor(
			top: userDetailStack.bottomAnchor,
			left: leftAnchor,
			paddingTop: 12,
			paddingLeft: 12
		)
	}
}

// MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
	func filterView(_ view: ProfileFillterView, didSelect indexpath: IndexPath) {
		guard let cell = view.colllectionView.cellForItem(
			at: indexpath
		)as? ProfileFillterCell else {
			return
		}

		let xPosition = cell.frame.origin.x

		UIView.animate(withDuration: 0.3) {
			self.underlineView.frame.origin.x = xPosition
		}
	}
}
