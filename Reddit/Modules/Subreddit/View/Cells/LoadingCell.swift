//
//  LoadingCell.swift
//  Reddit
//
//  Created by Ron on 24/12/2017.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class LoadingCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: LoadingCell.self)
    }
    fileprivate var loadingIndicatorWidth: CGFloat = 50
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(loadingIndicatorWidth)
        }
    }
}
