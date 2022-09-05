//
//  UserCell.swift
//  twitter-app-view-code
//
//  Created by João Alexandre Bitar on 27/08/22.
//

import UIKit

class UserCell: UITableViewCell {
    // MARK: - Properties

    var user: User? {
        didSet { configure() }
    }

    static let reuseIdentifier = "UserCell"

    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.setDimensions(width: 40, height: 40)
        image.layer.cornerRadius = 40/2
        return image
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)

        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2

        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configure() {
        guard let user = user else { return }

        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        usernameLabel.text = user.username
        fullnameLabel.text = user.fullname
    }
}
