//
//  RegistrationController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 02/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationController: UIViewController {
    // MARK: - Properties

    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?

    private lazy var plusPhotoButton: UIButton = {
		var configuration = UIButton.Configuration.plain()
		configuration.image = UIImage(systemName: "photo.circle")

        let button = UIButton(type: .system)
		button.configuration = configuration
		button.imageView?.setDimensions(width: 120, height: 120)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddPhotoProfile), for: .touchUpInside)
        return button
    }()

    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: "envelope")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()

    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: "lock")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()

    private lazy var fullnameContainerView: UIView = {
        let image = UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
        return view
    }()

    private lazy var usernameContainerView: UIView = {
        let image = UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
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

    private lazy var fullnameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Full Name")
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()

    private lazy var usernameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Username")
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.blueTwitter, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()

    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        navigationController?.navigationBar.isHidden = true

        configureUI()
    }

    // MARK: - Selectors

    @objc func handleSignUp() {
        guard let profileImage = profileImage else {
            print("DEBUG: Please select a profile image")
            return
        }

		guard
			let email = emailTextField.text,
			let password = passwordTextField.text,
			let fullname = fullnameTextField.text,
			let username = usernameTextField.text?.lowercased()
		else {
			return
		}

        let credentials = AuthCredentials(
			email: email,
			password: password,
			fullname: fullname,
			username: username,
			profileImage: profileImage
		)

        AuthService.shared.registerUser(crendetials: credentials) { _, _ in
			let scenes = UIApplication.shared.connectedScenes
			let windowScene = scenes.first as? UIWindowScene

			guard
				let window = windowScene?.windows.first(where: { $0.isKeyWindow }),
				let tab = window.rootViewController as? MainTabController
			else {
				return
			}

            tab.authenticateUserAndConfigureUI()

            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func handleAddPhotoProfile() {
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .blueTwitter

		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.scrollEdgeAppearance = appearance

        view.addSubview(plusPhotoButton)

        plusPhotoButton.centerX(
			inView: view,
			topAnchor: view.safeAreaLayoutGuide.topAnchor,
			paddingTop: 16
		)

        plusPhotoButton.setDimensions(width: 120, height: 120)

        let stack = UIStackView(
			arrangedSubviews: [
				emailContainerView,
				passwordContainerView,
				fullnameContainerView,
				usernameContainerView,
				registrationButton
			]
		)

        stack.axis = .vertical
        stack.spacing = 20

        view.addSubview(stack)
        stack.anchor(
			top: plusPhotoButton.bottomAnchor,
			left: view.leftAnchor,
			right: view.rightAnchor,
			paddingTop: 16,
			paddingLeft: 32,
			paddingRight: 32
		)

        view.addSubview(alreadyHaveAccountButton)

        alreadyHaveAccountButton.anchor(
			left: view.leftAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			right: view.rightAnchor,
			paddingLeft: 40,
			paddingBottom: 8,
			paddingRight: 40
		)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
		_ picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
	) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage

        plusPhotoButton.layer.cornerRadius = 120 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3

        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)

        dismiss(animated: true, completion: nil)
    }
}
