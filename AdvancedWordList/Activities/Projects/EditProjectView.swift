//
//  EditProjectView.swift
//  AdvancedWordList
//
//  Created by Anzhelika Sokolova on 28.10.2021.
//

import SwiftUI

struct EditProjectView: View {
    
    let project: Project
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var showingDeleteConfirm = false
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]
    
    init(project: Project) {
          self.project = project
          _title = State(wrappedValue: project.projectTitle)
          _detail = State(wrappedValue: project.projectDetail)
          _color = State(wrappedValue: project.projectColor)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Theme name", text: $title)
                TextField("Description of this theme", text: $detail)
            }
           
            Section(header: Text("Custom theme color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self, content: colorButton)
                }
                .padding(.vertical)
            }
            Section(footer: Text("Closing a theme moves it from the Open to Closed tab; deleting it removes the theme entirely.")) {
                Button(project.closed ? "Reopen this theme" : "Close this theme") {
                    project.closed.toggle()
                    update()
                }

                Button("Delete this theme") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
                
             }
        }
        .navigationTitle("Edit Theme")
        .onDisappear(perform: dataController.save)
        .onChange(of: title) {_ in update() }
        .onChange(of: detail) {_ in update() }
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete theme?"), message: Text("Are you sure you want to delete the theme?"), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
        
    }
    
    func update() {
        project.title = title
        project.detail = detail
        project.color = color
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
    
    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(6)
            if item == color {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            color = item
            update()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(
            item == color
                ? [.isButton, .isSelected]
                : .isButton
        )
        .accessibilityLabel(LocalizedStringKey(item))    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
