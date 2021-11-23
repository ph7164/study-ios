//
//  SearchUserUseCase.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

protocol SearchUserUseCaseType {
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]?, StudyError?) -> Void)
}

class SearchUserUseCase: SearchUserUseCaseType {
    
    private let repository: SearchUserRepository
    var searchResult: [SearchUserDTO.UserProfile] = []
    
    init(repository: SearchUserRepository) {
        self.repository = repository
    }
    
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        // 1. 빈 키워드
        guard !text.isEmpty else {
            completion(nil, .emptyKeywordError)
            return
        }
        repository.searchUser(text: text) { [weak self] (result, error) in
            guard error == nil else {
                // 3. 검색 실패
                completion(nil, error)
                return
            }
            guard let result = result else { return }
            // 2. 검색 성공
            self?.searchResult = result
            completion(result, nil)
        }
    }
    
}
