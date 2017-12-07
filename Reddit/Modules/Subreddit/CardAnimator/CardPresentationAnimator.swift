//
//  CardPresentationAnimator.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/25/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class CardPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
        super.init()
    }
    
    var duration: TimeInterval = 0.7
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }   
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        // Set the presented view controller the frame same as the origin frame
       
        toViewController.view.frame = originFrame

        containerView.addSubview(toViewController.view)
        toViewController.view.setNeedsLayout()
        toViewController.view.layoutIfNeeded()

        UIView.animate(withDuration: animationDuration, 
                       delay: 0, 
                       usingSpringWithDamping: 0.5, 
                       initialSpringVelocity: 0.25, 
                       options: .layoutSubviews, 
                       animations: { 
            toViewController.view.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
