//
//  VoteButton.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 1/24/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SnapKit

class VoteView: UIView {
    lazy var upvoteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ThumbsUp"), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .right
        
        return button
    }()
    
    lazy var downvoteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ThumbsDown"), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.adjustsFontSizeToFitWidth = true
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(voteCountLabel)
        addSubview(upvoteButton)
        addSubview(downvoteButton)
        
        voteCountLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        upvoteButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(voteCountLabel.snp.leading).inset(-8)
        }
        
        downvoteButton.snp.makeConstraints { (make) in
            make.leading.equalTo(voteCountLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
}
