//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Atokarxd on 2022. 07. 26..
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
