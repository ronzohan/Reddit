//
//  ImageLinkViewProtocol.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/27/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

protocol ImageLinkViewable: LinkViewable, ViewContentHeightAdjustable {
    var width: Double { get }
    
    func setImage(withUrl url: String)
}

protocol ImageLinkViewProtocol: LinkView, ImageLinkViewable {
    var imageView: UIImageView { get }
}

extension ImageLinkViewProtocol {
    func setImage(withUrl url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        imageView.af_setImage(withURL: imageUrl)
    }
}
