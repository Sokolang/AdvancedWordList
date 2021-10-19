//
//  HomeView.swift
//  AdvancedWordList
//
//  Created by Anzhellika Sokolova on 18.10.2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData() }
                }
                .navigationTitle("Home")
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

