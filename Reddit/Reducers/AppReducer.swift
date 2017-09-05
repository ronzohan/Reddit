//
//  AppReducer.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import ReSwift

struct AppReducer {
	static func appReducer(action: Action, state: AppState?) -> AppState {
		return AppState(listingState: ListingReducer.listingReducer(action: action, state: state?.listingState))
	}
}
