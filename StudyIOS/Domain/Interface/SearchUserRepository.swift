//
//  SearchUserRepository.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

protocol SearchUserRepository {
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]?, StudyError?) -> Void)
}
