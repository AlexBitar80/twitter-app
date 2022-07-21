//
//  TweetService.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 09/07/22.
//

import FirebaseDatabase
import FirebaseAuth

struct TweetService {
	static let shared = TweetService()

	func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
		guard let uid = Auth.auth().currentUser?.uid else { return }

		let values = [
			"uid": uid,
			"caption": caption,
			"likes": 0,
			"retweets": 0,
			"timestamp": Int(NSDate().timeIntervalSince1970)
		] as [
			String: Any
		]

		let reference = REF_TWEETS.childByAutoId()

		reference.updateChildValues(values) { _, reference in
			guard let tweetID = reference.key else { return }

			REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
		}
	}

	func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
		var tweets: [Tweet] = []

		REF_TWEETS.observe(.childAdded) { snapshot in
			guard let dictionary = snapshot.value as? [String: Any] else { return }
			guard let uid = dictionary["uid"] as? String else { return }
			let tweetID = snapshot.key

			UserService.shared.fetchUser(uid: uid) { user in
				let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
				tweets.append(tweet)
				completion(tweets)
			}
		}
	}

	func fetchTweets(forUser user: User, completion: @escaping([Tweet]) -> Void) {
		var tweets: [Tweet] = []

		REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
			let tweetID = snapshot.key

			REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
				guard let dictionary = snapshot.value as? [String: Any] else { return }
				guard let uid = dictionary["uid"] as? String else { return }

				UserService.shared.fetchUser(uid: uid) { user in
					let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
					tweets.append(tweet)
					completion(tweets)
				}
			}
		}
	}
}
