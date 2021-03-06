//
//  Project-CoreDataHelpers.swift
//  AdvancedWordList
//
//  Created by Anzhelika Sokolova on 20.10.2021.
//

import SwiftUI

extension Project {
    var label: LocalizedStringKey {
        LocalizedStringKey("\(projectTitle), \(projectItems.count) words, \(completionAmount * 100, specifier: "%g")% complete")
    }

    var projectTitle: String {
        title ?? NSLocalizedString("New Theme", comment: "Create a new theme")
    }
    
    var projectDetail: String {
        detail ?? ""
    }
    
    var projectColor: String {
        color ?? "Light Blue"
    }
    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }
    
    var projectItemsDefaultSorted: [Item] {
        projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            
            return first.itemCreationDate < second.itemCreationDate
        }
    }


    
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
    
    static var example: Project {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let project = Project(context: viewContext)
            project.title = "Example Theme"
            project.detail = "This is an example theme"
            project.closed = true
            project.creationDate = Date()
        return project
    }
    
    
    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal", "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]

}
