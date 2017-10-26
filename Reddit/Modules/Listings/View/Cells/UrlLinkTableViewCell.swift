//
//  UrlLinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/25/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit

class UrlLinkTableViewCell: LinkTableViewCell<UIImageView> {
	static var identifier: String {
		return String(describing: self)
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		linkView.contentView.af_cancelImageRequest()
		linkView.contentView.image = nil

		linkView.mainContentViewHeightConst?.constant = CGFloat(0)
	}

	override func configure() {
		super.configure()

		linkView.mode = .horizontal

		linkView.mainContentViewHeightConst?.constant = CGFloat(100)

		if let urlString = viewModel?.imageUrl, let url = URL(string: urlString) {
			updateImage(withURLRequest: URLRequest(url: url))
		}
	}

	func updateImage(withURLRequest request: URLRequest) {
		linkView.contentView.af_setImage(withURLRequest: request)
	}
}
