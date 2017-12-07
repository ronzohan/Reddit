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

protocol ILinkCell {
    var viewModel: LinkCellViewModel? { get set }

    func configure()
}

protocol IInteractionableCell {
    func onMetaTapped(_: (() -> Void)?)
    func onContentTapped(_: (() -> Void)?)
    func onUpVoteTapped(_: (() -> Void)?)
    func onDownVoteTapped(_: (() -> Void)?)
}

class LinkTableViewCell<T: UIView>: BaseLinkTableViewCell, Contentable, IInteractionableCell {

    typealias Content = T
    
    var linkContentView: UIView {
        return containerView
    }

    lazy var linkView: LinkView<Content> = {
        let view = LinkView<Content>()

        let metaLabelTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onMetaLabelTappedHandler)
        )
        view.metaLabel.addGestureRecognizer(metaLabelTapGesture)
        view.metaLabel.isUserInteractionEnabled = true

        return view
    }()

    lazy var upvoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upvote", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)

        return button
    }()

    lazy var downvoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Downvote", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)

        return button
    }()

    lazy var commentsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Comments", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)

        return button
    }()

    lazy private var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        stackView.addArrangedSubview(self.upvoteButton)
        stackView.addArrangedSubview(self.downvoteButton)
        stackView.addArrangedSubview(self.commentsButton)

        return stackView
    }()
    
    let containerView = UIView()
    
    // This is for touch so that it can animate a touch on whole cell
    lazy private var highlightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        return view
    }()

    // Meta
    private var onMetaTapped: (() -> Void)?
    func onMetaTapped(_ completion: (() -> Void)?) {
        onMetaTapped = completion
    }

    @objc func onMetaLabelTappedHandler(sender _: AnyObject?) {
        onMetaTapped?()
    }

    // Content
    private var onContentTapped: (() -> Void)?
    func onContentTapped(_ completion: (() -> Void)?) {
        onContentTapped = completion
    }

    @objc func onContentTappedHandler(sender _: AnyObject?) {
        onContentTapped?()
    }

    // Upvote
    private var onUpVoteTapped: (() -> Void)?
    func onUpVoteTapped(_ completion: (() -> Void)?) {
        onUpVoteTapped = completion
    }

    @objc func onUpVoteTappedHandler(sender _: AnyObject?) {
        onUpVoteTapped?()
    }

    // Downvote
    private var onDownVoteTapped: (() -> Void)?
    func onDownVoteTapped(_ completion: (() -> Void)?) {
        onDownVoteTapped = completion
    }

    @objc func onDownVoteTappedHandler(sender _: AnyObject?) {
        onDownVoteTapped?()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    override func configure() {
        super.configure()

        linkView.titleLabel.text = viewModel?.title
        linkView.titleLabel.font = UIFont(name: "Avenir-Book", size: 16)

        linkView.metaLabel.text = viewModel?.meta
        linkView.metaLabel.font = UIFont(name: "Avenir-Light", size: 14)
    }

    private func setupSubviews() {
        selectionStyle = .none

        let offset: CGFloat = 8
        contentView.backgroundColor = UIColor.lightGray

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(offset)
            make.leading.equalTo(contentView).offset(offset)
            make.right.equalTo(contentView).offset(-offset)
            make.bottom.equalTo(contentView)
        }

        containerView.layer.cornerRadius = 10
        containerView.layer.backgroundColor = UIColor.white.cgColor

        containerView.addSubview(linkView)
        linkView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(offset)
            make.leading.equalTo(contentView).offset(offset)
            make.trailing.equalTo(contentView).offset(-offset)
        }

        containerView.addSubview(actionsStackView)
        actionsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(linkView.snp.bottom).offset(offset)
            make.leading.equalTo(linkView.snp.leading)
            make.trailing.equalTo(linkView.snp.trailing)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
        contentView.addSubview(highlightView)
        highlightView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.leading.equalTo(containerView)
            make.right.equalTo(containerView)
            make.bottom.equalTo(containerView)
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