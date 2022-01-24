//
//  NavigationView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation
import SwiftUI

struct CreateNewTeamView: View {
    
    @State private var image: Image? = Image(systemName: "photo")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State private var name: String = ""
    
    let url = URL(string: "https://images.unsplash.com/photo-1554773228-1f38662139db")!
    
    var viewModel: CreateNewTeamViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
//            
//           URLSession.shared
//                .downloadTaskPublisher(for: url)
//                .map { UIImage(contentsOfFile: $0.url.path)! }
//                .replaceError(with: UIImage(named: "fallback"))
//                .receive(on: DispatchQueue.main)
//                .assign(to: \.image, on: self.imageView)
//
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            

//
//            image?
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 200, height: 200)
//            //            .clipShape(Circle())
//            //            .overlay(Circle().stroke(Color.white, lineWidth: 4))
//                .padding()
//                .shadow(radius: 10)
//                .foregroundColor(.gray)
//                .onTapGesture { self.shouldPresentActionScheet = true }
//                .sheet(isPresented: $shouldPresentImagePicker) {
//                    ImagePicker(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
//                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
//                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
//                        self.shouldPresentImagePicker = true
//                        self.shouldPresentCamera = true
//                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
//                        self.shouldPresentImagePicker = true
//                        self.shouldPresentCamera = false
//                    }), ActionSheet.Button.cancel()])
//                }
        
            //                Spacer()
            HStack(alignment: .center){
                TextField("Enter Team Name", text: $name)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color.secondary)
                    )
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
            }.padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
            
            Button(action: {
                viewModel.createTeam(name: name)
//                let uiImage: UIImage = (self.image?.asUIImage())!
//                let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
//                let imageStr: String = imageData.base64EncodedString()
//                guard let url: URL = URL(string: <#T##String#>)
            }) {
                Text("Create")
                    .padding()
            }
            Spacer()
        }
        .navigationBarTitle("Create New Team", displayMode: .inline)
    }
    
}

struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewTeamView(viewModel: CreateNewTeamViewModel())
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

// MARK: - NavTabView
//struct NavTabView: View {
//
//    let screenWidth = UIScreen.main.bounds.width
//
//    @State private var image = UIImage()
//    @State private var showSheet = false
//
//    var body: some View {
//        VStack {
//            Image(uiImage: self.image)
//                .resizable()
//                .cornerRadius(50)
//                .frame(width: screenWidth * 0.12, height: screenWidth * 0.12, alignment: .center)
//                .background(Color.black.opacity(0.2))
//                .aspectRatio(contentMode: .fill)
//                .clipShape(Circle())
//
//            Text("Change photo")
//                .font(.headline)
//                .frame(maxWidth: .infinity)
//                .frame(height: 50)
//                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
//                .cornerRadius(16)
//                .foregroundColor(.white)
//                .padding(.horizontal, 20)
//                .onTapGesture {
//                    showSheet = true
//                }
//        }
//        .padding(.horizontal, 20)
//        .sheet(isPresented: $showSheet) {
//            // Pick an image from the photo library:
//            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
//
//            //  If you wish to take a photo from camera instead:
//            // ImagePicker(sourceType: .camera, selectedImage: self.$image)
//        }
//
//    }
//
        
    
    
    
    
    
    
    
    
    
    
//    @State var name: String = ""
//
//    struct BGView: View {
//        var body: some View {
//            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6996605992, green: 0.2329967618, blue: 0.4832239747, alpha: 1)), Color(#colorLiteral(red: 0.231372549, green: 0.09411764706, blue: 0.3725490196, alpha: 1))]), startPoint: .top, endPoint: .center)
//                .ignoresSafeArea()
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Enter New Team Name", text: $name)
//                    .padding()
//                    .foregroundColor(.white)
//                TextField("Enter New Team Name", text: $name)
//                    .padding()
//                    .foregroundColor(.white)
//                TextField("Enter New Team Name", text: $name)
//                    .padding()
//                    .foregroundColor(.white)
//
//            }
//            .navigationBarTitle("Create New Team", displayMode: .inline)
//        }
//        .background(BGView())
        
        
        
        
//        .background(BGView()
//        Color.homePageBackground.offset(y: 500)
        
//        TabView {
//                .tabItem {
//                    Image(systemName: "house")
//                        .resizable()
//                    Text("Home")
//                }
////            TeamsView()
////                .tabItem {
////                    Image(systemName: "gear")
////                        .resizable()
////                    Text("Settings")
////                }
//        }
//        tabViewStyle(backgroundColor: .blue.opacity(0.3))
//        .accentColor(Color("A12568"))
        
//}
    
