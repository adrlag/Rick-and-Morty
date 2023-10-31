//
//  TestLocationsDetailVM.swift
//  Rick&MortyTests
//
//  Created by Adrian Lage Gil on 31/10/23.
//

import XCTest
@testable import Rick_Morty

final class TestLocationsDetailVM: XCTestCase {
    
    var locDetailVM: LocationDetailVM!

    override func setUpWithError() throws {
        locDetailVM = LocationDetailVM()
        locDetailVM.api = RestApi.shared
    }

    override func tearDownWithError() throws {
        locDetailVM = nil
    }

    func testMockNotNil() {
        XCTAssertNotNil(locDetailVM)
    }

    func testEmptyLocations() {
        XCTAssertNil(locDetailVM.location)
    }

    func testSuccesGetLocationDetail() {
        let promise = expectation(description: "Finished")

        locDetailVM.getLocation(locID: 1, succeed: { response in
            XCTAssertNotNil(response)
            promise.fulfill()
        }, failure: { _ in })
        
        wait(for: [promise], timeout: 5.0)
    }

    func testFailureGetLocationDetail() {
        let promise = expectation(description: "Finished")

        locDetailVM.getLocation(locID: 0, succeed: { _ in
            
        }, failure: { error in
            XCTAssertNotNil(error)
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5.0)
    }
    
    func testFailureGetLocationDetail2() {
        let promise = expectation(description: "Finished")

        locDetailVM.getLocation(locID: -1, succeed: { _ in
            
        }, failure: { error in
            XCTAssertNotNil(error)
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5.0)
    }
    
}
