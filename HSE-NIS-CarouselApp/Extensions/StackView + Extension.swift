//
//  StackView + Extension.swift
//  HSE-NIS-CarouselApp
//
//  Created by Ярослав Карпунькин on 01.02.2021.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        distribution = .fillEqually
    }
}
