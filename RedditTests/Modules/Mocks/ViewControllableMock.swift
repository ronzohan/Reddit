//
//  ViewControllableMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/23/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit
import RIBs

class ViewControllableMock: UIViewController, ViewControllable {
    var uiviewController: UIViewController {
        return self
    }
}
