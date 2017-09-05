//
//  ListingState.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import ReSwift

enum LoadingState {
	case initialLoading
	case loadingNextPage
	case finishedLoading
	case finishedLoadingNextPage
}

struct ListingState: StateType {
	var listing: Listing

	var loadingState: LoadingState

	var subreddit: String
	var before: String?
	var after: String?

	init(listing: Listing) {
		self.listing = listing
		self.loadingState = .initialLoading

		self.subreddit = ""
	}
}
