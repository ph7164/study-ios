//
//  SearchUserViewModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/23.
//

import Foundation

protocol SearchUserViewModelInput {
    func searchUser(text: String, completion: @escaping([UserModel]?, StudyError?) -> Void)
}

protocol SearchUserViewModelOutput {
    var searchUserResultList: [UserModel] { get }
}

protocol SearchUserViewModelType {
    var input: SearchUserViewModelInput { get }
    var output: SearchUserViewModelOutput { get }
}

class SearchUserViewModel: SearchUserViewModelType {
    private let repo = API.shared
    private let useCase = SearchUserUseCase(repository: API.shared)
    private var searchUserResult: [UserModel] = []
}

extension SearchUserViewModel: SearchUserViewModelInput {
    var input: SearchUserViewModelInput { return self }
    func searchUser(text: String, completion: @escaping ([UserModel]?, StudyError?) -> Void) {
        useCase.searchUser(text: text) { [weak self] (result, err) in
            guard err == nil else {
                completion(nil, err)
                return
            }
            guard let result = result else { return }
            self?.searchUserResult = result
            completion(result, nil)
        }
    }
}

extension SearchUserViewModel: SearchUserViewModelOutput {
    var output: SearchUserViewModelOutput { return self }
    var searchUserResultList: [UserModel] {
        return searchUserResult
    }
}
