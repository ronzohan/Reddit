//
//  LinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import SnapKit

protocol LinkViewProtocol {
    var actionsView: LinkActionsView { get }
    var titleLabel: UILabel { get }
    var infoView: LinkInfoView { get }
}

protocol LinkContentViewProtocol: LinkViewProtocol {
    associatedtype ContentType: UIView
    var contentView: ContentType { get } 
}

class ContentLinkView<T: UIView>: UIView {
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

    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    lazy var infoView: LinkInfoView = {
        let infoView = LinkInfoView()

        return infoView
    }()

    lazy var contentView: T = {
        let contentView = T()

        return contentView
    }()
    
    lazy var actionsView: LinkActionsView = {
        let actionsView = LinkActionsView()
        
        return actionsView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    private lazy var mainContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()

    func setup() {
        addSubview(mainContentView)
        addSubview(contentView)
        addSubview(actionsView)
        
        mainContentView.addArrangedSubview(infoView)
        mainContentView.addArrangedSubview(titleLabel)
        
        mainContentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(mainContentView.snp.bottom)
            make.left.equalTo(mainContentView.snp.left)
            make.right.equalTo(mainContentView.snp.right)
            make.bottom.equalTo(actionsView.snp.top)
        }

        mainContentViewHeightConst = contentView.heightAnchor.constraint(equalToConstant: 100)
        mainContentViewHeightConst?.priority = UILayoutPriority(rawValue: 999)
        mainContentViewHeightConst?.isActive = true

        actionsView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
}
