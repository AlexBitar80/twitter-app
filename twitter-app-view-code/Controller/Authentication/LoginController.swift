//
//  LoginController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 31/05/22.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "twitter-logo-white")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: "envelope")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: "lock")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "E-mail")
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.blueTwitter, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        configureUI()
    }
    
    
    //MARK: - Selectors
    
    @objc func handleLogin() {
        print("handle login here...")
    }
    
    @objc func handleShowSignUp() {
        let registrationController = RegistrationController()
        
        navigationController?.pushViewController(registrationController, animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .blueTwitter
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        logoImageView.setDimensions(width: 70, height: 70)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton])
        
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32,paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                      paddingLeft: 40, paddingBottom: 8, paddingRight: 40)
    }
}
