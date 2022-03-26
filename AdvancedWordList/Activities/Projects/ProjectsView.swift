//
//  ProjectsView.swift
//  AdvancedWordList
//
//  Created by Anzhelika Sokolova on 18.10.2021.
//

import SwiftUI

struct ProjectsView: View {
    
    // let showClosedProjects: Bool
    // let projects: FetchRequest<Project>
    
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    //not need at all
    //   @EnvironmentObject var dataController: DataController
    //  @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    //  @State private var sortOrder = Item.SortOrder.optimized
    
    /*   init(showClosedProjects: Bool) { self.showClosedProjects = showClosedProjects
     projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [
     NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
     ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
     }    */
    
    var projectsList: some View {
        List {
            ForEach(viewModel.projects) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(items(for: project)) { item in
                        ItemRowView(item: item, project: project)
                    }
                    .onDelete { offsets in
                        // delete(offsets, from: project)
                        let allItems = items(for: project)
                        
                        for offset in offsets {
                            let item = allItems[offset]
                            viewModel.dataController.delete(item)
                        }
                        viewModel.dataController.save()
                    }
                    if viewModel.showClosedProjects == false {
                        Button {
                            withAnimation {
                                viewModel.addItem(to: project)
                            }
                        } label: {
                            Label("Add New Word", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.projects.isEmpty {
                    Text("There's nothing here right now.")
                        .foregroundColor(.secondary)
                } else {
                    projectsList
                }
            }
            .navigationTitle(viewModel.showClosedProjects ? "Closed Themes" : "Open Themes")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort words"), message: nil, buttons: [
                    .default(Text("Optimized")) { viewModel.sortOrder = .optimized },
                    .default(Text("Creation Date")) { viewModel.sortOrder = .creationDate },
                    .default(Text("Title")) { viewModel.sortOrder = .title }
                ])
            }
            SelectSomethingView()
        }
    }
    
    var addProjectToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.showClosedProjects == false {
                Button {
                    withAnimation {
                        viewModel.addProject()
                    }
                } label: {
                    if UIAccessibility.isVoiceOverRunning {
                        Text("Add Theme")
                    } else {
                        Label("Add Theme", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    var sortOrderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }
    
    /*   func addItem(to project: Project) {
     withAnimation {
     let item = Item(context: managedObjectContext)
     item.project = project
     item.creationDate = Date()
     dataController.save()
     }
     }
     
     func addProject() {
     withAnimation {
     let project = Project(context: managedObjectContext)
     project.closed = false
     project.creationDate = Date()
     dataController.save()
     }
     }    */
    
    func items(for project: Project) -> [Item] {
        switch viewModel.sortOrder {
        case .title:
            return project.projectItems.sorted { $0.itemTitle < $1.itemTitle }
        case .creationDate:
            return project.projectItems.sorted { $0.itemCreationDate < $1.itemCreationDate }
        case .optimized:
            return project.projectItemsDefaultSorted
        }
    }
    
    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController, showClosedProjects: showClosedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    // static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(dataController: DataController.preview, showClosedProjects: false)
        //        .environment(\.managedObjectContext, dataController.container.viewContext)
        //       .environmentObject(dataController)
    }
}
