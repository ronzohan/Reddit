//
//  LinkViewTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import AlamofireImage

class LinkViewTableViewCell: UITableViewCell {
	// MARK: - UX
	private struct LinkCellUX {
		static let ContentStackViewTopOffset: CGFloat = 8
		static let ContentStackViewBottomOffset: CGFloat = 10
		static let LineViewHeight: CGFloat = 2
	}

	static var identifier = String(describing: LinkViewTableViewCell.self)

	// MARK: - View Model
	var viewModel: LinkCellViewModel?

	// MARK: - Subviews
	lazy private(set) var linkView: LinkView = {
		let view = LinkView()

		return view
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupSubviews()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupSubviews()
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		linkView.contentImageView.af_cancelImageRequest()
		linkView.contentImageView.image = nil

		linkView.contentImageViewHeightConst?.constant = CGFloat(0)
	}

	private func setupSubviews() {
		selectionStyle = .none

		contentView.addSubview(linkView)
		linkView.translatesAutoresizingMaskIntoConstraints = false
		linkView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		linkView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		linkView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		linkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}

	func configure() {
		linkView.titleLabel.text = viewModel?.title
		linkView.titleLabel.font = UIFont(name: "Avenir-Book", size: 16)

		linkView.metaLabel.text = viewModel?.meta
		linkView.metaLabel.font = UIFont(name: "Avenir-Light", size: 14)

		if let urlString = viewModel?.imageUrl, let url = URL(string: urlString) {
			updateImage(withURLRequest: URLRequest(url: url))
		}

		if let height = viewModel?.getCellHeight(withWidth: Double(frame.width)) {
			updateCellHeight(height: height)
		}
	}

	func updateImage(withURLRequest request: URLRequest?) {
		guard let imageRequest = request else {
			linkView.contentImageView.image = nil
			return
		}

		linkView.contentImageView.af_setImage(withURLRequest: imageRequest)
	}

	func updateCellHeight(height: Double) {
		linkView.contentImageViewHeightConst?.constant = CGFloat(height)
	}
}
