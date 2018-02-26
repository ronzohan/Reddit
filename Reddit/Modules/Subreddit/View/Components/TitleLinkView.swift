//
//  TitleLinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/26/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

/// A link view with just title on it with no other content
class TitleLinkView: UIView, LinkView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
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
    
    lazy var actionsView: LinkActionsView = {
        let actionsView = LinkActionsView()
        
        return actionsView
    }()
    
    private lazy var mainContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    func setup() {
        addSubview(mainContentView)
        addSubview(actionsView)
        
        mainContentView.addArrangedSubview(infoView)
        mainContentView.addArrangedSubview(titleLabel)
        
        mainContentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }

        actionsView.snp.makeConstraints { (make) in
            make.top.equalTo(infoView.snp.bottom)
            make.leading.equalTo(infoView.snp.leading)
            make.trailing.equalTo(infoView.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
}
