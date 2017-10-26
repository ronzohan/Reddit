//
//  ListingViewModel.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/28/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListingViewModel: NSObject {
	var listingSections = Variable<[ListingSection]>([])

	private var after: String?
	private var before: String?
	private var subreddit: String = ""
	private var isNextPageQueried: Bool = false

	var useCase: ListingUseCase

	init(useCase: ListingUseCase) {
		self.useCase = useCase
	}

	func numberOfSections() -> Int {
		return listingSections.value.count
	}

	func numberOfRowsInSection(section: Int) -> Int {
		return listingSections.value[section].rowCount
	}

	func getListing(subreddit: String) -> Driver<Listing> {
		return self.useCase.fetchHotListing(subreddit: subreddit, after: nil, before: nil)
			.do(onNext: { (listing) in
				self.listingSections.value = self.createListingSections(withListing: listing)

				// Update current after and before values for loading next page
				self.after = listing.after
				self.before = listing.before
				self.subreddit = subreddit
			})
			.asDriver(onErrorJustReturn: Listing())

	}

	func getListingNextPage() -> Driver<Listing> {

		isNextPageQueried = true

		return useCase.fetchHotListing(subreddit: subreddit, after: after, before: before)
			.do(onNext: { (listing) in
				let section = self.createListingSections(withListing: listing)
				self.listingSections.value.append(contentsOf: section)

				// Update current after and before values for loading next page
				self.after = listing.after
				self.before = listing.before

				self.isNextPageQueried = false
			})
			.asDriver(onErrorJustReturn: Listing())
	}

	func createListingSections(withListing listing: Listing) -> [ListingSection] {
		let links: [Link] = listing.children.flatMap({ (link) -> Link? in
			return link as? Link
		})

		var sections: [ListingSection] = []
		sections.append(LinkSection(links: links))

		return sections
	}

	func shouldLoadNextPage(withIndexPath indexPath: IndexPath) -> Bool {
		if !listingSections.value.isEmpty &&
			indexPath.section == listingSections.value.count - 1 &&
			indexPath.row == listingSections.value[indexPath.section].rowCount - 1 &&
			!isNextPageQueried {
			return true
		} else {
			return false
		}
	}
}
