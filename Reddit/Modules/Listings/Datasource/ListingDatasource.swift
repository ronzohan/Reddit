//
//  ListingDatasource.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 10/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxDataSources

class ListingDatasource {

	private var onLoadNextPage: (() -> Void)?
	func onLoadNextPage(completion: @escaping () -> Void) {
		onLoadNextPage = completion
	}

	func configureLinkTableViewCell(cell: BaseLinkTableViewCell, link: Link) {
		let viewModel = LinkCellViewModel(link: link)

		cell.viewModel = viewModel
		cell.configure()
	}

	func datasource() -> RxTableViewSectionedReloadDataSource<LinkSectionModel> {
		return RxTableViewSectionedReloadDataSource<LinkSectionModel>
			.init(configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in

				let cell: BaseLinkTableViewCell?
				let link: Link

				switch dataSource[indexPath] {
					case .urlLink(let _link):
						cell = self.urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
						link = _link
					case .imageLink(let _link):
						cell = self.imageLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
						link = _link
				}

				guard let unwrappedCell = cell else {
					return UITableViewCell()
				}

				self.configureLinkTableViewCell(cell: unwrappedCell, link: link)

				return unwrappedCell
		})
	}
//
//	/**
//	Load the next page of the subreddit if the current index path that it
//	is loading surpass the threshold
//	*/
//	func loadNextPage(withCurrentIndexpath indexPath: IndexPath) {
//		if viewModel.shouldLoadNextPage(withIndexPath: indexPath) {
//
//			showLoadingNextPage()
//
//			viewModel.getListingNextPage()
//				.drive(onCompleted: {
//					self.dismissLoadingView()
//
//					self.listingTableView.reloadData()
//				})
//				.addDisposableTo(disposeBag)
//		}
//	}
//
//	func showLoadingNextPage() {
//		self.listingTableView.tableFooterView = loadingIndicator
//
//		loadingIndicator.startAnimating()
//	}

	func urlLinkTableViewCellFor(tableView: UITableView,
	                                   indexPath: IndexPath) -> UrlLinkTableViewCell? {
		let cell: UrlLinkTableViewCell? = tableView.dequeueReusableCell(forIndexPath: indexPath)
		
		return cell
	}
	
	func imageLinkTableViewCellFor(tableView: UITableView,
	                                     indexPath: IndexPath) -> ImageLinkTableViewCell? {
		let cell: ImageLinkTableViewCell? = tableView.dequeueReusableCell(forIndexPath: indexPath)
		
		return cell
	}
}
