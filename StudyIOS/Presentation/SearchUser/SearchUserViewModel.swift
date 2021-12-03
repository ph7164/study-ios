//
//  SearchUserViewModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/23.
//

import Foundation

protocol SearchUserViewModelType {
    func searchUser(text: String)
    func didCancelSearch()
    var searchUserResult: Box<[UserModel]> { get }
    var searchUserError: Box<StudyError> { get }
    var searchRecord: [String] { get }
    var isCancelSearch: Box<Bool> { get }
}

class SearchUserViewModel: SearchUserViewModelType {
    private var useCase: SearchUserUseCaseType?
    let searchUserResult = Box([UserModel]())
    let searchUserError = Box(StudyError.initError)
    var searchRecord: [String] = []
    let isCancelSearch = Box(false)
    
    init(useCase: SearchUserUseCaseType = SearchUserUseCase(repository: API.shared)) {
        self.useCase = useCase
    }
}

extension SearchUserViewModel {
    func searchUser(text: String) {
        guard text != "" else {
            searchUserError.value = .emptyKeywordError
            return
        }
        isCancelSearch.value = false
        searchRecord.insert(text, at: 0)
        useCase?.searchUser(text: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.searchUserResult.value = users
            case .failure(let error):
                self.searchUserError.value = error
            }
        }
    }
    
    func didCancelSearch() {
        isCancelSearch.value = true
    }
}

