//
//  SearchUserViewController.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import UIKit

class SearchUserViewController: UIViewController {
    
    enum Constants {
        static let searchBarPlaceholder = "Search User"
        static let tableViewCellIdentifier = "UserTableViewCell"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var users: [UserModel] = []
    private var viewModel: SearchUserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        
        configureSearchController()
        definesPresentationContext = true

        viewModel = SearchUserViewModel()
        bindUI()
    }
    
    private func bindUI() {
        viewModel?.searchUserResult.bind { [weak self] searchResult in
            self?.users = searchResult
            self?.tableView.reloadData()
        }
//        viewModel?.searchDone = { result in
//            self.users = result
//            self.tableView.reloadData()
//        }
    }
}

extension SearchUserViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        let str = searchBarText.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
        if str.isEmpty { return }
        viewModel?.searchUser(text: searchBarText)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
        navigationItem.searchController = searchController
    }
}
extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text?.isEmpty == false {
            return users.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? UserTableViewCell else { return UserTableViewCell() }
        cell.setProfile(imgUrl: users[indexPath.row].profileUrl, name: users[indexPath.row].name)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
