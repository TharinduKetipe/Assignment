//
//  Utilities.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Utilities: NSObject {
    
    enum SwipeDirection :String{
        case leftSwipe
        case rightSwipe
    }
    
    class func AlertWithOkAction(view:UIViewController, title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
    
}

