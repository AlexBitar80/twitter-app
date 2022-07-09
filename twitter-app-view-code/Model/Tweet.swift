//
//  Tweet.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 09/07/22.
//

import Foundation

struct Tweet {
	let tweetID: String
	let uid: String
	let caption: String
	let likes: Int
	let retweetsCount: Int
	var timestamp: Date?

	init(tweetID: String, dictionary: [String: Any]) {
		self.tweetID = tweetID

		self.uid = dictionary["uid"] as? String ?? ""
		self.caption = dictionary["caption"] as? String ?? ""
		self.likes = dictionary["likes"] as? Int ?? 0
		self.retweetsCount = dictionary["retweets"] as? Int ?? 0

		if let timestamp = dictionary["timestamp"] as? Double {
			self.timestamp = Date(timeIntervalSince1970: timestamp)
		}
	}
}
