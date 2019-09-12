//
//  AequilibriumTests.swift
//  AequilibriumTests
//
//  Created by CtanLI on 2019-09-10.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import XCTest
@testable import Aequilibrium

class AequilibriumTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTransformersViewModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let transformersModel  = Transformers(id: "", name: "Optimus prime", strength: 2, intelligence: 5, speed: 6, endurance: 3, rank: 8, courage: 4, firepower: 9, skill: 1, team: "D", team_icon: "")
        let transformersViewModel = TransformerViewModel(tvm: transformersModel)
        
        XCTAssertEqual(transformersModel.id, transformersViewModel.tvm.id)
    }
}
