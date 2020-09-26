//
//  HomeVIewModel.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa
import MKProgress

class HomeViewModel: NSObject {
    
    public enum RequestError {
        case dataError(String)
        case otherError(String)
    }
    
    var dataMap = [String:[Job]]()
    var jobs: BehaviorRelay<[Job]> =  BehaviorRelay(value: [])
    var dates: BehaviorRelay<[String]> =  BehaviorRelay(value: [])
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<RequestError> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    func fetchData() {
        MKProgress.show()
        self.loading.onNext(true)
        APIClient.shared.jobs(interesets: "5", distance: "%7B%22range%22:50,%22geolocation%22:%7B%22lat%22:%2252.360537%22,%22lng%22:%224.993292%22%7D%7D") { (status, response) in
            self.loading.onNext(false)
            MKProgress.hide()
            if status == APIClient.APIResponseStatus.Success {
                if response!.count > 0 {
                    self.initViewModel(response: response!)
                } else {
                    self.error.onNext(.dataError("There is no data at the moment!"))
                }
            } else {
                self.error.onNext(.dataError("Error loding data!"))
            }
        }
    }
   
    func initViewModel(response:JSON){
        dataMap = mapingData(data: response)
        let jobDates = Array(dataMap.keys)
        dates.accept(jobDates.sorted())
        
        if let date = dates.value.first {
            let newData = dataMap[date]
            jobs.accept(newData!)
        }
    }
    
    func mapingData(data:JSON) -> [String:[Job]]{
        var mappedData = [String:[Job]]()
        if  data["data"] != JSON.null {
            for (key, subJson) in (data["data"].dictionary)! {
                var openings = [Job]()
                for (_, object) in subJson {
                    openings.append(Job(data: object))
                }
                if openings.count > 0 {
                    mappedData.updateValue(openings, forKey: key)
                }
            }
        }
        return mappedData
    }
}
