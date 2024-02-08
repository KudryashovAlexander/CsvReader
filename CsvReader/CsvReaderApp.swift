//
//  CsvReaderApp.swift
//  CsvReader
//
//  Created by Александр Кудряшов on 08.02.2024.
//

import SwiftUI

@main
struct CsvReaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
