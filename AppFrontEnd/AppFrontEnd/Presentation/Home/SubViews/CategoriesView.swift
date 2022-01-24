//
//  CategoriesView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/20/21.
//

import SwiftUI



struct CategoriesView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
         
    var body: some View {
        
        // Horizontal Scroll View
        ScrollView(.horizontal, showsIndicators: false) {
            
            // Horizontal Stack
            HStack(alignment: . top, spacing: 8) {
                
                // / Loop 15 Unique Objects
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(
                        destination: HomeViewRouter.destinationForTappedCategory(category),
                        label: {
                            // // Objects each have Verically Stacked Spacers & Text
                            VStack(spacing: 8) {
                                Image(systemName: category.imageName)
                                    .foregroundColor(Color("A12568"))
                                    .font(.system(size: 17))
                                    .frame(width: 50, height: 50)
                                    .background(.white)
                                //  .background(Color.init(hex: "324e8d"))
                                    .cornerRadius(.infinity)
                                Text(category.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 9, weight: .semibold))
                                    .multilineTextAlignment(.center)
                            }.frame(width: 55)
                    })
                }
            }
            .padding(.horizontal)
            .padding(.top, 6)
        }
    }
}

class CategoryDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var places = [Int]()
    
    init() {
        // network code will happen here
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
            self.places = [1, 2, 3, 4, 5, 6, 7]
        }
    }
}


struct CategoryDetailsView: View {
    
    @ObservedObject var vm = CategoryDetailsViewModel()
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading..")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(8)
                
            } else {
                ScrollView {
                    ForEach(vm.places, id: \.self) { num in
                        VStack(alignment: .leading, spacing: 0) {
                            Image("Art/art1")
                                .resizable()
                                .scaledToFill()
                            Text("Paint Class")
                                .font(.system(size: 12, weight: .semibold))
                                .padding()
                        }
                        .asTile()
                        .padding()
                        
                    }
                }
            }
        }
        .navigationBarTitle("Category", displayMode: .inline)
    }
}

// Loading Indicator derived from UIKit Activity Indicator.
struct ActivityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}


struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView()
        }
        HomeView()
//        CategoriesView()
    }
}
