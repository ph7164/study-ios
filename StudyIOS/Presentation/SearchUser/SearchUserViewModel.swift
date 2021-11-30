//
//  SearchUserViewModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/23.
//

import Foundation

protocol SearchUserViewModelType {
    func searchUser(text: String)
    var searchUserResult: Box<[UserModel]> { get }
    var searchUserError: Box<StudyError> { get }
}

class SearchUserViewModel: SearchUserViewModelType {
    private var useCase: SearchUserUseCaseType?
    let searchUserResult = Box([UserModel]())
    let searchUserError = Box(StudyError.initError)
    
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
}

