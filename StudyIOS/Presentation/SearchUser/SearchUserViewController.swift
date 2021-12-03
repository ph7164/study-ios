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
        static let searchRecordCellIdentifier = "SearchRecordTableViewCell"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var users: [UserModel] = []
    private var viewModel: SearchUserViewModelType?
    private var searchRecord: [String] = []
    private var isCancelSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tableView.register(UINib(nibName: Constants.searchRecordCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.searchRecordCellIdentifier)
        
        configureSearchController()
        definesPresentationContext = true

        viewModel = SearchUserViewModel()
        bindUI()
    }
    
    private func bindUI() {
        viewModel?.searchUserResult.bind { [weak self] users in
            self?.users = users
            self?.tableView.reloadData()
        }
        
        viewModel?.searchUserError.bind { [weak self] error in
            switch error {
            case .initError:
                break
            case .emptyKeywordError:
                self?.showEmptyKeywordErrorAlert(msg: "키워드를 입력해 주세요.")
            default:
                break
            }
        }
        
        viewModel?.isCancelSearch.bind { [weak self] isCancel in
            self?.isCancelSearch = isCancel
            if isCancel {
                if let record = self?.viewModel?.searchRecord {
                    self?.searchRecord = record
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func showEmptyKeywordErrorAlert(msg: String) {
        let alert = UIAlertController(title: nil,
                                      message: msg,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SearchUserViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let str = searchBarText.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
        if str.isEmpty { return }
        searchController.isActive = false
        viewModel?.searchUser(text: searchBarText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.didCancelSearch()
    }
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}
extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCancelSearch {
            return searchRecord.count
        } else {
            return users.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isCancelSearch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? UserTableViewCell else { return UserTableViewCell() }
            cell.setProfile(imgUrl: users[indexPath.row].profileUrl, name: users[indexPath.row].name)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchRecordCellIdentifier, for: indexPath) as? SearchRecordTableViewCell else { return SearchRecordTableViewCell() }
            cell.setData(keyword: searchRecord[indexPath.row])
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCancelSearch {
            searchController.isActive = false
            viewModel?.searchUser(text: searchRecord[indexPath.row])
        }
    }
}
