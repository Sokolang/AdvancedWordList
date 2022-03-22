//
//  AwardTests.swift
//  AdvancedWordListTests
//
//  Created by Anzhellika Sokolova on 22.03.2022.
//

import CoreData
import XCTest
@testable import AdvancedWordList

class AwardTests: BaseTestCase {
    
    let awards = Award.allAwards
    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }
    func testNoAwards() throws { for award in awards {
        XCTAssertFalse(dataController.hasEarned(award: award), "New users should have no awards.")
    }
    }
    
    func testItemAwards() throws {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        for (count, value) in values.enumerated() {
            var items = [Item]()
            
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                items.append(item)
            }
            
            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }
            
            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1) awards.")
            
            for item in items {
                dataController.delete(item)
            }
        }
    }
}
