//
//  AdvancedWordListTests.swift
//  AdvancedWordListTests
//
//  Created by Anzhellika Sokolova on 22.03.2022.
//

import CoreData
import XCTest

@testable
import AdvancedWordList

class BaseTestCase: XCTestCase {
    
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
