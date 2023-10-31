//
//  TestRestApi.swift
//  Rick&MortyTests
//
//  Created by Adrian Lage Gil on 31/10/23.
//

import XCTest
@testable import Rick_Morty

final class TestRestApi: XCTestCase {
    
    var apiRest: RestApi!

    override func setUpWithError() throws {
        apiRest = RestApi()
    }

    override func tearDownWithError() throws {
        apiRest = nil
    }

    func testApiRestNotNil() throws {
        XCTAssertNotNil(apiRest)
    }
    
    func testApiRestCheckBaseUrl() throws {
        XCTAssertEqual(apiRest?.baseUrl, "https://rickandmortyapi.com/api/")
    }
    
    func testApiRestTimeoutIntervalForRequest() throws {
        XCTAssertEqual(RestApi.shared.manager.session.configuration.timeoutIntervalForRequest, 30)
    }
    
    func testApiRestTimeoutIntervalForResource() throws {
        XCTAssertEqual(RestApi.shared.manager.session.configuration.timeoutIntervalForResource, 30)
    }
    
    func testCorrectUrlRequest() throws {
        let urlRequest = "https://rickandmortyapi.com/api/location"
        let response = apiRest.manager.request(url: urlRequest)
        XCTAssertEqual(urlRequest, response.convertible.urlRequest?.url?.absoluteString)
    }
    
    func testCorrectHeadersRequest() throws {
        let headers = MockTest().createHeaders()
        let response = apiRest.manager.request(url: "https://rickandmortyapi.com/api/location")
        XCTAssertEqual(headers.description, response.convertible.urlRequest?.headers.description)
    }
    
    func testCorrectMethodRequest() throws {
        let method = MockTest().getMethod
        let response = apiRest.manager.request(url: "https://rickandmortyapi.com/api/location")
        XCTAssertEqual(method, response.convertible.urlRequest?.method)
    }
    
}
