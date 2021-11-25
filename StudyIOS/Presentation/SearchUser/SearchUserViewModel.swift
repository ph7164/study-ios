//
//  SearchUserViewModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/23.
//

import Foundation

class SearchUserViewModel {
    private let useCase = SearchUserUseCase(repository: API.shared)
    let searchUserResult = Box([UserModel]())
    
//    var searchDone: ((_ result: [UserModel]) -> Void)?
}

extension SearchUserViewModel {
    func searchUser(text: String) {
        useCase.searchUser(text: text) { [weak self] (result, err) in
            guard let self = self,
                  err == nil else {
                      return
                  }
            guard let result = result else { return }
            self.searchUserResult.value = result
//            if self.searchDone != nil {
//                self.searchDone!(result)
//            }
        }
    }
}

