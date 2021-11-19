//
//  HomeView.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct HomeView: View {
    
    //child view can have access to an observed object with @Environmentobject property wrapper
    @EnvironmentObject var viewModel : HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                //Category
                Group {
                    Text("Categories")
                        .bold()
                        .padding(.leading, .large)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(FoodCategory.allCases, id: \.self) { category in
                                CategoryView(selectedCategory: $viewModel.selectedCategory, category: category)
                            }
                        }.padding()
                    }
                }
                
                //List
                List (viewModel.restaurants, id: \.id?.oid) { restaurant in
                    if #available(iOS 15.0, *) {
                        RestaurantCell(restaurant: restaurant)
                            .listRowSeparator(.hidden)
                    }
               }
                .listStyle(.plain)
                .navigationTitle(Text(viewModel.cityName))
                .searchable(text: $viewModel.searchText)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                          Image(systemName: "person")
                    }
                }
                
            }.sheet(isPresented: $viewModel.showModal,
                    onDismiss: nil) {
                PermissionView() {
                    viewModel.requestPermission()
                }
            }
            .onChange(of: viewModel.showModal) { newValue in
                viewModel.request()
            }
        }
    }
}

@available(iOS 15.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}

