//
//  ListingDetailView.swift
//  ChatGPTDemoApp
//
//  Created by Thuan Nguyen on 1/31/24.
//

import SwiftUI
import CachedAsyncImage

struct ListingDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isExpanded: Bool = false
    @State private var isChatShown: Bool = false
    
    let listing: ListingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ZStack(alignment:Alignment(horizontal: .leading, vertical: .top)) {
                    CachedAsyncImage(url: listing.images?.first) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(.systemGray6))
                            .padding(EdgeInsets(top: 60.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                    }
                }
                
                VStack(alignment: .leading, spacing: 16.0)  {
                    Text(listing.title)
                        .font(.system(.title2))
                        .bold()
                    
                    VStack(alignment: .leading) {
                        Text("Entire home in \(listing.location)")
                            .font(.title3)
                            .bold()
                        Text(listing.capacity)
                    }
                    
                    // Rating, Guest Favorite, Reviews Block
                    HStack(alignment: .top) {
                        VStack {
                            Text(listing.rating)
                            Text(ratingToStarsText(listing.rating))
                                .font(.system(.caption))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        Divider().frame(maxHeight: 44.0)
                        HStack {
                            Text("🏆")
                            VStack {
                                Text("Guest Favorite")
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        Divider().frame(maxHeight: 44.0)
                        VStack {
                            Text("100\nReviews")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color(.init(red: 0, green: 0, blue: 0, alpha: 0.15)), lineWidth: 1)
                    )
                    
                    Button(
                        action: {
                            isChatShown = true
                        },
                        label: {
                            Image(systemName: "message")
                            Text("Ask a Question")
                                .font(.headline)
                        })
                    .sheet(isPresented: $isChatShown) {
                        let chatThreadModel =
                        ChatThreadModel(
                            chatgptThreadId: ChatThreadDataManager.shared.cachedChatGPTThreadId(listingId: listing.id),
                            title: listing.title,
                            snippet: "",
                            status: nil,
                            isRead: false,
                            listing: listing)
                        NavigationView {
                            ThreadView(chatThread: chatThreadModel)
                        }
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                Divider()
                VStack(alignment: .leading) {
                    Text(listing.description)
                        .lineLimit(isExpanded ? nil : 10)
                    Button {
                        isExpanded.toggle()
                    } label: {
                        Text(isExpanded ? "Show Less" : "Show More")
                            .font(.caption).bold()
                            .padding(.top, 4.0)
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.horizontal)

            }
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.top)
    }
    
    private func ratingToStarsText(_ rating: String) -> String {
        let ratingFloat = Float(rating)!.rounded()
        
        var ratingStarsString = ""
        
        var i: Float = 0
        while i < ratingFloat {
            ratingStarsString.append("★")
            i += 1
        }
        
        return ratingStarsString
    }
    
    private func showChatView() {
        
    }
}

struct ListingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresenting: Bool = false
        
        NavigationView {
            ListingDetailView(
                listing:MockDataHelper.mockListing)
        }
    }
}

