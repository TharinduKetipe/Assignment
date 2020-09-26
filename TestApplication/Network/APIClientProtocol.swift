//
//  APIClientProtocol.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIClientProtocol {
    
    func jobs(interesets:String, distance:String, completion:@escaping (APIClient.APIResponseStatus, JSON?) -> Void)
}
