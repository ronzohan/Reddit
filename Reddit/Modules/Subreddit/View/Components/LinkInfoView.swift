//
//  LinkInfoView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/11/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SnapKit

class LinkInfoView: UIView {
    lazy var metaLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame) 
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(metaLabel)
        metaLabel.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
