//
//  ShadowedView.swift
//  SocialApp
//
//  Created by bogdan razvan on 28/06/2017.
//  Copyright © 2017 bogdan razvan. All rights reserved.
//

import UIKit

class ShadowedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.5).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }

}
