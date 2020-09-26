//
//  Job.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import SwiftyJSON

class Job {
    var title: String!
    var positions: Int!
    var image: String!
    var maxEarnings: Int!
    var date: String!
    
    required init (data: JSON) {
        title = data["title"].stringValue
        positions = data["open_positions"].intValue
        image = data["photo"].stringValue
        maxEarnings = data["max_possible_earnings_hour"].intValue
        date = data["date"]["date"].stringValue
    }
}
