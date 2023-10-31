//
//  MockTest.swift
//  Rick&MortyTests
//
//  Created by Adrian Lage Gil on 31/10/23.
//

import Foundation
import Alamofire

class MockTest {
    
    var getMethod = HTTPMethod.get
    
    func createHeaders() -> HTTPHeaders {
        let headers = HTTPHeaders([
            "Accept": "*/*",
            "Content-Type": "application/json"
        ])
        return headers
    }

}
