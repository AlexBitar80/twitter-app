//
//  ProfileController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 13/07/22.
//

import UIKit

class ProfileController: UICollectionViewController {
	// MARK: - Properties

	private let user: User

	private var tweets: [Tweet] = [] {
		didSet {
			collectionView.reloadData()
		}
	}

	// MARK: - Lifecycle

	init(user: User) {
		self.user = user
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		configureCollectionView()
		fetchTweet()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - API

	func fetchTweet() {
		TweetService.shared.fetchTweets(forUser: user) { tweets in
			self.tweets = tweets
		}
	}

	// MARK: - Helpers

	func configureCollectionView() {
		collectionView.backgroundColor = .white
		collectionView.showsVerticalScrollIndicator = false
		collectionView.contentInsetAdjustmentBehavior = .never

		collectionView.register(
			TweetCell.self,
			forCellWithReuseIdentifier: TweetCell.reuseIdentifier
		)
		collectionView.register(
			ProfileHeader.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: ProfileHeader.reuseIdentifier
		)
	}
}

// MARK: - CollectionViewDataSource

extension ProfileController {
	override func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return tweets.count
	}

	override func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: TweetCell.reuseIdentifier,
			for: indexPath
		) as? TweetCell else {
			return TweetCell()
		}

		cell.tweet = tweets[indexPath.row]
		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension ProfileController {
	override func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		guard let header = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: ProfileHeader.reuseIdentifier,
			for: indexPath
		) as? ProfileHeader else {
			return ProfileHeader()
		}
		header.user = user
		header.delegate = self
		return header
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForHeaderInSection section: Int
	) -> CGSize {
		return CGSize(width: view.frame.width, height: 350)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(width: view.frame.width, height: 120)
	}
}

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
	func handleDismissal() {
		navigationController?.popViewController(animated: true )
	}
}
