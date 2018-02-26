////
////  LinkView.swift
////  Reddit
////
////  Created by Ron Daryl Magno on 2/11/18.
////  Copyright © 2018 Ron Daryl Magno. All rights reserved.
////
//
import Foundation
import SnapKit

protocol LinkViewable {
    func setTitle(withTitle title: String)
    func setUps(withUps ups: String)
    func setMeta(withMeta meta: String)
}

protocol LinkView: LinkViewable {
    var titleLabel: UILabel { get }
    var actionsView: LinkActionsView { get }
    var infoView: LinkInfoView { get }
}

extension LinkView {
    func setTitle(withTitle title: String) {
        titleLabel.text = title
    }
    
    func setUps(withUps ups: String) {
        actionsView.voteView.voteCountLabel.text = ups
    }
    
    func setMeta(withMeta meta: String) {
        infoView.metaLabel.text = meta
    }
}
