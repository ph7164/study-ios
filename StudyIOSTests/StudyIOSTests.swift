//
//  StudyIOSTests.swift
//  StudyIOSTests
//
//  Created by 홍필화 on 2021/11/15.
//

import XCTest
@testable import StudyIOS

class StudyIOSTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
}

extension StudyIOSTests {
    func testSearchWithEmptyKeyword_thenEmptyResult() {
        // given
        let expectedResultCount = 0
        let expectedWasCalled = ""
        
        // when
        sut.search(keyword: expectedKeyword)
        
        // then
        XCTAssertEqual(expectedKeyword, sut.keyword)
        XCTAssertEqual(expectedResultCount, sut.result.count)
    }
    
    func testSearchWithUserName() {
        // given
        let expectedKeyword = "swift"
        let expectedResultCount = 5
        
        // when
        sut.search(keyword: expectedKeyword)
        
        // then
        XCTAssertEqual(expectedKeyword, sut.keyword)
        XCTAssertEqual(expectedResultCount, sut.result.count)
    }
    
    func testSearchWithUserName_thenUnexpectedError() {
        // given
        /// TBD
        
        // when
        /// TBD
        
        // then
        /// TBD
    }
}
