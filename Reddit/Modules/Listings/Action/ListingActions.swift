//
//  ListingActions.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import ReSwift

enum ListingSortCategory {
	case controversial
	case hot
	case new
	case random
	case top
}

struct FetchListing {
	static func fetchListing(state: AppState, store: Store<AppState>) -> Action? {
		ListingServices().fetchHotListing(subreddit: state.listingState.subreddit,
		                                  after: nil,
		                                  before: nil) { (listing) in
			store.dispatch(SetListingAction(listing: listing, isListingNextPage: false))
		}

		return FetchingListingAction(isLoadingNextPage: false)
	}

	static func fetchListingNextPage(state: AppState, store: Store<AppState>) -> Action? {
		ListingServices().fetchHotListing(subreddit: state.listingState.subreddit,
		                                  after: state.listingState.after,
		                                  before: state.listingState.before) { (listing) in
			store.dispatch(SetListingAction(listing: listing, isListingNextPage: true))
		}

		return FetchingListingAction(isLoadingNextPage: true)
	}
}

struct FetchingListingAction: Action {
	var isLoadingNextPage: Bool
}

struct SetListingInfo: Action {
	let subreddit: String
	let category: ListingSortCategory
}

struct SetListingAction: Action {
	let listing: Listing
	let isListingNextPage: Bool
}
