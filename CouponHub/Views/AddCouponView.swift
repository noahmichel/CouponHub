//
//  AddCoupon.swift
//  CouponHub
//
//  Created by Noah Michel on 12/21/22.
//

import SwiftUI
import CloudKit
import UIKit
import RealmSwift

struct AddCouponView: View {
    
    @ObservedRealmObject var couponList: CouponList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var newCompany = ""
    @State var newDiscountCode = ""
    @State var newDescription = ""
    @State var newDate = Date()
    
    var birthDateTxt = ViewController()
    @State var changeImage = false
    @State var openCameraRoll = false
    @State var selectedImage = UIImage()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var imageUploaded = false
    
    var body: some View {
        VStack {
            List {
                header
                companyTextField
                discountTextField
                descriptionTextField
                datePicker
//                photoPickerTitle
//                HStack (spacing: 40) {
//                    VStack {
//                        ZStack {
//                            photoPickerCamera
//                        }.sheet(isPresented: $openCameraRoll) {
//                            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
//                        }
//                        photoPickerSubTitleCamera
//                    }
//                    VStack {
//                        ZStack {
//                            photoPickerPhotos
//                        }.sheet(isPresented: $openCameraRoll) {
//                            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
//                        }
//                        photoPickerSubTitlePhotos
//                    }
//                }
            }
            Spacer()
            if newCompany.isEmpty || newDiscountCode.isEmpty || newDescription.isEmpty || newDate.description.isEmpty {
                addCouponButton.disabled(true)
            } else {
                addCouponButton.disabled(false)
            }
        }
//        .navigationBarHidden(true)
//        .navigationBarItems(leading: backBarButtonItem)
    }
}

extension AddCouponView {
    
    private var header : some View {
        Text("New Coupon Details")
            .padding(.horizontal, 35.0)
            .frame(width: 400, height: 60)
            .font(.system(size: 500))
            .fontWeight(.light)
            .minimumScaleFactor(0.01)
            .cornerRadius(0)
    }
    
    private var addCouponButton : some View {
        Button {
            if let newCouponList = couponList.thaw(),
               let realm = newCouponList.realm {
                
                try? realm.write {
                    newCouponList.couponList.append(Coupon(_id: ObjectId.generate(), company: newCompany, discountCode: newDiscountCode, couponDescription: newDescription, date: newDate))
                }
                self.presentationMode.wrappedValue.dismiss()
            }

        } label: {
            Text("Save Coupon")
                .font(.system(size: 32))
                .font(.headline)
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
    }
    
    private var companyTextField : some View {
        TextField("Company", text: $newCompany)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
    }
    
    private var discountTextField : some View {
        TextField("Discount Code", text: $newDiscountCode)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
    }
    
    private var descriptionTextField : some View {
        TextField("Discount Description", text: $newDescription, axis: .vertical)
            .frame(height: 100, alignment: .top)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
    }
    
    private var datePicker : some View {
        DatePicker("Expiration Date", selection: $newDate, in: Date()..., displayedComponents: .date)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .fontWeight(.medium)
            .font(.system(size: 20))
    }
    
    private var photoPickerTitle : some View {
        Text("Upload Coupon Image")
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .fontWeight(.bold)
            .font(.system(size: 20))
    }
    
    private var photoPickerPhotos : some View {
    
        Button (action: {
            sourceType = UIImagePickerController.SourceType.photoLibrary
            changeImage = true
            openCameraRoll = true
            imageUploaded = true
                
            }, label: {
                if changeImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width:150, height: 100)
        
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width:150, height: 100)
                        .font(.system(size: 150))
                        .fontWeight(.light)
                        .foregroundColor(Color.blue.opacity(0.8))
                }
            })
        }
    
    private var photoPickerCamera : some View {
        
        Button (action: {
            sourceType = UIImagePickerController.SourceType.camera
            changeImage = true
            openCameraRoll = true
            imageUploaded = true
                
            }, label: {
                if changeImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width:150, height: 100)
        
                } else {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width:150, height: 100)
                        .font(.system(size: 150))
                        .fontWeight(.light)
                        .foregroundColor(Color.blue.opacity(0.8))
                }
            })
    }
    
    private var finalCouponPhoto : some View {
    
        Button (action: {
            sourceType = UIImagePickerController.SourceType.photoLibrary
            changeImage = true
            openCameraRoll = true
            imageUploaded = true
                
            }, label: {
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width:250, height: 150)
            })
        }
    
    private var photoPickerSubTitleCamera : some View {
        Text("Take photo")
            .fontWeight(.light)
            .font(.system(size: 20))
            .frame(width:150, height: 50)
    }
    
    private var photoPickerSubTitlePhotos : some View {
        Text("Choose from Camera Roll")
            .fontWeight(.light)
            .font(.system(size: 20))
            .frame(width:150, height: 50)
            
    }
}


struct AddCoupon_Previews: PreviewProvider {
    static var previews: some View {
        let realm = realmWithData()
        AddCouponView(couponList: realm.objects(CouponList.self).first!)
    }
}
