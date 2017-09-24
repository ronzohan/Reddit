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
	
	
	var linkView: LinkView { get }
	var viewModel: LinkCellViewModel? { get }

	func onMetaTapped(_: (() -> Void)?)
	func onContentTapped(_: (() -> Void)?)
	func onUpVoteTapped(_: (() -> Void?)
	func onDownVoteTapped(_: (() -> Void?)
	
	func updateCellHeight(height: Double)
}

extension ILinkCell {
	func updateCellHeight(height: Double) {
		linkView.contentViewHeightConst?.constant = CGFloat(height)
	}
}

class LinkTableViewCell: UITableViewCell {
	// MARK: - UX
	private struct LinkCellUX {
		static let ContentStackViewTopOffset: CGFloat = 8
		static let ContentStackViewBottomOffset: CGFloat = 10
		static let LineViewHeight: CGFloat = 2
	}

	static var identifier = String(describing: LinkTableViewCell.self)
}
