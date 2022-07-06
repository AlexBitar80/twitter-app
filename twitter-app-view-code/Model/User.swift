//
//  User.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 05/07/22.
//

import Foundation

struct User {
	let uid: String
	let email: String
	let username: String
	let profileImageUrl: String

	init(uid: String, dictionary: [String: AnyObject]) {
		self.uid = uid
		self.email = dictionary["email"] as? String ?? ""
		self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
		self.username = dictionary["username"] as? String ?? ""
	}
}
