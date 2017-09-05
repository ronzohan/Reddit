//
//  ListingServices.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

struct ListingServices: ListingUseCase {
	func fetchHotListing(subreddit: String,
	                     after: String? = nil,
	                     before: String? = nil,
	                     completion: @escaping (Listing) -> Void
		) {
		debugPrint("Called Repository")
		let url = "https://www.reddit.com/r/\(subreddit)/.json"

		let afterHash: String
		let beforeHash: String

		if let after = after {
			afterHash = after
		} else {
			afterHash = ""
		}

		if let before = before {
			beforeHash = before
		} else {
			beforeHash = ""
		}

		let parameters: [String: Any
			] = [
			"raw_json": 1,
			"after": afterHash,
			"before": beforeHash
		]

		let request = Alamofire.request(url, method: .get, parameters: parameters)

		request.responseObject { (response: DataResponse<Listing>) in
			guard let value = response.result.value else {
				return
			}

			DispatchQueue.main.async {
				completion(value)
			}
		}
    }
}
