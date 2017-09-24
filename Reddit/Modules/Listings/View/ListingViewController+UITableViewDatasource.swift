//
//  ListingViewController+UITableViewDatasource.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/16/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

extension ListingViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.numberOfSections()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRowsInSection(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		loadNextPage(withCurrentIndexpath: indexPath)

		switch viewModel.listingSections.value[indexPath.section].type {
			case .link:
				if let linkSection = viewModel.listingSections.value[indexPath.section] as? LinkSection,
					let cell = tableView.dequeueReusableCell(
						withIdentifier: String(describing: LinkTableViewCell.identifier),
						for: indexPath) as? LinkTableViewCell {

					let link = linkSection.links[indexPath.row]
					let linkCellViewModel = LinkCellViewModel(link: link)
					cell.viewModel = linkCellViewModel
					cell.configure()

					return cell
				}
		}

		return UITableViewCell()
	}

	func loadNextPage(withCurrentIndexpath indexPath: IndexPath) {
		if viewModel.isNextPageLoadable(withIndexPath: indexPath) {
			viewModel.getListingNextPage()
				.drive(onNext: { (_) in
					let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
					loadingIndicator.hidesWhenStopped = true
					loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
					loadingIndicator.startAnimating()

					self.listingTableView.tableFooterView = loadingIndicator
				}, onCompleted: {
					self.dismissLoadingView()

					self.listingTableView.reloadData()
				})
				.addDisposableTo(disposeBag)
		}
	}
}
