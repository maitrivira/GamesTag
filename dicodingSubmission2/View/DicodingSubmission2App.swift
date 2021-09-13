//
//  dicodingSubmission2App.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

 @main
struct DicodingSubmission2App: App {
    let persistenceController = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
