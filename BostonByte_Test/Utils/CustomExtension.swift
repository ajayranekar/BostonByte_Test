//
//  CustomExtension.swift
//  BostonByte_Test
//
//  Created by Apple on 16/11/19.
//  Copyright © 2019 Ajay Ranekar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension UIViewController {

    func alert(message: String) -> Void {
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: Constant.OK, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

enum HTTPMethod {
    case GET
    case POST
}
