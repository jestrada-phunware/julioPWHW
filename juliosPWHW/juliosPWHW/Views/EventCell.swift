//
//  EventCell.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//


import UIKit
import SDWebImage

class EventCell: UICollectionViewCell {
    static let defaultIdentifier = "EventCell"

    // MARK: - Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageOverlay: UIView!
    
    var event: Event! {
        didSet {
            dateLabel.text = event.date.formatDateFromISO()
            eventTitle.text = event.title
            locationLabel.text = "\(event.locationLineOne ?? ""), \(event.locationLineTwo ?? "")"
            descriptionLabel.text = event.eventDescription

            guard let imageUrl = URL(string: event.image ?? "") else {
                imageBackground.image = #imageLiteral(resourceName: "placeholder_nomoon")
                return
            }

            imageBackground.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder_nomoon"), options: .highPriority, completed: nil)
        }
    }
}
