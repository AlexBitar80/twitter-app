//
//  TweetCell.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 09/07/22.
//

import Foundation
import UIKit

protocol TweetCellDelegate: AnyObject {
	func handleProfileImageTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
	// MARK: - Properties

	static let reuseIdentifier = "tweetCell"

	var tweet: Tweet? {
		didSet {
			configure()
		}
	}

	weak var delegate: TweetCellDelegate?

	private lazy var profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.setDimensions(width: 48, height: 48)
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = .blueTwitter
		imageView.layer.cornerRadius = 48 / 2

		let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
		imageView.addGestureRecognizer(tap)
		imageView.isUserInteractionEnabled = true
		return imageView
	}()

	private lazy var infoLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		label.text = "João Alexandre Bitar @joaoalexandreb"
		return label
	}()

	private lazy var captionLabel: UILabel = {
		let label = UILabel()
		label.adjustsFontSizeToFitWidth = true
		label.numberOfLines = 0
		label.text = "Olá, este é meu primeiro tweet dá rede! :D"
		label.font = UIFont.systemFont(ofSize: 14)
		return label
	}()

	private lazy var commentButton: UIButton = {
		let button = UIButton(type: .system)
		button.setDimensions(width: 20, height: 20)
		button.setImage(UIImage(named: "comment-icon"), for: .normal)
		button.tintColor = .darkGray
		button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
		return button
	}()

	private lazy var likesButton: UIButton = {
		let button = UIButton(type: .system)
		button.setDimensions(width: 20, height: 20)
		button.setImage(UIImage(named: "likes-icon"), for: .normal)
		button.tintColor = .darkGray
		button.addTarget(self, action: #selector(handleLikesTapped), for: .touchUpInside)
		return button
	}()

	private lazy var retweetButton: UIButton = {
		let button = UIButton(type: .system)
		button.setDimensions(width: 20, height: 20)
		button.setImage(UIImage(named: "retweet-icon"), for: .normal)
		button.tintColor = .darkGray
		button.addTarget(self, action: #selector(handleRetweetsTapped), for: .touchUpInside)
		return button
	}()

	private lazy var shareButton: UIButton = {
		let button = UIButton(type: .system)
		button.setDimensions(width: 20, height: 20)
		button.setImage(UIImage(named: "share-icon"), for: .normal)
		button.tintColor = .darkGray
		button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
		return button
	}()

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .white
		addSubview(profileImageView)
		profileImageView.anchor(
			top: topAnchor,
			left: safeAreaLayoutGuide.leftAnchor,
			paddingTop: 12,
			paddingLeft: 8
		)

		let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
		stack.axis = .vertical
		stack.spacing = 4
		stack.distribution = .fillProportionally
		addSubview(stack)
		stack.anchor(
			top: profileImageView.topAnchor,
			left: profileImageView.rightAnchor,
			right: safeAreaLayoutGuide.rightAnchor,
			paddingLeft: 8,
			paddingRight: 20
		)

		let actionStack = UIStackView(
			arrangedSubviews: [
				commentButton,
				retweetButton,
				likesButton,
				shareButton
			]
		)
		actionStack.axis = .horizontal
		actionStack.distribution = .equalCentering
		addSubview(actionStack)
		actionStack.anchor(
			left: profileImageView.rightAnchor,
			bottom: bottomAnchor,
			right: safeAreaLayoutGuide.rightAnchor,
			paddingLeft: 12,
			paddingBottom: 12,
			paddingRight: 48
		)

		let underlineView = UIView()
		underlineView.backgroundColor = .systemGroupedBackground
		addSubview(underlineView)
		underlineView.anchor(
			left: leftAnchor,
			bottom: bottomAnchor,
			right: rightAnchor,
			height: 1
		)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Selectors

	@objc func handleProfileImageTapped() {
	//	print("DEBUG: Handle profile image tapped in cell")
		delegate?.handleProfileImageTapped(self)
	}

	@objc func handleCommentTapped() {
		print("1")
	}

	@objc func handleLikesTapped() {
		print("2")
	}

	@objc func handleRetweetsTapped() {
		print("3")
	}

	@objc func handleShareTapped() {
		print("4")
	}

	// MARK: - Helpers

	func configure() {
		guard let tweet = tweet else { return }

		let viewModel = TweetViewModel(tweet: tweet)

		infoLabel.attributedText = viewModel.userInfoText
		captionLabel.text = tweet.caption
		profileImageView.sd_setImage(with: viewModel.profileImageUrl)
	}
}
