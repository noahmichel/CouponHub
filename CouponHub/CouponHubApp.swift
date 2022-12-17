//
//  CouponHubApp.swift
//  CouponHub
//
//  Created by Noah Michel on 12/17/22.
//

import SwiftUI

@main
struct CouponHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
