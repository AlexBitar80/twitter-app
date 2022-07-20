//
//  ProfileFillterView.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 15/07/22.
//

import UIKit

protocol ProfileFilterViewDelegate: AnyObject {
	func filterView(_ view: ProfileFillterView, didSelect indexpath: IndexPath)
}

class ProfileFillterView: UIView {
	// MARK: - Properties

	weak var delegate: ProfileFilterViewDelegate?

	lazy var colllectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		return collectionView
	}()

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .white

		addSubview(colllectionView)
		colllectionView.register(
			ProfileFillterCell.self,
			forCellWithReuseIdentifier: ProfileFillterCell.reuseIdentifier
		)

		let selectedIndexPath = IndexPath(row: 0, section: 0)
		colllectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)

		colllectionView.addConstraintsToFillView(self)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileFillterView: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let count = CGFloat(ProfileFilterOptions.allCases.count)

		return CGSize(width: frame.width / count, height: frame.height)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
}

// MARK: - UICollectionViewDataSource

extension ProfileFillterView: UICollectionViewDataSource {
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return ProfileFilterOptions.allCases.count
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: ProfileFillterCell.reuseIdentifier,
			for: indexPath
		) as? ProfileFillterCell else {
			return ProfileFillterCell()
		}

		let option = ProfileFilterOptions(rawValue: indexPath.row)
		cell.option = option

		return cell
	}
}

extension ProfileFillterView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.filterView(self, didSelect: indexPath)
	}
}
