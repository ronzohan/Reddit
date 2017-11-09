//
//  LinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit

enum LayoutMode {
	case horizontal
	case vertical
}

class LinkView<T: UIView>: UIView {
	let contentStackViewTopOffset: CGFloat = 8
	let contentStackViewBottomOffset: CGFloat = 10
	let lineViewHeight: CGFloat = 2
	let mediumSpacing: CGFloat = 12

	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: - Properties
	var mainContentViewHeightConst: NSLayoutConstraint?
	var mode: LayoutMode = .vertical {
		didSet {
			updateLayoutMode(mode: mode)
		}
	}

	// MARK: - Subviews
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0

		return label
	}()

	lazy private var metaContainerView: UIView = {
		let view = UIView()

		view.addSubview(metaLabel)
		metaLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		metaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: mediumSpacing).isActive = true
		metaLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: mediumSpacing).isActive = true
		metaLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

		return view
	}()

	lazy var metaLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false

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
		stackView.addArrangedSubview(self.titleLabel)
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: mediumSpacing, bottom: 0, right: 8)
		stackView.axis = .horizontal
		stackView.alignment = .top
		stackView.spacing = mediumSpacing
		stackView.isLayoutMarginsRelativeArrangement = true

		return stackView
	}()

	lazy private var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.lightGray
		view.heightAnchor.constraint(equalToConstant: lineViewHeight).isActive = true

		return view
	}()

	lazy private var mainContentView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical

		return stackView
	}()

	func setup() {
		mainContentView.translatesAutoresizingMaskIntoConstraints = false

		mainContentView.addArrangedSubview(metaContainerView)
		mainContentView.addArrangedSubview(titleStackView)
		addSubview(mainContentView)

		mainContentView.topAnchor.constraint(
			equalTo: topAnchor,
			constant: contentStackViewTopOffset
			).isActive = true

		mainContentView.bottomAnchor.constraint(
			equalTo: bottomAnchor,
			constant: 0
			).isActive = true

		mainContentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		mainContentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

		mainContentViewHeightConst = contentView.heightAnchor.constraint(equalToConstant: 0)
		mainContentViewHeightConst?.priority = UILayoutPriority(rawValue: 999)
		mainContentViewHeightConst?.isActive = true

		updateLayoutMode(mode: mode)

	}

	func updateLayoutMode(mode: LayoutMode) {
		switch mode {
		case .horizontal:
			mainContentView.removeArrangedSubview(contentView)
			contentView.removeFromSuperview()
			titleStackView.insertArrangedSubview(contentView, at: 0)
			contentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		case .vertical:
			titleStackView.removeArrangedSubview(contentView)
			contentView.removeFromSuperview()
			mainContentView.addArrangedSubview(contentView)
		}
	}
}
