//
//  ImageLinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/24/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class ImageLinkTableViewCell: LinkTableViewCell, ILinkCell {
	lazy private(set) var linkView: LinkView<UIImageView> = {
		let view = LinkView<UIImageView>()
		view.contentView.contentMode = .scaleAspectFill
		view.contentView.layer.masksToBounds = true
		
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
		
		linkView.contentView.af_cancelImageRequest()
		linkView.contentView.image = nil
		
		linkView.contentViewHeightConst?.constant = CGFloat(0)
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

	private func setupSubviews() {
		selectionStyle = .none
		
		contentView.addSubview(linkView)
		linkView.translatesAutoresizingMaskIntoConstraints = false
		linkView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		linkView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		linkView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		linkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
	
	func updateImage(withURLRequest request: URLRequest?) {
		guard let imageRequest = request else {
			linkView.contentView.image = nil
			return
		}
		
		linkView.contentView.af_setImage(withURLRequest: imageRequest)
	}
}
