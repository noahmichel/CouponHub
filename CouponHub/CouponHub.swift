//
//  CouponHub.swift
//  CouponHub
//
//  Created by Noah Michel on 12/17/22.
//

import SwiftUI

@main
struct CouponHub: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            iCloudUserInfoView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
