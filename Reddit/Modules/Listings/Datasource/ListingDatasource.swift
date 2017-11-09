//
//  ListingDatasource.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 10/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxDataSources

class ListingDatasource: NSObject {

	var dataSource: [ListingSection] = []

	private var onLoadNextPage: (() -> Void)?
	private var isNextPageQueried: Bool = false

	var estimatedHeightCache: [IndexPath: CGFloat] = [:]

	func onLoadNextPage(completion: (() -> Void)?) {
		onLoadNextPage = completion
	}

	func configureLinkTableViewCell(cell: BaseLinkTableViewCell, link: Link) {
		let viewModel = LinkCellViewModel(link: link)

		cell.viewModel = viewModel
		cell.configure()
	}

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

	func shouldLoadNextPage(withIndexPath indexPath: IndexPath) -> Bool {
		if case ListingSection.linkRows(let links) = dataSource[indexPath.section],
			indexPath.row == links.count - 1 &&
			!dataSource.isEmpty &&
			indexPath.section == dataSource.count - 1 &&
			!isNextPageQueried {
			return true
		} else {
			return false
		}
	}
}

// MARK: - Datasource
extension ListingDatasource: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch dataSource[section] {
			case let .linkRows(links):
				return links.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch dataSource[indexPath.section] {
			case let .linkRows(links: links):
				return linkCellForLink(link: links[indexPath.row], tableView: tableView, forRowAt: indexPath)
		}
	}

	func linkCellForLink(link: Link,
	                     tableView: UITableView,
	                     forRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: BaseLinkTableViewCell?

		switch link.postHint {
		case .link:
			cell = self.urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
		case .image:
			cell = self.imageLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
		default:
			cell = self.urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
		}

		guard let linkCell = cell else {
			return UITableViewCell()
		}

		self.configureLinkTableViewCell(cell: linkCell, link: link)

		return linkCell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if shouldLoadNextPage(withIndexPath: indexPath) {
			onLoadNextPage?()
		}

		estimatedHeightCache[indexPath] = cell.frame.height
	}

	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return estimatedHeightCache[indexPath] ?? 100
	}
}

extension ListingDatasource: UITableViewDelegate {}
