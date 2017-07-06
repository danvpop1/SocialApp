//
//  PostCell.swift
//  SocialApp
//
//  Created by bogdan razvan on 28/06/2017.
//  Copyright © 2017 bogdan razvan. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post){
        self.captionText.text = post.caption
        self.likesLabel.text = "\(post.likes)"
    }
    
}
