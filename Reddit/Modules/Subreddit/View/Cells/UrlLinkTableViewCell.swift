//
//  UrlLinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/25/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit

class UrlLinkTableViewCell: UITableViewCell, Contentable {
    var linkContentView: UIView {
        return containerView
    }
    
    lazy var linkView: UrlLinkView = {
        let view = UrlLinkView()
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()

//        linkView.contentView.af_cancelImageRequest()
//        linkView.contentView.image = nil
//
//        linkView.mainContentViewHeightConst?.constant = CGFloat(0)
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
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        containerView.layer.cornerRadius = 10
        containerView.layer.backgroundColor = UIColor.white.cgColor

        containerView.addSubview(linkView)
        linkView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(offset)
            make.leading.equalTo(containerView.snp.leading).offset(offset)
            make.trailing.equalTo(containerView.snp.trailing).offset(-offset)
            make.bottom.equalTo(containerView.snp.bottom).offset(-offset )
        }
    }

    func updateImage(withURLRequest request: URLRequest) {
        //linkView.contentView.af_setImage(withURLRequest: request)
    }
}
