//
//  ViewController.swift
//  SocialApp
//
//  Created by bogdan razvan on 17/06/2017.
//  Copyright © 2017 bogdan razvan. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
import SwiftKeychainWrapper
import Foundation

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    @IBAction func facebookLoginButtonPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ ReadPermission.publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login to Facebook.")
            case .success( _, _, let accessToken):
                print("Logged in to Facebook!")
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil) {
                print("Unable to sign in with firebase: \(error.debugDescription)")
            } else {
                print("Sucessful sign in with firebase")
                if let user = user {
                    let userData = ["provider" : credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        }
    }
    
    @IBAction func emailLoginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                if error == nil{
                    print("Email user authenticated with Firebase!")
                    if let user = user {
                        let userData = ["provider" : user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                        if error != nil {
                            print("Email user authentication failed: \(error.debugDescription)")
                        } else {
                            print("Email user created and authenticated with Firebase!")
                            if let user = user {
                                let userData = ["provider" : user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)                            }
                        }
                    })
                }
            })
        }
    }
    
    private func completeSignIn(id: String, userData: Dictionary<String, String>) {
    
    DataService.ds.createFirebaseUser(uid: id, userData: userData)
    
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to keychain")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
}

