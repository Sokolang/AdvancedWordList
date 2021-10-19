//
//  AdvancedWordListApp.swift
//  AdvancedWordList
//
//  Created by Anzhellika Sokolova on 17.10.2021.
//

import SwiftUI

@main
struct AdvancedWordListApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
