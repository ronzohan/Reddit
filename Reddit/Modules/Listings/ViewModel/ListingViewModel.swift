//
//  ListingViewModel.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/28/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class ListingViewModel: NSObject {
	var listingSections: [ListingSection] = []

	private var after: String?
	private var before: String?
	private var subreddit: String = ""
	private var isNextPageQueried: Bool = false

	var useCase: ListingUseCase

	init(useCase: ListingUseCase) {
		self.useCase = useCase
	}

	func numberOfSections() -> Int {
		return listingSections.count
	}

	func numberOfRowsInSection(section: Int) -> Int {
		return listingSections[section].rowCount
	}

	func getListing(subreddit: String, completion: @escaping () -> Void) {
		useCase.fetchHotListing(subreddit: subreddit, after: nil, before: nil) { (listing) in
			self.listingSections = self.createListingSections(withListing: listing)

			// Update current after and before values for loading next page
			self.after = listing.after
			self.before = listing.before
			self.subreddit = subreddit

			completion()
		}
	}

	func getListingNextPage(onLoadingBlock: (() -> Void)? = nil, completion: @escaping () -> Void) {
		onLoadingBlock?()

		isNextPageQueried = true

		useCase.fetchHotListing(subreddit: subreddit, after: after, before: before) { (listing) in
			let section = self.createListingSections(withListing: listing)
			self.listingSections.append(contentsOf: section)

			self.isNextPageQueried = false

			completion()
		}
	}

	func createListingSections(withListing listing: Listing) -> [ListingSection] {
		let links: [Link] = listing.children.flatMap({ (link) -> Link? in
			return link as? Link
		})

		var sections: [ListingSection] = []
		sections.append(LinkSection(links: links))

		return sections
	}

	func isNextPageLoadable(withIndexPath indexPath: IndexPath) -> Bool {
		if !listingSections.isEmpty &&
			indexPath.section == listingSections.count - 1 &&
			indexPath.row == listingSections[indexPath.section].rowCount - 1 &&
			!isNextPageQueried {
			return true
		} else {
			return false
		}
	}
}
