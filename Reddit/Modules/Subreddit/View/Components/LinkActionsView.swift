//
//  LinkActionsView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/11/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SnapKit

class LinkActionsView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview() {
        addSubview(actionsStackView)
        actionsStackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
