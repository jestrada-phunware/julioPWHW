//
//  GradientView.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/16/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = .black
    @IBInspectable var secondColor: UIColor = .clear

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [firstColor.cgColor, secondColor.cgColor]
    }

}
