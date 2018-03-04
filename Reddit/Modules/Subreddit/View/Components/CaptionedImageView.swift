//
//  CaptionedUIImageView.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 3/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SnapKit

class CaptionedImageView: UIImageView {
    // MARK: - Properties
    /// Sets the caption for the image view
    var caption: String = "" {
        didSet {
            captionLabel.text = caption
        }
    }
    
    // MARK: - Subviews
    private(set) var captionLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(captionLabel)
        captionLabel.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
    }
}
