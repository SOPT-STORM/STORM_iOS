//
//  UIView.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension UIView {
    
    func addRoundShadow(cornerRadius: CGFloat) {
        
      self.layer.cornerRadius = cornerRadius
        
      let containerView = UIView()
      
      layer.backgroundColor = UIColor.clear.cgColor
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 3.0)
      layer.shadowOpacity = 0.16
      layer.shadowRadius = 2.5
        
      containerView.layer.cornerRadius = cornerRadius
      containerView.layer.masksToBounds = true
      
      self.addSubview(containerView)
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setRound(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    /* 8/3 추가 */
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
    
    func addShadow(cornerRadus: CGFloat, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat, shadowColor: UIColor = .black ) {
        self.layer.cornerRadius = cornerRadus
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        // 마지막 이해 x
    }
    
    
    
    /* 8/3 추가 */
    
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
    /*
    func showAnimate()
    {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.removeFromSuperview()
                }
        });
    }*/
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
               return layer.shadowOffset
           }
           set {
               layer.shadowOffset = newValue
               layer.masksToBounds = false
           }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    /*func showAnimate() {
        self.layer.transform = CGAffineTransform(1.3,1.3)
    }*/
    
    
    
}
