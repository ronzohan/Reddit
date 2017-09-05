//
//  LinkCellTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import AlamofireImage

class LinkCellTableViewCell: UITableViewCell {
	// MARK: - UX
	private struct LinkCellUX {
		static let ContentStackViewTopOffset: CGFloat = 8
		static let ContentStackViewBottomOffset: CGFloat = 8
		static let LineViewHeight: CGFloat = 2
	}

	static var identifier = String(describing: LinkCellTableViewCell.self)

	// MARK: - View Model
	var viewModel: LinkCellViewModel?

	// MARK: - Properties
	var contentImageViewHeightConst: NSLayoutConstraint?

	// MARK: - Subviews
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0

		return label
	}()

	lazy var contentImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true

		return imageView
	}()

	lazy private var contentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 8

		return stackView
	}()

	lazy private var titleStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.addArrangedSubview(self.titleLabel)
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		stackView.isLayoutMarginsRelativeArrangement = true

		return stackView
	}()

	private var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.lightGray
		view.heightAnchor.constraint(equalToConstant: LinkCellUX.LineViewHeight).isActive = true

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

		contentImageView.af_cancelImageRequest()
		contentImageView.image = nil

		contentImageViewHeightConst?.constant = CGFloat(0)
	}

	private func setupSubviews() {
		contentStackView.translatesAutoresizingMaskIntoConstraints = false

		contentStackView.addArrangedSubview(titleStackView)
		contentStackView.addArrangedSubview(contentImageView)

		contentView.addSubview(contentStackView)

		contentStackView.topAnchor.constraint(
			equalTo: contentView.topAnchor,
			constant: LinkCellUX.ContentStackViewTopOffset
		).isActive = true

		contentStackView.bottomAnchor.constraint(
			equalTo: contentView.bottomAnchor,
			constant: -LinkCellUX.ContentStackViewBottomOffset
		).isActive = true

		contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

		contentImageViewHeightConst = contentImageView.heightAnchor.constraint(equalToConstant: 0)
		contentImageViewHeightConst?.priority = 999
		contentImageViewHeightConst?.isActive = true

		contentView.addSubview(lineView)
		lineView.translatesAutoresizingMaskIntoConstraints = false
		lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

		selectionStyle = .none
	}

	func configure() {
		titleLabel.text = viewModel?.title

		if let urlString = viewModel?.imageUrl, let url = URL(string: urlString) {
			updateImage(withURLRequest: URLRequest(url: url))
		}

		if let height = viewModel?.getCellHeight(withWidth: Double(frame.width)) {
			updateCellHeight(height: height)
		}
	}

	func updateImage(withURLRequest request: URLRequest?) {
		guard let imageRequest = request else {
			contentImageView.image = nil
			return
		}

		contentImageView.af_setImage(withURLRequest: imageRequest)
	}

	func updateCellHeight(height: Double) {
		contentImageViewHeightConst?.constant = CGFloat(height)
	}
}
