//
//  ListingViewController+UITableViewDatasource.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/16/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

enum LinkCellType {
	case image
	case gif
	case video
}

extension ListingViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.numberOfSections()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRowsInSection(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		loadNextPage(withCurrentIndexpath: indexPath)

		var tableCell: BaseLinkTableViewCell?
		var linkViewModel: LinkCellViewModel?

		if let linkSection = viewModel.listingSections.value[indexPath.section] as? LinkSection {
			let link = linkSection.links[indexPath.row]
			linkViewModel = LinkCellViewModel(link: link)
		}

		// Check what section type will be rendered
		switch viewModel.listingSections.value[indexPath.section].type {
			case .link:
				if let _linkViewModel = linkViewModel {
					// Get approriate cell for link
					tableCell = linkCellForLink(
						tableView: tableView,
						indexPath: indexPath,
						postHint: _linkViewModel.postHint)
				}
		}

		tableCell?.viewModel = linkViewModel
		tableCell?.configure()

		return tableCell ?? BaseLinkTableViewCell()
	}

	/**
	 Generate the approriate cell based on the Link's Post hint
	*/
	func linkCellForLink(tableView: UITableView,
	                     indexPath: IndexPath,
	                     postHint: PostHint) -> BaseLinkTableViewCell? {
		var linkCell: BaseLinkTableViewCell?

		// TODO: Implement gif and video cell type
		switch postHint {
			case .link, .redditSelf:
				if let cell = tableView.dequeueReusableCell(
					withIdentifier: String(describing: UrlLinkTableViewCell.identifier),
					for: indexPath) as? UrlLinkTableViewCell {
					linkCell = cell
				}
			default:
				if let cell = tableView.dequeueReusableCell(
					withIdentifier: String(describing: ImageLinkTableViewCell.identifier),
					for: indexPath) as? ImageLinkTableViewCell {
					linkCell = cell
				}
			}

		return linkCell
	}

	/**
	 Load the next page of the subreddit if the current index path that it
	 is loading surpass the threshold
	*/
	func loadNextPage(withCurrentIndexpath indexPath: IndexPath) {
		if viewModel.shouldLoadNextPage(withIndexPath: indexPath) {

			showLoadingNextPage()

			viewModel.getListingNextPage()
				.drive(onCompleted: {
					self.dismissLoadingView()

					self.listingTableView.reloadData()
				})
				.addDisposableTo(disposeBag)
		}
	}

	func showLoadingNextPage() {
		self.listingTableView.tableFooterView = loadingIndicator

		loadingIndicator.startAnimating()
	}
}
