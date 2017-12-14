//
//  SnapKit+SafeAreaLayout.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/14/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        
        #if swift(>=3.2)
            if #available(iOS 11.0, *) {
                return self.safeAreaLayoutGuide.snp
            }
            return self.snp
        #else
            return self.snp
        #endif
    }
}
