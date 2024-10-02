//
//  UICollectionReusableView+Extension.swift
//  tip-calculator
//
//  Created by Kai Fu Jhuang on 2024/10/3.
//

import UIKit

extension UICollectionReusableView {
    static var identifier: String {
        .init(describing: Self.self)
    }

    func setupCornerRadius(isFirst: Bool, isLast: Bool) {
        let maskedCorners: CACornerMask? = switch (isFirst, isLast) {
            case (true, true):
                [
                    .layerMinXMinYCorner,
                    .layerMinXMaxYCorner,
                    .layerMaxXMinYCorner,
                    .layerMaxXMaxYCorner,
                ]
            case (true, false):
                [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner,
                ]
            case (false, true):
                [
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner,
                ]
            case (false, false):
                nil
        }

        guard let maskedCorners else {
            return
        }

        layer.cornerRadius = 4
        clipsToBounds = true
        layer.maskedCorners = maskedCorners
    }
}
