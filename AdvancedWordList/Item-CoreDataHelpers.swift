//
//  Item-CoreDataHelpers.swift
//  AdvancedWordList
//
//  Created by Anzhellika Sokolova on 20.10.2021.
//

import Foundation

extension Item {
   
    var itemTitle: String {
        title ?? NSLocalizedString("New Word", comment: "Create a new word")
    }
 
    var itemDetail: String {
        detail ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        let item = Item(context: viewContext)
        item.title = "Example Word"
        item.detail = "This is an example word"
        item.priority = 3
        item.creationDate = Date()
        return item
    }
    enum SortOrder {
        case optimized, title, creationDate
    }
}
