//
//  ListingRepository.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

protocol ListingUseCase {
	func fetchHotListing(subreddit: String, after: String?, before: String?, completion: @escaping (Listing) -> Void)
}
