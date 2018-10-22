//
//  NavigationControllerDelegate.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/20/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if fromVC.isKind(of: HomeViewController.self) {
            return ShowTransition()
        } else if fromVC.isKind(of: DetailViewController.self) {
            return DismissTransition()
        } else {
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController.isKind(of: DismissTransition.self) {
            return interactiveTransition
        } else {
            return nil
        }
    }
}
