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
	private var after: String?
	private var before: String?
	private var subreddit: String = ""

	var useCase: ListingUseCase

	init(useCase: ListingUseCase) {
		self.useCase = useCase
	}

	func getListing(subreddit: String) -> Observable<ListingSection> {
		return self.useCase.fetchHotListing(subreddit: subreddit, after: nil, before: nil)
			.do(onNext: { (listing) in
				// Update current after and before values for loading next page
				self.after = listing.after
				self.before = listing.before
				self.subreddit = subreddit
			})
			.map({ (listing) -> ListingSection in
				let section = self.sectionModels(forListing: listing)

				return section
			})
	}

	func getListingNextPage() -> Observable<ListingSection> {
		return self.useCase.fetchHotListing(subreddit: subreddit, after: after, before: before)
			.do(onNext: { (listing) in
				// Update current after and before values for loading next page
				self.after = listing.after
				self.before = listing.before
			})
			.map({ (listing) -> ListingSection in
				let section = self.sectionModels(forListing: listing)

				return section
			})
	}

	func sectionModels(forListing listing: Listing) -> ListingSection {
		let links = listing.children.flatMap { (thing) -> Link? in
						return thing as? Link
					}

		return ListingSection.linkRows(links: links)
	}
}
