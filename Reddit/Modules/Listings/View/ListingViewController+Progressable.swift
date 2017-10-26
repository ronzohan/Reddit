//
//  ListingViewController+Progressable.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/28/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

extension ListingViewController: Progressable {
	func showLoadingView() {
		let alert: UIAlertController

		if let loadingAlert = loadingAlert {
			alert = loadingAlert
		} else {
			alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

			let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
			loadingIndicator.hidesWhenStopped = true
			loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
			loadingIndicator.startAnimating()

			alert.view.addSubview(loadingIndicator)

			loadingAlert = alert
		}

		present(alert, animated: true, completion: nil)
	}

	func dismissLoadingView() {
		self.listingTableView.tableFooterView = nil
		loadingAlert?.dismiss(animated: true, completion: nil)
	}
}
