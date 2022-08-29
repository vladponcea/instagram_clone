//
//  RegistrationViewController.swift
//  instagram_clone
//
//  Created by Vladut Mihai Poncea on 23.08.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - SubViews
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.usernameField)
        self.view.addSubview(self.emailField)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.registerButton)
        
        self.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        self.usernameField.delegate = self
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.usernameField.frame = CGRect(x: 20, y: self.view.safeAreaInsets.top + 100, width: self.view.width - 40, height: 52)
        self.emailField.frame = CGRect(x: 20, y: self.usernameField.bottom + 10, width: self.view.width - 40, height: 52)
        self.passwordField.frame = CGRect(x: 20, y: self.emailField.bottom + 10, width: self.view.width - 40, height: 52)
        self.registerButton.frame = CGRect(x: 20, y: self.passwordField.bottom + 10, width: self.view.width - 40, height: 52)
    }
    
    
    // MARK: - OBJC Functions
    @objc private func didTapRegister() {
        self.usernameField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    // success
                } else {
                    // failed
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameField {
            emailField.becomeFirstResponder()
        } else if textField == self.emailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        
        return true
    }
}
