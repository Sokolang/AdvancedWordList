//
//  DevelopmentTests.swift
//  AdvancedWordListTests
//
//  Created by Anzhellika Sokolova on 22.03.2022.
//

import CoreData
import XCTest
@testable import AdvancedWordList

class DevelopmentTests: BaseTestCase {
    
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "There should be 5 sample projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50, "There should be 50 items.")
        
    }
    
    func testDeleteAllClearsEverything() throws {
        try dataController.createSampleData()
        dataController.deleteAll()
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "deleteAll() should leave 0 projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "deleteAll() should leave 0 items.")
        
    }
    
    
}
