//
//  Transitions.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/20/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import UIKit

var interactiveTransition: UIPercentDrivenInteractiveTransition?

class ShowTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let _ = sourceViewController.view,
            let destinationView = destinationViewController.view
            else { return }

        let containerView = transitionContext.containerView
        containerView.addSubview(destinationView)
        destinationView.alpha = 0

        let showAnimator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.9) {
            destinationView.alpha = 1
        }
        showAnimator.startAnimation()
        showAnimator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}

class DismissTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let _ = sourceViewController.view,
            let destinationView = destinationViewController.view
            else { return }

        let containerView = transitionContext.containerView
        containerView.addSubview(destinationView)
        destinationView.alpha = 0

        // Using this instead of UIViewPropertyAnimator as it allows me to swipe back & forth from detail to master
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [], animations: {
            destinationView.alpha = 1
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
}
