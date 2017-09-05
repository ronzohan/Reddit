//
//  ListingReducer.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import ReSwift

struct ListingReducer {
	static func listingReducer(action: Action, state: ListingState?) -> ListingState {
		var state = state ?? ListingState(listing: Listing())

		switch action {
		case let action as SetListingAction:

			if action.isListingNextPage {
				state.loadingState = .finishedLoadingNextPage
			} else {
				state.loadingState = .finishedLoading
			}

			state.listing = action.listing
			state.after = action.listing.after
			state.before = action.listing.before
			return state
		case let action as FetchingListingAction:

			if action.isLoadingNextPage {
				state.loadingState = .loadingNextPage
			} else {
				state.loadingState = .initialLoading
			}

			return state
		case let action as SetListingInfo:
			state.subreddit = action.subreddit
			state.loadingState = .finishedLoading

			return state
		default:
			return state
		}
	}
}
