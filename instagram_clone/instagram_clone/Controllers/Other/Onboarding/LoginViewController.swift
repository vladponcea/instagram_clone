//
//  LoginViewController.swift
//  instagram_clone
//
//  Created by Vladut Mihai Poncea on 23.08.2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - SubViews
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.usernameEmailField.delegate = self
        self.passwordField.delegate = self
        
        self.loginButton.addTarget(
            self,
            action: #selector(didTapLoginButton),
            for: .touchUpInside
        )
        self.createAccountButton.addTarget(
            self,
            action: #selector(didTapCreateAccountButton),
            for: .touchUpInside
        )
        self.termsButton.addTarget(
            self,
            action: #selector(didTapTermsButton),
            for: .touchUpInside
        )
        self.privacyButton.addTarget(
            self,
            action: #selector(didTapPrivacyButton),
            for: .touchUpInside
        )
        
        self.addSubViews()
    }
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //asign frames
        self.headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: self.view.width,
            height: self.view.height/3.0
        )
        
        self.usernameEmailField.frame = CGRect(
            x: 25,
            y: self.headerView.bottom + 40,
            width: self.view.width - 50,
            height: 52.0
        )
        
        self.passwordField.frame = CGRect(
            x: 25,
            y: self.usernameEmailField.bottom + 10,
            width: self.view.width - 50,
            height: 52.0
        )
        
        self.loginButton.frame = CGRect(
            x: 25,
            y: self.passwordField.bottom + 10,
            width: self.view.width - 50,
            height: 52.0
        )
        
        self.createAccountButton.frame = CGRect(
            x: 25,
            y: self.loginButton.bottom + 10,
            width: self.view.width - 50,
            height: 52.0
        )
        
        self.termsButton.frame = CGRect(
            x: 10,
            y: self.view.height - self.view.safeAreaInsets.bottom - 100,
            width: self.view.width-20,
            height: 50
        )
        
        self.privacyButton.frame = CGRect(
            x: 10,
            y: self.view.height - self.view.safeAreaInsets.bottom - 50,
            width: self.view.width-20,
            height: 50
        )
        
        self.configureHeaderView()
    }
    
    
    // MARK: - Private Functions
    private func configureHeaderView() {
        guard self.headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = self.headerView.subviews.first else {
            return
        }
        backgroundView.frame = self.headerView.bounds
        
        // add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        self.headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: self.headerView.width/4.0,
            y: self.view.safeAreaInsets.top,
            width: self.headerView.width/2.0,
            height: self.headerView.height - self.view.safeAreaInsets.top
        )
    }
    
    private func addSubViews() {
        self.view.addSubview(usernameEmailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginButton)
        self.view.addSubview(termsButton)
        self.view.addSubview(privacyButton)
        self.view.addSubview(createAccountButton)
        self.view.addSubview(headerView)
    }
    
    
    // MARK: - OBJC Functions
    @objc private func didTapLoginButton() {
        self.passwordField.resignFirstResponder()
        self.usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
        let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        //login functionality
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = username
            // email
        } else {
            username = usernameEmail
            // username
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error occured
                    let alert = UIAlertController(title: "Log in error", message: "We were unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private  func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameEmailField {
            self.passwordField.becomeFirstResponder()
        } else if textField == self.passwordField {
            didTapLoginButton()
        }
        
        return true
    }
}
