//
//  CouponHub.swift
//  CouponHub
//
//  Created by Noah Michel on 12/17/22.
//

import SwiftUI
import RealmSwift

@main
struct CouponHub: SwiftUI.App {
    let persistenceController = PersistenceController.shared
    @ObservedResults(CouponList.self) var couponList

    var body: some Scene {
        WindowGroup {
            if couponList.first != nil {
                HomeView(couponList: couponList.first!)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                ProgressView()
                    .onAppear {
                        $couponList.append(CouponList())
                    }
            }
        }
    }
}
