//
//  LinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/26/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

class TitleLinkTableViewCell: UITableViewCell, Contentable {
    var linkContentView: UIView {
        return containerView
    }
    
    lazy var linkView: TitleLinkView = {
        let view = TitleLinkView()
        
        return view
    }()
    
    let containerView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    private func setupSubviews() {
        selectionStyle = .none
        
        let offset: CGFloat = 8
        contentView.backgroundColor = Theme.gray
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(offset)
            make.leading.equalTo(contentView.snp.leading).offset(offset)
            make.trailing.equalTo(contentView.snp.trailing).offset(-offset)
            make.bottom.equalTo(contentView.snp.bottom).offset(-offset)
        }
        
        containerView.layer.cornerRadius = 10
        containerView.layer.backgroundColor = UIColor.white.cgColor
        
        containerView.addSubview(linkView)
        linkView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(offset)
            make.leading.equalTo(containerView.snp.leading).offset(offset)
            make.trailing.equalTo(containerView.snp.trailing).offset(-offset)
            make.bottom.equalTo(containerView.snp.bottom).offset(-offset)
        }
    }
}
