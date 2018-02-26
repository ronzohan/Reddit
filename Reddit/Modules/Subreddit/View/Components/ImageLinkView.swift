//
//  ImageLinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/22/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import AlamofireImage

// MARK: - Image Link
/// A Link View that can display images
class ImageLinkView: UIView, ImageContentLinkView {
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

    var width: Double {
        return Double(frame.size.width)
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
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
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
        addSubview(imageView)
        addSubview(actionsView)
        
        mainContentView.addArrangedSubview(infoView)
        mainContentView.addArrangedSubview(titleLabel)
        
        mainContentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(mainContentView.snp.bottom)
            make.left.equalTo(mainContentView.snp.left)
            make.right.equalTo(mainContentView.snp.right)
            make.bottom.equalTo(actionsView.snp.top)
        }
        
        mainContentViewHeightConst = imageView.heightAnchor.constraint(equalToConstant: 100)
        mainContentViewHeightConst?.priority = UILayoutPriority(rawValue: 999)
        mainContentViewHeightConst?.isActive = true
        
        actionsView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
    
    func setContentHeight(height: Double) {
        mainContentViewHeightConst?.constant = CGFloat(height)
    }
}
