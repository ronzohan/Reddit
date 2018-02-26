////
////  LinkView.swift
////  Reddit
////
////  Created by Ron Daryl Magno on 9/21/17.
////  Copyright © 2017 Ron Daryl Magno. All rights reserved.
////
//
import UIKit
import AlamofireImage

protocol ImageContentLinkViewable: LinkViewable {
    var width: Double { get }
    
    func setImage(withUrl url: String)
    func setContentHeight(height: Double)
}

protocol ImageContentLinkView: LinkView, ImageContentLinkViewable {
    var imageView: UIImageView { get }
}

extension ImageContentLinkView {
    func setImage(withUrl url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        imageView.af_setImage(withURL: imageUrl)
    }
}
