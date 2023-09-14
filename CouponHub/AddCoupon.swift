//
//  AddCoupon.swift
//  CouponHub
//
//  Created by Noah Michel on 12/21/22.
//

import SwiftUI
import CloudKit
import UIKit

class AddCouponViewModel : ObservableObject {
    
    @Published var company : String = ""
    @Published var discountCode : String = ""
    @Published var couponDescription : String = ""
    @Published var expirationDate : Date = Date()
    @Published var couponImage : Image = Image(systemName: "photo")
    
    func saveCoupon() {
        
    }
    
}

struct AddCoupon: View {
    
    var birthDateTxt = ViewController()
    @StateObject var userInfoVM : iCloudUserInfoViewModel
    @StateObject var addCouponVM = AddCouponViewModel()
    
    @State var changeImage = false
    @State var openCameraRoll = false
    @State var selectedImage = UIImage()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var imageUploaded = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                //safeAreaTop
                header
                companyTextField
                discountTextField
                descriptionTextField
                datePicker
                photoPickerTitle
                    HStack (spacing: 40) {
                        VStack {
                            ZStack {
                                photoPickerCamera
                            }.sheet(isPresented: $openCameraRoll) {
                                ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
                            }
                            photoPickerSubTitleCamera
                        }
                        VStack {
                            ZStack {
                                photoPickerPhotos
                            }.sheet(isPresented: $openCameraRoll) {
                                ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
                            }
                            photoPickerSubTitlePhotos
                        }
                }
                Spacer()
                addCouponButton
                    
            }
        }.navigationBarHidden(true)
    }
}

extension AddCoupon {
    
    private var header : some View {
//        Text("\(userInfoVM.firstName) \(userInfoVM.lastName)'s Coupon Hub")
        Text("New Coupon Details")
            .padding(.horizontal, 35.0)
            .frame(width: 400, height: 60)
            .font(.system(size: 500))
            .fontWeight(.light)
            .minimumScaleFactor(0.01)
            .cornerRadius(0)
    }
    
    private var safeAreaTop : some View {
        LinearGradient(colors: [.white], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.top).opacity(0.6).frame(maxWidth: .infinity, maxHeight: 0)
    }
    
    private var addCouponButton : some View {
        Button {
//            saveCoupon()
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
        TextField("Company", text: $addCouponVM.company)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    private var discountTextField : some View {
        TextField("Discount Code", text: $addCouponVM.discountCode)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    private var descriptionTextField : some View {
        TextField("Discount Description", text: $addCouponVM.couponDescription, axis: .vertical)
            .frame(height: 100, alignment: .top)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    private var datePicker : some View {
        DatePicker("Expiration Date", selection: $addCouponVM.expirationDate, in: Date()..., displayedComponents: .date)
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
        AddCoupon(userInfoVM: iCloudUserInfoViewModel())
    }
}