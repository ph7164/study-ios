//
//  StudyIOSTests.swift
//  StudyIOSTests
//
//  Created by 홍필화 on 2021/11/15.
//

import XCTest
@testable import StudyIOS

class DummySearchUserRepository: SearchUserRepository {
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
    }
}

class FakeSearchUserRepository: SearchUserRepository {
    var repo: [SearchUserDTO.UserProfile] = []
    
    func addUser(test: SearchUserDTO.UserProfile) {
        repo.append(test)
    }
    
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        completion(repo, nil)
    }
}

class StubSearchUserRepository: SearchUserRepository {
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        completion([.init(name: "", profileUrl: ""),
                    .init(name: "", profileUrl: ""),
                    .init(name: "", profileUrl: "")], nil)
    }
}

class MockSearchUserRepository: SearchUserRepository {
    var searchUserCallsCount = 0
    var repo: [SearchUserDTO.UserProfile] = [.init(name: "", profileUrl: ""),
                                             .init(name: "", profileUrl: ""),
                                             .init(name: "", profileUrl: "")]
    
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        print("mock search")
        search()
        search()
        search()
        search()
        print("complete")
        completion(repo, nil)
    }
    
    func search() {
        print("count + 1")
        searchUserCallsCount += 1
    }
}

class StudyIOSTests: XCTestCase {
    var sut: SearchUserUseCase!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchUserUseCase(repository: FakeSearchUserRepository())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

}

extension StudyIOSTests {
    
    func testSearchWithEmptyKeywordFake() {
        // given
        let expectedResultCount = 3
        var resultCount = 0
        
        let fake = FakeSearchUserRepository()
        fake.addUser(test: .init(name: "", profileUrl: ""))
        fake.addUser(test: .init(name: "", profileUrl: ""))
        fake.addUser(test: .init(name: "", profileUrl: ""))
        sut = SearchUserUseCase(repository: fake)
        
        // when
        sut.searchUser(text: "") { (result, err) in
            guard let result = result else { return }
            resultCount = result.count
            
        }
        
        // then
        XCTAssertEqual(expectedResultCount, resultCount)
    }
    
    func testSearchWithEmptyKeywordStub() {
        // given
        let expectedResultCount = 3
        var resultCount = 0
        sut = SearchUserUseCase(repository: StubSearchUserRepository())
        
        // when
        sut.searchUser(text: "") { (result, err) in
            guard let result = result else { return }
            resultCount = result.count
        }
        
        // then
        XCTAssertEqual(expectedResultCount, resultCount)
    }
    
    func testSearchWithEmptyKeywordMock() {
        // given
        let expectedResultCount = 3
        let expectedCallsCount = 4
        var resultCount = 0
        let mock = MockSearchUserRepository()
        sut = SearchUserUseCase(repository: mock)
        
        
        // when
        sut.searchUser(text: "") { (result, err) in
            guard let result = result else { return }
            
            resultCount = result.count
        }
        
        // then
        XCTAssertEqual(expectedResultCount, resultCount)
        XCTAssertEqual(expectedCallsCount, mock.searchUserCallsCount)
    }
    
}
