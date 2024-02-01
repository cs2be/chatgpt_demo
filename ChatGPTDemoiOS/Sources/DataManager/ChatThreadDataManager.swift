//
//  ChatThreadDataManager.swift
//  ChatGPTDemoApp
//
//  Created by Thuan Nguyen on 1/23/24.
//

import Foundation
import Combine

class ChatThreadDataManager: NSObject, ObservableObject {
    static let shared = ChatThreadDataManager(chatGPTDataManager: ChatGPTDataManager.shared)
    
    var chatGPTDataManager: ChatGPTDataManager
//    @Published private(set) var messages: [ChatMessageModel] = []
    
    init(chatGPTDataManager: ChatGPTDataManager) {
        self.chatGPTDataManager = chatGPTDataManager
    }
    
    func loadMessages(_ chatThread: ChatThreadModel) -> Future<[ChatMessageModel], Error> {
        return Future { promixe in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promixe(.success(PreviewHelper.messages))
            }
        }
    }
}
