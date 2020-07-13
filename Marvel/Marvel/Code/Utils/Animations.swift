//
//  Animations.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 10/07/2020.
//

import UIKit

let RotationAnimationKey = "rotationAnimation"

extension UIView {
    func startRotation() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: RotationAnimationKey)
    }
    
    func stopRotation() {
        self.layer.removeAnimation(forKey: RotationAnimationKey)
    }
    
    func dismissScalingAndMovingDown(scale: CGFloat, verticalPosition: CGFloat) {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2.0
        let originalTransform = self.transform
        let scaledTransform = originalTransform.scaledBy(x: scale, y: scale)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: verticalPosition)
        UIView.animate(withDuration: 1, animations: {
            self.transform = scaledTransform
        }) { _ in
            UIView.animate(withDuration: 0.7, animations: {
                self.transform = scaledAndTranslatedTransform
            })
        }
    }
}
