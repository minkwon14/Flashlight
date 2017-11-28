//
//  DesignableSlider.swift
//  Flashlight
//
//  Created by Minseo Kwon on 2017-11-28.
//  Copyright © 2017 MinKwon. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
  /*
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 3.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    */

}
