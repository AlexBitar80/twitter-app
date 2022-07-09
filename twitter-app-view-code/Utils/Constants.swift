//
//  Constants.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 13/06/22.
//

import FirebaseDatabase
import FirebaseStorage

// swiftlint:disable identifier_name
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
