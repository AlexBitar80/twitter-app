//
//  UserService.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 04/07/22.
//

import Foundation
import FirebaseAuth

struct UserService {
	static let shared = UserService()

	func fetchUser() {
		guard let uid = Auth.auth().currentUser?.uid else { return }

		REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
			guard let dictionary = snapshot.value as? [String: AnyObject] else { return }

			guard
				let username = dictionary["username"] as? String,
				let fullname = dictionary["fullname"] as? String,
				let email = dictionary["email"] as? String
			else {
				return
			}

			print("DEBUG: username is \(username), email is \(email), and name is \(fullname)")
		}
	}
}
