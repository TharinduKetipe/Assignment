//
//  MockAPIClient.swift
//  TestApplicationTests
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
@testable import TestApplication

class MockApiClient {
    
    static let shared = MockApiClient()
    
    func getHTTPHeaders() -> HTTPHeaders? {
        return ["Content-Type" : "application/json",
        ]
    }
}

extension MockApiClient: APIClientProtocol {
    func jobs(interesets: String, distance: String, completion: @escaping (APIClient.APIResponseStatus, JSON?) -> Void) {
        let requsetString = Constants.mockUrl + distance
        let request = AF.request( requsetString,
                                  method: .get,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseData { response in
            switch response.result {
            case .success(_) :
                if let jsonData = response.data {
                    do {
                        let json = try JSON(data: jsonData)
                        completion(APIClient.APIResponseStatus.Success, json)
                    } catch {
                        completion(APIClient.APIResponseStatus.Failure, nil)
                    }
                } else {
                    completion(APIClient.APIResponseStatus.Failure, nil)
                }
            case .failure(_) :
                completion(APIClient.APIResponseStatus.Failure, nil)
            }
        }
    }
}
