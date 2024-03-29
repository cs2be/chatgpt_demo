//
//  ChatThreadModel.swift
//  ChatGPTDemoApp
//
//  Created by Thuan Nguyen on 1/17/24.
//

import Foundation

struct ChatThreadModel: Identifiable, Hashable {
    let id: String
    let chatgptThreadId: String?
    let title: String
    let snippet: String
    let status: String?
    let isRead: Bool
    let listing: ListingModel?
    
    init(id: String = UUID().uuidString, chatgptThreadId: String?, title: String, snippet: String, status: String?, isRead: Bool, listing: ListingModel?) {
        self.id = id
        self.chatgptThreadId = chatgptThreadId
        self.title = title
        self.snippet = snippet
        self.status = status
        self.isRead = isRead
        self.listing = listing
    }
    
    func updateChatGPTThreadId(_ chatgptThreadId: String) -> ChatThreadModel {
        ChatThreadModel(chatgptThreadId: chatgptThreadId,
                        title: self.title,
                        snippet: self.snippet,
                        status: self.status,
                        isRead: self.isRead,
                        listing: self.listing)
    }
}
