//
//  PortfolioAppApp.swift
//  PortfolioApp
//
//  Created by Andrew Kemper on 3/23/22.
//

import SwiftUI

@main
struct PortfolioAppApp: App {
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
