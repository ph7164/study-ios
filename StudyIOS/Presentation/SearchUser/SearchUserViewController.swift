//
//  SearchUserViewController.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import UIKit
import Alamofire

class SearchUserViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var users: [SearchUserDTO.UserProfile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search User"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
}

extension SearchUserViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let str = searchController.searchBar.text?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
        if str!.count < 1 {
            
        } else {
            API.shared.searchUser(text: searchController.searchBar.text!) { (result, err) in
                if err == nil {
                    if !result!.isEmpty {
                        self.users = result!
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
    }
}
extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && !searchController.searchBar.text!.isEmpty {
            return users.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else { return UserTableViewCell() }        
        cell.setProfile(imgUrl: users[indexPath.row].profileUrl, name: users[indexPath.row].name)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
