//
//  UrlLinkView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/22/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SnapKit

// MARK: - Url Link
/// A Link View that can display url alongside its thumbnail
class UrlLinkView: UIView, UrlLinkViewProtocol {
    
    // MARK: - Properties
    var imageSize: CGSize = CGSize(width: 80, height: 80)
    
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
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var mainContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.axis = .horizontal
        stackView.alignment = .top
        
        imageView.snp.makeConstraints({ (make) in
            make.size.equalTo(imageSize)
        })
        
        return stackView
    }()
    
    func setup() {
        addSubview(mainContainerView)
        addSubview(actionsView)
        
        mainContainerView.addArrangedSubview(infoView)
        mainContainerView.addArrangedSubview(contentView)

        mainContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }

        actionsView.snp.makeConstraints { (make) in
            make.top.equalTo(mainContainerView.snp.bottom)
            make.leading.equalTo(mainContainerView.snp.leading)
            make.trailing.equalTo(mainContainerView.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
}
