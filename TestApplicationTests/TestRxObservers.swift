//
//  TestRxObservers.swift
//  TestApplicationTests
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import Nimble
import RxSwift
import RxBlocking
import RxTest
import SwiftyJSON
import XCTest
@testable import TestApplication

class TestRxObservers: XCTestCase {
    
    var viewModel: HomeViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
      super.tearDown()
    }
    
    func testTableDataObserver() {
        
        let validDataPathOne = Bundle(for: type(of: self)).path(forResource: "Job01", ofType: "json")!
        let jobOneJson = JSON(NSData(contentsOfFile: validDataPathOne)! as Data)
        let validDataPathTwo = Bundle(for: type(of: self)).path(forResource: "Job02", ofType: "json")!
        let jobTwoJson = JSON(NSData(contentsOfFile: validDataPathTwo)! as Data)
        let validDataPathThree = Bundle(for: type(of: self)).path(forResource: "Job03", ofType: "json")!
        let jobThreeJson = JSON(NSData(contentsOfFile: validDataPathThree)! as Data)
        
        
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver([Job].self)
        
        scheduler.scheduleAt(100) {
            self.viewModel.jobs.accept([Job(data: jobOneJson)])
            self.viewModel.jobs.asObservable()
                .subscribe(observer)
                .disposed(by: self.disposeBag)
        }
        
        scheduler.scheduleAt(200) {
            self.viewModel.jobs.accept([Job(data: jobTwoJson)])
        }
        
        scheduler.scheduleAt(300) {
            self.viewModel.jobs.accept([Job(data: jobThreeJson)])
        }
        
        scheduler.start()
        
        let expectedEvents = [
            Recorded.next(100, [Job(data: jobOneJson)]),
            Recorded.next(200, [Job(data: jobTwoJson)]),
            Recorded.next(300, [Job(data: jobThreeJson)])
        ]
        expect(observer.events.count).to(equal(expectedEvents.count), description: "Verify tableData observer is success")
    }
    
    func testCollectionDataObserver() {
        
        let datesOne = [ "2019-10-13", "2019-10-18", "2019-10-04", "2019-09-11", "2019-10-16"]
        let datesTwo = [ "2019-09-08", "2019-09-22", "2019-09-15", "2019-09-27", "2019-09-09"]
        let datesThree = ["2019-11-04", "2019-09-29", "2019-10-31", "2019-11-01", "2019-11-02"]
        
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver([String].self)
        
        scheduler.scheduleAt(100) {
            self.viewModel.dates.accept(datesOne)
            self.viewModel.dates.asObservable()
                .subscribe(observer)
                .disposed(by: self.disposeBag)
        }
        
        scheduler.scheduleAt(200) {
            self.viewModel.dates.accept(datesTwo)
        }
        
        scheduler.scheduleAt(300) {
            self.viewModel.dates.accept(datesThree)
        }
        
        scheduler.start()
        
        let expectedEvents = [
            Recorded.next(100, datesOne),
            Recorded.next(200, datesTwo),
            Recorded.next(300, datesThree)
        ]
        expect(observer.events).to(equal(expectedEvents), description: "Verify collectionData observer is success")
    }
}
