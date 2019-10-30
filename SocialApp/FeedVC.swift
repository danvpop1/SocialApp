//
//  FeedVC.swift
//  SocialApp
//
//  Created by bogdan razvan on 25/06/2017.
//  Copyright © 2017 bogdan razvan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getPosts();
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        let keychainResult =   KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Keychain info: \(keychainResult)")
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell;
        }
        else {
            return PostCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    private func getPosts() {
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if snapshot.children.allObjects is [DataSnapshot] {
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
}
