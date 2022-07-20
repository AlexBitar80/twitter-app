//
//  ProfileHeaderViewModel.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 18/07/22.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
	case tweets
	case replies
	case likes

	var descrition: String {
		switch self {
		case .tweets:
			return "Tweets"
		case .replies:
			return "Tweets & Replies"
		case .likes:
			return "Likes"
		}
	}
}

struct ProfileHeaderViewModel {
	private let user: User

	var fullnameText: String
	var usernameText: String

	init(user: User) {
		self.user = user

		self.fullnameText = user.fullname
		self.usernameText = "@" + user.username
	}

	var actionButtonTitle: String {
		if user.currentUser {
			return "Edit Profile"
		} else {
			return "Follow"
		}
	}

	var followersString: NSAttributedString? {
		return attributedText(withValue: 78, text: " Followers")
	}

	var followingString: NSAttributedString? {
		return attributedText(withValue: 68, text: " Following")
	}

	private func attributedText(withValue value: Int, text: String) -> NSAttributedString {
		let attributedTitle = NSMutableAttributedString(
			string: "\(value)",
			attributes: [
				NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
			]
		)

		attributedTitle.append(NSAttributedString(
			string: "\(text)",
			attributes: [
				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
				NSAttributedString.Key.foregroundColor: UIColor.lightGray
			]
		))

		return attributedTitle
	}
}
