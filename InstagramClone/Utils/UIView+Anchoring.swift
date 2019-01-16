//
//  UIView+Ancoring.swift
//  anchorextensions
//
//  Created by Daniel Peach on 1/15/19.
//  Copyright © 2019 Peach Crate. All rights reserved.
//

import UIKit

extension UIView {
    func addSubViews(views: [UIView]) {
        views.forEach( { self.addSubview($0) } )
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero) {
        self.disableAutoresizingMask()
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).setActive()
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).setActive()
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).setActive()
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).setActive()
        }
    }
    
    func centerView() {
        self.disableAutoresizingMask()
        
        if let centerYAnchor = superview?.centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor).setActive()
        }
        if let centerXAnchor = superview?.centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor).setActive()
        }
    }
    
    func centerViewY() {
        self.disableAutoresizingMask()
        
        if let centerYAnchor = superview?.centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor).setActive()
        }
    }
    
    func centerViewX() {
        self.disableAutoresizingMask()
        
        if let centerXAnchor = superview?.centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor).setActive()
        }
    }
    
    func setSize(width: Int?, height: Int?) {
        self.disableAutoresizingMask()
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: CGFloat(width)).setActive()
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: CGFloat(height)).setActive()
        }
    }
    
    func setSize(width: CGFloat?, height: CGFloat?) {
        self.disableAutoresizingMask()
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).setActive()
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).setActive()
        }
    }
    
    func setSize(widthAnchor: NSLayoutDimension?, heightAnchor: NSLayoutDimension?) {
        self.disableAutoresizingMask()
        
        if let widthAnchor = widthAnchor {
            self.widthAnchor.constraint(equalTo: widthAnchor).setActive()
        }
        if let heightAnchor = heightAnchor {
            self.heightAnchor.constraint(equalTo: heightAnchor).setActive()
        }
    }
    
    func fillSuperView(padding: UIEdgeInsets = .zero) {
        self.disableAutoresizingMask()
        
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func disableAutoresizingMask() {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension NSLayoutConstraint {
    func setActive() {
        self.isActive = true
    }
}
