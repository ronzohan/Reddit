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
	class func configureLinkTableViewCell(cell: BaseLinkTableViewCell, link: Link) {
		let viewModel = LinkCellViewModel(link: link)

		cell.viewModel = viewModel
		cell.configure()
	}

	static func datasource() -> RxTableViewSectionedReloadDataSource<LinkSectionModel> {
		return RxTableViewSectionedReloadDataSource<LinkSectionModel>
			.init(configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in

				let cell: BaseLinkTableViewCell?
				let link: Link

				switch dataSource[indexPath] {
					case .urlLink(let _link):
						cell = urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
						link = _link
					case .imageLink(let _link):
						cell = imageLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
						link = _link
				}

				guard let unwrappedCell = cell else {
					return UITableViewCell()
				}

				configureLinkTableViewCell(cell: unwrappedCell, link: link)

				return unwrappedCell
		})
	}

	class func urlLinkTableViewCellFor(tableView: UITableView,
	                                   indexPath: IndexPath) -> UrlLinkTableViewCell? {
		let cell: UrlLinkTableViewCell? = tableView.dequeueReusableCell(forIndexPath: indexPath)

		return cell
	}

	class func imageLinkTableViewCellFor(tableView: UITableView,
	                                     indexPath: IndexPath) -> ImageLinkTableViewCell? {
		let cell: ImageLinkTableViewCell? = tableView.dequeueReusableCell(forIndexPath: indexPath)

		return cell
	}
}
