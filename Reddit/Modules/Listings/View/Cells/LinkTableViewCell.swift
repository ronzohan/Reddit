//
//  LinkViewTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ILinkCell {
	var viewModel: LinkCellViewModel? { get set }

	func configure()
}

protocol IInteractionableCell {
	func onMetaTapped(_: (() -> Void)?)
	func onContentTapped(_: (() -> Void)?)
	func onUpVoteTapped(_: (() -> Void)?)
	func onDownVoteTapped(_: (() -> Void)?)
}

class LinkTableViewCell<T: UIView>: BaseLinkTableViewCell, IInteractionableCell {

	typealias Content = T

	lazy var linkView: LinkView<Content> = {
		let view = LinkView<Content>()

		let metaLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(onMetaLabelTappedHandler))
		view.metaLabel.addGestureRecognizer(metaLabelTapGesture)
		view.metaLabel.isUserInteractionEnabled = true

		return view
	}()

	// Meta
	private var onMetaTapped: (() -> Void)?
	func onMetaTapped(_ completion: (() -> Void)?) {
		onMetaTapped = completion
	}
	@objc func onMetaLabelTappedHandler(sender: AnyObject?) {
		onMetaTapped?()
	}

	// Content
	private var onContentTapped: (() -> Void)?
	func onContentTapped(_ completion: (() -> Void)?) {
		onContentTapped = completion
	}
	@objc func onContentTappedHandler(sender: AnyObject?) {
		onContentTapped?()
	}

	// Upvote
	private var onUpVoteTapped: (() -> Void)?
	func onUpVoteTapped(_ completion: (() -> Void)?) {
		onUpVoteTapped = completion
	}
	@objc func onUpVoteTappedHandler(sender: AnyObject?) {
		onUpVoteTapped?()
	}

	// Downvote
	private var onDownVoteTapped: (() -> Void)?
	func onDownVoteTapped(_ completion: (() -> Void)?) {
		onDownVoteTapped = completion
	}
	@objc func onDownVoteTappedHandler(sender: AnyObject?) {
		onDownVoteTapped?()
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupSubviews()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupSubviews()
	}

	override func configure() {
		super.configure()

		linkView.titleLabel.text = viewModel?.title
		linkView.titleLabel.font = UIFont(name: "Avenir-Book", size: 16)

		linkView.metaLabel.text = viewModel?.meta
		linkView.metaLabel.font = UIFont(name: "Avenir-Light", size: 14)
	}

	private func setupSubviews() {
		selectionStyle = .none

		contentView.addSubview(linkView)
		linkView.translatesAutoresizingMaskIntoConstraints = false
		linkView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		linkView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		linkView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		linkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

		linkView.contentView.contentMode = .scaleAspectFill
		linkView.contentView.layer.masksToBounds = true
	}
}
