//
//  UIView+Anchoring.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(centerXAnchor: NSLayoutXAxisAnchor?, centerYAnchor: NSLayoutYAxisAnchor?, topAnchor: NSLayoutYAxisAnchor?, rightAnchor: NSLayoutXAxisAnchor?, bottomAnchor: NSLayoutYAxisAnchor?, leftAnchor: NSLayoutXAxisAnchor?, topPadding: CGFloat = 0, rightPadding: CGFloat = 0, bottomPadding: CGFloat = 0, leftPadding: CGFloat = 0) {
        
        self.disableAutoresizingMask()
        
        if let centerX = centerXAnchor {
            assert(leftAnchor == nil && rightAnchor == nil, "When using centerXAnchor, do not attempt to use left or right anchors")
            assert(rightPadding == leftPadding, "When using centerXAnchor, set the left and right padding to the same value")
            self.centerXAnchor.constraint(equalTo: centerX, constant: rightPadding).isActive = true
        }
        
        if let centerY = centerYAnchor {
            assert(topAnchor == nil && bottomAnchor == nil, "When using centerYAnchor, do not attempt to use top or bottom anchors")
            assert(topPadding == bottomPadding, "When using centerYAnchor, set the top and bottom padding to the same value")
            self.centerYAnchor.constraint(equalTo: centerY, constant: topPadding).isActive = true
        }
        
        if let top = topAnchor {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let right = rightAnchor {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if let bottom = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
        
        if let left = leftAnchor {
            self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
    }
    
    func setSize(widthAnchor: CGFloat?, heightAnchor: CGFloat?) {
        
        self.disableAutoresizingMask()
        
        if let width = widthAnchor {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = heightAnchor {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func disableAutoresizingMask() {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
}
