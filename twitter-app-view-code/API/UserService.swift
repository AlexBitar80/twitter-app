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

			let user = User(uid: uid, dictionary: dictionary)

			print("DEBUG: username is \(user.username)")
		}
	}
}
