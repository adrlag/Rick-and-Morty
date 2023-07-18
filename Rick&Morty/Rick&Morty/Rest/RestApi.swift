//
//  RestApi.swift
//  DOGMOB
//
//  Created by Adrián Lage on 23/3/23.
//

import Alamofire
import ObjectMapper

let baseUrl = "https://rickandmortyapi.com/api/"

open class RestApi {
    
    public static var Manager: Alamofire.Session = {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30

        let manager = Alamofire.Session(configuration: configuration)
        
        return manager
    }()

    static func getRequestAF(endPoint: String, success: (@escaping (AFDataResponse<Any>) -> Void), failure: (@escaping (AFError) -> Void)) {
        
        let headers = HTTPHeaders([
            "Accept": "*/*",
            "Content-Type": "application/json"
        ])
        
        let url = "\(baseUrl)\(endPoint)"
        
        
        Manager.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                success(response)
                print("*** SUCCESS DEL SERVICIO: \(url)")
            case .failure(let error):
                failure(error)
                print("*** ERROR: \(error)")
            }
            
        })
    }
    
}
