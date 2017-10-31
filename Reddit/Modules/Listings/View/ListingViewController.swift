//
//  ListingViewController.swift
//  Listing
//
//  Created by Ron Daryl Magno on 8/11/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ListingViewController: UIViewController {

	// MARK: - Init
	init(viewModel: ListingViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	// MARK: - Properties
	var viewModel: ListingViewModel!

	var loadingAlert: UIAlertController?

	let disposeBag = DisposeBag()

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: - Subviews
    lazy var listingTableView: UITableView = {
        let tableView = UITableView()
		tableView.register(ImageLinkTableViewCell.self,
		                   forCellReuseIdentifier: ImageLinkTableViewCell.reuseIdentifier)
		tableView.register(UrlLinkTableViewCell.self,
		                   forCellReuseIdentifier: UrlLinkTableViewCell.reuseIdentifier)
		tableView.separatorStyle = .none

        return tableView
    }()

	lazy var loadingIndicator: UIActivityIndicatorView = {
		let loader = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
		loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray

		return loader
	}()

	// MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor.white

        view.addSubview(listingTableView)
        listingTableView.translatesAutoresizingMaskIntoConstraints = false
        listingTableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        listingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listingTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listingTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

		let datasources = ListingDatasource.datasource()

		viewModel
			.getListing(subreddit: "all")
			.bind(to: listingTableView.rx.items(dataSource: datasources))
			.disposed(by: disposeBag)
    }
}
