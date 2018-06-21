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

    // MARK: - Properties
    var indexPath: IndexPath!
    var event: Event!

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        setupData()
    }

    func configureNavBar() {
        let navBar = self.navigationController?.navigationBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        navigationController?.navigationBar.tintColor = .white
        navBar?.shadowImage = UIImage()
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.isTranslucent = true
    }

    func setupData() {
        dateLabel.text = event.date.formatDateFromISO()
        titleLabel.text = event.title
        descriptionLabel.text = event.eventDescription
        guard let imageUrl = URL(string: event.image ?? "") else {
            headerImage.image = #imageLiteral(resourceName: "placeholder_nomoon")
            return
        }
        headerImage.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder_nomoon"), options: .lowPriority, completed: nil)
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
}
















