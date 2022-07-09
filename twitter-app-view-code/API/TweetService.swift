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

	func uploadTweets(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
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

		REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
	}

	func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
		var tweets: [Tweet] = []

		REF_TWEETS.observe(.childAdded) { snapshot in
			guard let dictionary = snapshot.value as? [String: Any] else { return }
			let tweetID = snapshot.key
			let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
			tweets.append(tweet)
			completion(tweets)
		}
	}
}
