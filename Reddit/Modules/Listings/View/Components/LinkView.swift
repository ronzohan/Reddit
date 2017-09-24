//
//  LinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit

class LinkView<T: UIView>: UIView {
	// MARK: - Init
	let contentStackViewTopOffset: CGFloat = 8
	let contentStackViewBottomOffset: CGFloat = 10
	let lineViewHeight: CGFloat = 2

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: - Properties
	var contentViewHeightConst: NSLayoutConstraint?

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

	lazy var contentView: T = {
		let contentView = T()

		return contentView
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

	lazy private var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.lightGray
		view.heightAnchor.constraint(equalToConstant: lineViewHeight).isActive = true

		return view
	}()

	func setup() {
		contentStackView.translatesAutoresizingMaskIntoConstraints = false

		contentStackView.addArrangedSubview(titleStackView)
		contentStackView.addArrangedSubview(contentView)

		addSubview(contentStackView)

		contentStackView.topAnchor.constraint(
			equalTo: topAnchor,
			constant: contentStackViewTopOffset
			).isActive = true

		contentStackView.bottomAnchor.constraint(
			equalTo: bottomAnchor,
			constant: -contentStackViewBottomOffset
			).isActive = true

		contentStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		contentStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

		contentViewHeightConst = contentView.heightAnchor.constraint(equalToConstant: 0)
		contentViewHeightConst?.priority = UILayoutPriority(rawValue: 999)
		contentViewHeightConst?.isActive = true

		addSubview(lineView)
		lineView.translatesAutoresizingMaskIntoConstraints = false
		lineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		lineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

	}
}
