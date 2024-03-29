//
//  ListingListView.swift
//  ChatGPTDemoApp
//
//  Created by Thuan Nguyen on 1/31/24.
//

import SwiftUI

struct ListingListView: View {
    @EnvironmentObject var listingViewModel: ListingViewModel
    
    @State var textFieldString: String = ""
    @State private var currentListing: ListingModel?
    @State private var isOptionSheetShown = false

    var body: some View {
        let listings = listingViewModel.listings
        
        VStack {
            HStack {
                Button(action: searchButtonAction, label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Spacer()
                            .frame(width: 8.0)
                        VStack(alignment: .leading) {
                            Text("Where to?")
                                .font(.system(.headline, design: .rounded))
                            Text("Anywhere • Any week • Add guest")
                                .font(.system(.caption, design: .rounded))
                        }
                        Spacer()
                    }
                    .modifier(RoundedCornersViewModifier(roundedCorners: 30.0, textColor: Color.black))
                })
                Button(action: {
                    isOptionSheetShown = true
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .modifier(RoundedCornersViewModifier(roundedCorners: 40.0, textColor: Color.black, shadowRadius: 1.0))
                })
                .sheet(isPresented: $isOptionSheetShown, content: {
                    OptionsView()
                })
            }
            .padding(.horizontal)
            
            List(listings) { listing in
                ListingView(listing: listing)
                    .listRowSeparator(.hidden)
                    .padding(EdgeInsets(top: 0, leading: 12.0, bottom: 0, trailing: 12.0))
                    .onTapGesture {
                        currentListing = listing
                    }

            }
            .fullScreenCover(item: $currentListing) {listing in
                ListingDetailView(listing:listing)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    func searchButtonAction() {
        
    }
}

struct ListingListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListingListView()
                .environmentObject(ListingViewModel(ListingDataManager.shared))
        }
    }
}

