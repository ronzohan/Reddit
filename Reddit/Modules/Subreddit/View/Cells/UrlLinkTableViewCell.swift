//
//  UrlLinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/25/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit

class UrlLinkTableViewCell: UITableViewCell, ILinkCell, Contentable, ILinkViewable {
    typealias Content = UIImageView
    
    var viewModel: LinkCellViewModel?
    
    var linkContentView: UIView {
        return containerView
    }
    
    lazy var linkView: LinkView<Content> = {
        let view = LinkView<Content>()
        
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

        linkView.contentView.af_cancelImageRequest()
        linkView.contentView.image = nil

        linkView.mainContentViewHeightConst?.constant = CGFloat(0)
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

    func configure() {
        linkView.mode = .horizontal

        linkView.mainContentViewHeightConst?.constant = CGFloat(100)

        if let urlString = viewModel?.imageUrl, let url = URL(string: urlString) {
            updateImage(withURLRequest: URLRequest(url: url))
        }
        
        linkView.titleLabel.text = viewModel?.title
        linkView.titleLabel.font = UIFont(name: "Avenir-Book", size: 16)
        
        linkView.metaLabel.text = viewModel?.meta
        linkView.metaLabel.font = UIFont(name: "Avenir-Light", size: 14)
    }

    func updateImage(withURLRequest request: URLRequest) {
        linkView.contentView.af_setImage(withURLRequest: request)
    }
}
