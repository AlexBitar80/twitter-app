//
//  ProfileFillterCell.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 15/07/22.
//

import UIKit

class ProfileFillterCell: UICollectionViewCell {
	// MARK: - Propertie

	static let reuseIdentifier = "profileFillterCell"

	var option: ProfileFilterOptions? {
		didSet {
			titleLabel.text = option?.descrition
		}
	}

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.text = "Tweets"
		return label
	}()

	// MARK: - Lifecyle

	override var isSelected: Bool {
		didSet {
			titleLabel.font = isSelected ?
			UIFont.boldSystemFont(ofSize: 16) :
			UIFont.systemFont(ofSize: 14)

			titleLabel.textColor = isSelected ?
			UIColor.blueTwitter :
			UIColor.lightGray
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(titleLabel)
		titleLabel.center(inView: self)
		backgroundColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
