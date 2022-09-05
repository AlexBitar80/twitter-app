//
//  ExplorerController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class ExploreController: UITableViewController {
    // MARK: - Properties

    var users: [User] = [] {
        didSet { tableView.reloadData() }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchUsers()
    }

    // MARK: - API

    func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
        }
    }

    // MARK: - Helpers

    func configureUI() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

        tableView.register(
            UserCell.self,
            forCellReuseIdentifier: UserCell.reuseIdentifier
        )
        tableView.rowHeight = 60
        tableView.separatorStyle = .none

		navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Explore"

        view.backgroundColor = .white
    }
}

// MARK: - UITableViewControllerDelegate
extension ExploreController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return users.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserCell.reuseIdentifier,
            for: indexPath
        ) as? UserCell else {
            return UserCell()
        }

        cell.user = users[indexPath.row]
        return cell
    }
}
