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

    lazy var listingTableView: UITableView = {
        let tableView = UITableView()
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100
		tableView.register(LinkCellTableViewCell.self, forCellReuseIdentifier: LinkCellTableViewCell.identifier)
		tableView.dataSource = self
		tableView.separatorStyle = .none

        return tableView
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

		viewModel
			.getListing(subreddit: "all")
			.drive(onCompleted: { _ in
				self.dismissLoadingView()
				self.listingTableView.reloadData()

			})
			.disposed(by: disposeBag)
    }
}
