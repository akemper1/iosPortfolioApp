//
//  ProjectsView.swift
//  PortfolioApp
//
//  Created by Andrew Kemper on 3/24/22.
//

import SwiftUI

struct ProjectsView: View {
    let showClosedProjects: Bool
    
    let projects: FetchRequest<Project>
    
    init(showCloseProjects: Bool) {
        self.showClosedProjects = showCloseProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath:\Project.creationDate,ascending:false)], predicate: NSPredicate(format: "closed = %d", showCloseProjects))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: Text(project.title ?? "")) {
                        ForEach(project.items?.allObjects as? [Item] ?? []) { item in Text(item.title ?? "")}
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed projects" : "Open Projects")
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showCloseProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}