//
//  TestApplicationTests.swift
//  TestApplicationTests
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import Mockingjay
import Nimble
import XCTest
@testable import TestApplication

class TestApplicationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        self.startStubs()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetMockJobsResponseForData() {
        var dataMap = [String:[Job]]()
        MockApiClient.shared.jobs(interesets: "", distance: "data") { (status, response) in
            
            expect(status).to(equal(APIClient.APIResponseStatus.Success), description: "Verify Get Jobs Response Status Succuss")
            expect(response).notTo(beNil(), description: "Verify Get Jobs Response is not nil")
            if (response != nil) {
                let viewModel = HomeViewModel()
                dataMap = viewModel.mapingData(data: response!)
                expect(dataMap.count).notTo(equal(0), description: "Verify Get Jobs Response data mapping succuess")
            }
        }
        expect(dataMap.count).toNotEventually(equal(0),timeout: 10.0, description: "Verify Get Jobs Valid Response data mapping pass")
    }

    func testGetMockJobsResponseForNotFound() {
        var resStatus: APIClient.APIResponseStatus!
        MockApiClient.shared.jobs(interesets: "", distance: "notfound") { (status, response) in
            expect(status).to(equal(APIClient.APIResponseStatus.Failure), description: "Verify Get Jobs Response Status Failure")
            resStatus = status
        }
        expect(resStatus).toEventually(equal(APIClient.APIResponseStatus.Failure), timeout: 10.0, description: "Verify Get Jobs NotFound Response  pass")
    }
    
    func testGetRealJobsResponse() {
        var dataMap = [String:[Job]]()
        APIClient.shared.jobs(interesets: "5", distance: "%7B%22range%22:50,%22geolocation%22:%7B%22lat%22:%2252.360537%22,%22lng%22:%224.993292%22%7D%7D") { (status, response) in
            
            expect(status).to(equal(APIClient.APIResponseStatus.Success), description: "Verify Real Get Jobs Response Status Succuss")
            expect(response).notTo(beNil(), description: "Verify Real Get Jobs Response is not nil")
            
            let viewModel = HomeViewModel()
            dataMap = viewModel.mapingData(data: response!)
            expect(dataMap.count).notTo(equal(0), description: "Verify Real Get Jobs Response data mapping succuess")
        }
        expect(dataMap.count).toNotEventually(equal(0),timeout: 10.0,description: "Verify Get Real Jobs Response data mapping pass")
    }
    
    func testImageDownload() {
        let url = "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/109775.jpg"
        let imgView = UIImageView()
        ImageDownloader.shared.loadImage(url: url, imageView: imgView)
        expect(imgView.image).toNotEventually(beNil(), timeout: 10.0, description: "Verify Image Download Pass")
    }
}
