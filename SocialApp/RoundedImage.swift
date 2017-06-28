//
//  RoundedImage.swift
//  SocialApp
//
//  Created by bogdan razvan on 26/06/2017.
//  Copyright © 2017 bogdan razvan. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 5
    }
    
}
