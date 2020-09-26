//
//  APIClient.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIClient: NSObject {
    
    enum APIResponseStatus : Int {
        case Success = 200
        case Failure = -1
        case SuccessAlso = 201
        case ValidationError = 409
        case BadRequest = 400
        case UnAuthorized = 401
        case NotFound = 404
        case InternalServerError = 500
        case Other
    }
    
    static let shared = APIClient()
    
    func getHTTPHeaders() -> HTTPHeaders? {
        return ["Content-Type" : "application/json",
        ]
    }
}

extension APIClient: APIClientProtocol {
    func jobs(interesets:String, distance:String, completion:@escaping (APIResponseStatus, JSON?) -> Void) {
        let requsetString = Constants.baseUrl + APIRequestMetod.shifts + APIRequestKeys.interests + "=" + interesets + APIRequestKeys.distance + "=" + distance
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
                        completion(APIResponseStatus.Success, json)
                    } catch {
                        completion(APIResponseStatus.Failure, nil)
                    }
                } else {
                    completion(APIResponseStatus.Failure, nil)
                }
            case .failure(_) :
                completion(APIResponseStatus.Failure, nil)
            }
        }
    }
}
