//
//  FeedController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    // MARK: - Properties

	var user: User? {
		didSet {
			configureLeftBarButton()
		}
	}

	private var tweets: [Tweet] = [] {
		didSet {
			collectionView.reloadData()
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

		collectionView.showsHorizontalScrollIndicator = false

        configureUI()
		fetchTweets()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = false
	}

	override func viewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		super.viewWillTransition(to: size, with: coordinator)
		collectionView?.collectionViewLayout.invalidateLayout()
	}

	// MARK: - API

	func fetchTweets() {
		TweetService.shared.fetchTweets { tweets in
			self.tweets = tweets
		}
	}

    // MARK: - Helpers

    func configureUI() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		collectionView.showsVerticalScrollIndicator = false
		collectionView.register(
			TweetCell.self,
			forCellWithReuseIdentifier: TweetCell.reuseIdentifier
		)
		collectionView.backgroundColor = .white

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.titleView = imageLogo
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			customView: highlightButton
		)
    }

	func configureLeftBarButton() {
		guard let user = user else { return }

		profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)

		navigationItem.leftBarButtonItem = UIBarButtonItem(
			customView: profileImageView
		)
	}
}

// MARK: - CollectionViewDataSource

extension FeedController {
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

		cell.delegate = self
		cell.tweet = tweets[indexPath.row]

		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(width: view.frame.width, height: 120)
	}
}

// MARK: - TweetCellDelegate

extension FeedController: TweetCellDelegate {
	func handleProfileImageTapped(_ cell: TweetCell) {
		guard let user = cell.tweet?.user else { return }

		let controller = ProfileController(user: user)
		navigationController?.pushViewController(controller, animated: true)
	}
}
