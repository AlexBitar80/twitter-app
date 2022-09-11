//
//  ExplorerController.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 22/05/22.
//

import UIKit

class ExploreController: UITableViewController {
    // MARK: - Properties

    private var users: [User] = [] {
        didSet { tableView.reloadData() }
    }

    private var filteredUser: [User] = [] {
        didSet { tableView.reloadData() }
    }

    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    private let searchController = UISearchController()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        configureSearchController()
    }

    // MARK: - API

    func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
        }
    }

    // MARK: - Helpers

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

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

// MARK: - UITableViewControllerDelegate/DataSource
extension ExploreController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return inSearchMode ? filteredUser.count : users.count
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

        let user = inSearchMode ? filteredUser[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUser[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUser = users.filter({ $0.username.contains(searchText)})
    }
}
