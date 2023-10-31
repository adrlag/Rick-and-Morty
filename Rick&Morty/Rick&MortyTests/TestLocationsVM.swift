//
//  TestLocationsVM.swift
//  Rick&MortyTests
//
//  Created by Adrian Lage Gil on 31/10/23.
//

import XCTest
@testable import Rick_Morty

final class TestLocationsVM: XCTestCase {
    
    var locVM: LocationsVM!

    override func setUpWithError() throws {
        locVM = LocationsVM()
        locVM.api = RestApi.shared
    }

    override func tearDownWithError() throws {
        locVM = nil
    }

    func testMockNotNil() {
        XCTAssertNotNil(locVM)
    }

    func testEmptyLocations() {
        XCTAssertTrue(locVM.locations.isEmpty)
    }

    func testSuccesGetLocations() {
        let promise = expectation(description: "Finished")

        locVM.getLocations { response in
            XCTAssertFalse(response.isEmpty)
            promise.fulfill()
        } failure: { _ in }

        wait(for: [promise], timeout: 5.0)
    }

    func testAddPageToNextGet() {
        let altualPage = locVM.page
        let promise = expectation(description: "Finished")

        locVM.getLocations { [self] response in
            XCTAssertNotEqual(altualPage, locVM.page)
            XCTAssertEqual(locVM.page, (altualPage + 1))
            promise.fulfill()
        } failure: { _ in }

        wait(for: [promise], timeout: 5.0)
    }

    func testSetFiltersLocations() {
        let actualFilters = locVM.filters
        let promise = expectation(description: "Finished")

        locVM.filters = "some_filters"

        locVM.getLocations { [self] response in
            XCTAssertNotEqual(actualFilters, locVM.filters)
            promise.fulfill()
        } failure: { _ in }

        wait(for: [promise], timeout: 5.0)
    }

}
