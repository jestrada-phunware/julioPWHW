//
//  DetailViewController.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradient: GradientView!

    // MARK: - Properties
    var event: Event!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailNavBar(self.navigationController)
        configureScrollView()
        setupData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Functions
    func configureDetailNavBar(_ navigationController: UINavigationController?) {
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.isTranslucent = true
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.backgroundColor = .clear
        navBar.shadowImage = UIImage()
        navBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
    }

    func configureScrollView() {
        scrollView.delegate = self
    }

    func setupData() {
        dateLabel.text = event.date.formatDateFromISO()
        titleLabel.text = event.title
        descriptionLabel.text = event.eventDescription

        guard let imageURLString = event.image, let imageURL = URL(string: imageURLString) else { return }
        headerImage.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "placeholder_nomoon"), options: .highPriority, completed: nil)
    }

    // MARK: - Actions
    @objc func shareButtonTapped() {
        guard let dateLabel = dateLabel.text,
            let headerImage = headerImage.image,
            let titleLabel = titleLabel.text,
            let descriptionLabel = descriptionLabel.text else { return }

        let items = [headerImage, dateLabel, titleLabel, descriptionLabel] as [Any]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ .assignToContact,
                                                         .print,
                                                         .addToReadingList,
                                                         .saveToCameraRoll,
                                                         .openInIBooks]
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: false, completion: nil)
    }

    // MARK: - Interactions
    @IBAction func swipeLeftEdge(_ swipe: UIScreenEdgePanGestureRecognizer) {
        let swipeAmount = swipe.translation(in: view)
        let swipePercent = swipeAmount.x/view.frame.width

        switch swipe.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            let _ = navigationController?.popToRootViewController(animated: true)
        case .changed:
            interactiveTransition?.update(swipePercent)
        case .cancelled, .ended:
            if swipePercent < 0.16 {
                interactiveTransition?.cancel()
            } else {
                interactiveTransition?.finish()
            }
            interactiveTransition = nil
        default:
            break
        }
    }
}

// MARK: - UIScrollViewDelegate
extension DetailViewController: UIScrollViewDelegate {

    fileprivate func whiteTheme(with navBar: UINavigationBar, navController: UINavigationController) {
        navBar.isTranslucent = false
        navController.view.backgroundColor = .white
        navController.navigationBar.tintColor = .black
        navBar.topItem?.title = self.titleLabel.text
        navBar.layoutIfNeeded()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y / 100.0
        guard let navController = self.navigationController else { return }
        guard let navBar = self.navigationController?.navigationBar else { return }

        if offset > 1 {
            if offset >= 5 {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.whiteTheme(with: navBar, navController: navController)
                })

            } else if offset <= 3.6 {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
                    navController.navigationBar.isTranslucent = true
                    navController.navigationBar.backgroundColor = .clear
                    navController.navigationBar.tintColor = .white
                    navBar.topItem?.title = String()
                    navBar.layoutIfNeeded()
                })
            }
        }
    }
}

// MARK: - UINavigationController
extension UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
