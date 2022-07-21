//
//  User.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 05/07/22.
//

import FirebaseAuth

struct User {
	let uid: String
	let email: String
	let fullname: String
	let username: String
	var profileImageUrl: URL?

	var currentUser: Bool {
		return Auth.auth().currentUser?.uid == uid
	}

	init(uid: String, dictionary: [String: AnyObject]) {
		self.uid = uid
		self.email = dictionary["email"] as? String ?? ""
		self.fullname = dictionary["fullname"] as? String ?? ""
		self.username = dictionary["username"] as? String ?? ""

		if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
			guard let url = URL(string: profileImageUrlString) else { return }

			self.profileImageUrl = url
		}
	}
}
