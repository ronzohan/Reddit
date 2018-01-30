//
//  LinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import SnapKit

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
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private lazy var metaContainerView: UIView = {
        let view = UIView()

        view.addSubview(metaLabel)
        metaLabel.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(mediumSpacing)
            make.left.equalTo(view.snp.left).offset(mediumSpacing)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }

        return view
    }()

    lazy var metaLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    lazy var contentView: T = {
        let contentView = T()

        return contentView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(self.titleLabel)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: mediumSpacing, bottom: 0, right: 8)
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = mediumSpacing
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var mainContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()
    
    // MARK: Action Views
    lazy var commentsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("Comments".localizedCapitalized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("Share".localizedCapitalized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var voteView: VoteView = {
        return VoteView()
    }()
    
    lazy private var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(voteView)
        stackView.addArrangedSubview(commentsButton)
        stackView.addArrangedSubview(shareButton)
        
        return stackView
    }()

    func setup() {
        addSubview(mainContentView)
        addSubview(contentView)
        addSubview(actionsStackView)
        
        mainContentView.addArrangedSubview(metaContainerView)
        mainContentView.addArrangedSubview(titleStackView)
        
        mainContentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(mainContentView.snp.bottom)
            make.left.equalTo(mainContentView.snp.left)
            make.right.equalTo(mainContentView.snp.right)
            make.bottom.equalTo(actionsStackView.snp.top)
        }

        mainContentViewHeightConst = contentView.heightAnchor.constraint(equalToConstant: 100)
        mainContentViewHeightConst?.priority = UILayoutPriority(rawValue: 999)
        mainContentViewHeightConst?.isActive = true
        updateLayoutMode(mode: mode)

        actionsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(snp.bottom)
        }
    }

    func updateLayoutMode(mode: LayoutMode) {
        switch mode {
        case .horizontal:
            break
//            mainContentView.removeArrangedSubview(contentView)
//            contentView.removeFromSuperview()
//            titleStackView.insertArrangedSubview(contentView, at: 0)
//            contentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        case .vertical:
            break
//            titleStackView.removeArrangedSubview(contentView)
//            contentView.removeFromSuperview()
//            mainContentView.addArrangedSubview(contentView)
        }
    }
}
