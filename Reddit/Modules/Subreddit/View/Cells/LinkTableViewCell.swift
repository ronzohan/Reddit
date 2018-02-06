//
//  LinkViewTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import AlamofireImage
import SnapKit

protocol Contentable {
    var linkContentView: UIView { get }
}

protocol ILinkViewable {
    associatedtype Content: UIView
    var linkView: LinkView<Content> { get } 
}

protocol ILinkCell {
    var viewModel: LinkCellViewModel? { get set }
    func configure()
}

class LinkTableViewCell: UITableViewCell, ILinkCell, Contentable, ILinkViewable {

    typealias Content = UIView
    
    var viewModel: LinkCellViewModel?
    
    var linkContentView: UIView {
        return containerView
    }

    lazy var linkView: LinkView<Content> = {
        let view = LinkView<Content>()

        return view
    }()
    
    let containerView = UIView()
    
    // This is for touch so that it can animate a touch on whole cell
    lazy private var highlightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    func configure() {
        linkView.titleLabel.text = viewModel?.title
        linkView.titleLabel.font = UIFont(name: "Avenir-Book", size: 16)

        linkView.metaLabel.text = viewModel?.meta
        linkView.metaLabel.font = UIFont(name: "Avenir-Light", size: 14)
    }

    private func setupSubviews() {
        selectionStyle = .none

        let offset: CGFloat = 8
        contentView.backgroundColor = Theme.gray

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(offset)
            make.leading.equalTo(containerView.snp.leading).offset(offset)
            make.trailing.equalTo(containerView.snp.trailing).offset(-offset)
            make.bottom.equalTo(containerView.snp.bottom).offset(-offset)
        }

        containerView.layer.cornerRadius = 10
        containerView.layer.backgroundColor = UIColor.white.cgColor

        containerView.addSubview(linkView)
        linkView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(offset)
            make.leading.equalTo(contentView.snp.leading).offset(offset)
            make.trailing.equalTo(contentView.snp.trailing).offset(-offset)
            make.bottom.equalTo(contentView.snp.bottom).offset(-offset)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            UIView.animate(withDuration: 0.3, animations: { 
                self.highlightView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            })
        } else {
            highlightView.backgroundColor = nil
        }
        
    }
}

class ASDss: LinkTableViewCell {
    typealias Content = UIImageView
}
