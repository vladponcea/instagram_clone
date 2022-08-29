//
//  HomeViewController.swift
//  instagram_clone
//
//  Created by Vladut Mihai Poncea on 23.08.2022.
//

import UIKit
import FirebaseAuth
import StoreKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        //checking auth status
        if Auth.auth().currentUser == nil {
            //showing login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

