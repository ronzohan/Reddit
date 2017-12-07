//
//  CardTransitioningDelegate.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/25/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    var originFrame: CGRect?
    
    func presentationController(forPresented presented: UIViewController, 
                                presenting: UIViewController?, 
                                source: UIViewController) -> UIPresentationController? {
        return CardPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, 
                             presenting: UIViewController, 
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardPresentationAnimator(originFrame: originFrame ?? CGRect.zero)
    }

    func animationController(forDismissed dismissed: UIViewController) -> 
        UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
