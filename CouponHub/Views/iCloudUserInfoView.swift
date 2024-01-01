//
//  iCloudUserInfo.swift
//  CouponHub
//
//  Created by Noah Michel on 12/18/22.
//

import Foundation
import SwiftUI
import CloudKit

class iCloudUserInfoViewModel: ObservableObject {

    @Published var iCloudFlag: Bool = false
    @Published var error: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var permissionStatus: Bool = false
    @Published var homeAccess: Bool = false

    init() {
        getiCloudStatus()
        requestiCloudUserInfoAccess()
        fetchiCloudUserID()
    }

    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] CKAccountStatus, CKAccountError in
            DispatchQueue.main.async {
                switch CKAccountStatus {
                case .available:
                    self?.iCloudFlag = true
                case .couldNotDetermine:
                    self?.error = iCloudError.iCloudAccountNotDetermined.rawValue
                case .noAccount:
                    self?.error = iCloudError.iCloudAccountNotFound.rawValue
                case .restricted:
                    self?.error = iCloudError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = iCloudError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    private func requestiCloudUserInfoAccess() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    private func fetchiCloudUserID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.fetchiCloudUserInfo(id: id)
            }
        }
    }
    
    private func fetchiCloudUserInfo(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.firstName = name
                }
                if let name = returnedIdentity?.nameComponents?.familyName {
                    self?.lastName = name
                }
                if !id.description.isEmpty {
//                    self?.error = "name found"
                    self?.homeAccess = true
                    
                }
            }
        }
    }

    enum iCloudError: String, LocalizedError {
        case iCloudAccountNotFound = "iCloud Account Not Found"
        case iCloudAccountNotDetermined = "iCloud Account Could not be determined"
        case iCloudAccountRestricted = "iCloud Accound is currently restricted"
        case iCloudAccountUnknown = "iCloud Accound is unknown"
    }

}

struct iCloudUserInfoView: View {
    
    @StateObject var vm = iCloudUserInfoViewModel()

    var body: some View {
        
        if !vm.homeAccess {
            VStack {
                Text("Is the icloud user found? \(vm.iCloudFlag.description)")
                Text("\(vm.error)")
                Text("Permission ?: \(vm.permissionStatus.description)")
                Text("Welcome: \(vm.firstName) \(vm.lastName)")
            }
        } else {
            HomeView(couponList: CouponList())
        }
    }
}

struct iCloudUserInfo_Previews: PreviewProvider {
    static var previews: some View {
        iCloudUserInfoView()
    }
}

