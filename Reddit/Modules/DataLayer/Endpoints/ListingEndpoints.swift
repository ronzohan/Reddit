//
//  ListingEndpoints.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/17/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class ListingEndpoints {

}

class ListingHotEndpoint {
	var parameters: [String: Any]? {
		didSet {
			buildUrl()
		}
	}

	var url: String {
		return _url
	}

	private var _url: String = "https://www.reddit.com/r/<subreddit>/hot"

	func buildUrl() {
		if let params = parameters {
			for (key, value) in params {
				let pattern = "<" + key + ">"

				let replacement = value as? String ?? String(describing: value)

				if _url.contains(pattern) {
					_url = _url.replacingOccurrences(of: pattern, with: replacement)
				}
			}
		}
	}
}
