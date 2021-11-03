//
//  ItemRowView.swift
//  AdvancedWordList
//
//  Created by Anzhellika Sokolova on 22.10.2021.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var item: Item
    @ObservedObject var project: Project

    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle") .foregroundColor(Color(project.projectColor))
        } else if item.priority == 3 {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(project.projectColor))
        } else {
            return Image(systemName: "checkmark.circle") .foregroundColor(.clear)
        }
    }
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Label {
                Text(item.itemTitle)
            } icon: {
                icon }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item.example, project: Project.example)
    }
}

