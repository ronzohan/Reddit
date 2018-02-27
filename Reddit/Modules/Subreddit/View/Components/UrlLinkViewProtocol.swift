//
//  UrlLinkViewProtocol.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/27/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

protocol UrlLinkViewable: LinkViewable {
    func setImage(withUrl url: String)
}

protocol UrlLinkViewProtocol: LinkView, UrlLinkViewable {
    var imageView: UIImageView { get }
}

extension UrlLinkViewProtocol {
    func setImage(withUrl url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        imageView.af_setImage(withURL: imageUrl)
    }
}
