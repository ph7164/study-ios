//
//  SearchUserViewModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/23.
//

import Foundation

class SearchUserViewModel {
    private var useCase = SearchUserUseCase(repository: API.shared)
    let searchUserResult = Box([UserModel]())
    let searchUserError = Box(StudyError.initError)
    
    init(useCase: SearchUserUseCase) {
        self.useCase = useCase
    }
}

extension SearchUserViewModel {
    func searchUser(text: String) {
        guard text != "" else {
            searchUserError.value = .emptyKeywordError
            return
        }
        useCase.searchUser(text: text) { [weak self] (result, err) in
            guard let self = self,
                  err == nil else {
                      self?.searchUserError.value = err!
                      return
                  }
            guard let result = result else { return }
            self.searchUserResult.value = result
        }
    }
}

