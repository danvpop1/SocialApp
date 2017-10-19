//
//  RoundedImage.swift
//  SocialApp
//
//  Created by bogdan razvan on 26/06/2017.
//  Copyright © 2017 bogdan razvan. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
}
