//
//  ImageLinkTableViewCell.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/24/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class ImageLinkTableViewCell: LinkTableViewCell<UIImageView> {
    override func prepareForReuse() {
        super.prepareForReuse()

        linkView.contentView.af_cancelImageRequest()
        linkView.contentView.image = nil
    }

    override func configure() {
        super.configure()

        if let urlString = viewModel?.imageUrl, let url = URL(string: urlString) {
            updateImage(withURLRequest: URLRequest(url: url))
        }
        
        updateCellHeight()
    }

    override func updateCellHeight() {
        if let height = viewModel?.cellHeight(for: Double(frame.width)) {
            updateCellHeight(height: round(height))
        }
    }
    
    func updateImage(withURLRequest request: URLRequest?) {
        guard let imageRequest = request else {
            linkView.contentView.image = nil
            return
        }

        linkView.contentView.af_setImage(withURLRequest: imageRequest)
    }

    func updateCellHeight(height: Double) {
        linkView.mainContentViewHeightConst?.constant = CGFloat(height)
    }
}
