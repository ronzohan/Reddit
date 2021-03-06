//
//  ImageLinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/24/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class ImageLinkTableViewCell: UITableViewCell, Contentable {    
    var linkContentView: UIView {
        return containerView
    }
    
    lazy var linkView: ImageLinkView = {
        let view = ImageLinkView()

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
        linkView.imageView.af_cancelImageRequest()
        linkView.imageView.image = nil
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
