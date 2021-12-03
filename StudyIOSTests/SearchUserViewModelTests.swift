//
//  SearchUserViewModelTests.swift
//  StudyIOSTests
//
//  Created by 홍필화 on 2021/11/30.
//

import XCTest
@testable import StudyIOS

class DummySearchUserRepository: SearchUserRepository {
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
    }
}

class MockSearchUserUseCase: SearchUserUseCaseType {
    
    var searchUserList: [UserModel]?
    var searchUserCallsCount = 0
    var searchUsersError: StudyError?
    
    init(repository: SearchUserRepository = DummySearchUserRepository()) {
    }
    
    func searchUser(text: String, completion: @escaping (Result<[UserModel], StudyError>) -> Void) {
        searchUserCallsCount += 1
        if let users = searchUserList {
            completion(.success(users))
        }
        if let err = searchUsersError {
            completion(.failure(err))
        }
    }
}

class SearchUserViewModelTests: XCTestCase {
    
    var viewModel: SearchUserViewModelType!
    var useCase: MockSearchUserUseCase!

    override func setUpWithError() throws {
        useCase = MockSearchUserUseCase()
        viewModel = SearchUserViewModel(useCase: useCase)
    }

    override func tearDownWithError() throws {
        useCase = nil
        viewModel = nil
    }

    func testViewModelEmptyKeyword() {
        let expectation = expectation(description: #function)
        let expectedError = StudyError.emptyKeywordError
        let expectedCallsCount = 0
        
        viewModel.searchUser(text: "")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(0, viewModel.searchUserResult.value.count)
        XCTAssertEqual(expectedCallsCount, useCase.searchUserCallsCount)
        XCTAssertEqual(expectedError, viewModel.searchUserError.value)
    }
    
    func testViewModelError() {
        let expectation = expectation(description: #function)
        let expectedError = StudyError.internalError(message: "error")
        let expectedCallsCount = 1
        useCase.searchUsersError = .internalError(message: "error")
        
        viewModel.searchUser(text: "asdf")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(expectedCallsCount, useCase.searchUserCallsCount)
        XCTAssertEqual(0, viewModel.searchUserResult.value.count)
        XCTAssertEqual(expectedError, viewModel.searchUserError.value)
    }

    func testViewModelSuccess() {
        let expectation = expectation(description: #function)
        let expectedCallsCount = 1
        let expectedUsers: [UserModel] = [.init(name: "ph", profileUrl: ""),
                                          .init(name: "pp", profileUrl: "")]
        useCase.searchUserList = expectedUsers
        
        viewModel.searchUser(text: "p")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(expectedCallsCount, useCase.searchUserCallsCount)
        XCTAssertEqual(expectedUsers, viewModel.searchUserResult.value)
    }
    
    func testViewModelSearchCancel() {
        let expectedValue = true
        
        viewModel.didCancelSearch()
        
        XCTAssertEqual(expectedValue, viewModel.isCancelSearch.value)
    }
}
