//
//  LinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit

class LinkView: UIView {
	// MARK: - Init
	private struct LinkViewUX {
		static let ContentStackViewTopOffset: CGFloat = 8
		static let ContentStackViewBottomOffset: CGFloat = 10
		static let LineViewHeight: CGFloat = 2
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: - Properties
	var contentImageViewHeightConst: NSLayoutConstraint?

	// MARK: - Subviews
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0

		return label
	}()

	lazy var metaLabel: UILabel = {
		let label = UILabel()
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
		stackView.addArrangedSubview(self.metaLabel)
		stackView.addArrangedSubview(self.titleLabel)
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		stackView.axis = .vertical
		stackView.isLayoutMarginsRelativeArrangement = true

		return stackView
	}()

	private var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.lightGray
		view.heightAnchor.constraint(equalToConstant: LinkViewUX.LineViewHeight).isActive = true

		return view
	}()

	func setup() {
		contentStackView.translatesAutoresizingMaskIntoConstraints = false

		contentStackView.addArrangedSubview(titleStackView)
		contentStackView.addArrangedSubview(contentImageView)

		addSubview(contentStackView)

		contentStackView.topAnchor.constraint(
			equalTo: topAnchor,
			constant: LinkViewUX.ContentStackViewTopOffset
			).isActive = true

		contentStackView.bottomAnchor.constraint(
			equalTo: bottomAnchor,
			constant: -LinkViewUX.ContentStackViewBottomOffset
			).isActive = true

		contentStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		contentStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

		contentImageViewHeightConst = contentImageView.heightAnchor.constraint(equalToConstant: 0)
		contentImageViewHeightConst?.priority = UILayoutPriority(rawValue: 999)
		contentImageViewHeightConst?.isActive = true

		addSubview(lineView)
		lineView.translatesAutoresizingMaskIntoConstraints = false
		lineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		lineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

	}
}
