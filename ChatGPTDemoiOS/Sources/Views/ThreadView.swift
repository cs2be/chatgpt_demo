//
//  ThreadView.swift
//  ChatGPTDemoApp
//
//  Created by Thuan Nguyen on 1/16/24.
//

import SwiftUI
import OSLog
import Combine

struct ThreadView: View {
    @ObservedObject private var chatThreadViewModel: ChatThreadViewModel
    
    var chatThread: ChatThreadModel
    @State private var loadThreadObserver: AnyCancellable? = nil
    
    @State var textFieldText: String = ""
    @State var isTextFieldFocused: Bool = false
    
    init(chatThread: ChatThreadModel) {
        self.chatThread = chatThread
        self.chatThreadViewModel = ChatThreadViewModel(chatThread: chatThread)
    }
    
    var body: some View {
        VStack {
            Divider()
            if !isTextFieldFocused {
                ThreadViewBanner(listing: chatThread.listing!)
                    .padding(.vertical)
                Divider()
            }
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(chatThreadViewModel.messages, id: \.id) { message in
                        MessageCellView(messageModel: message)
                    }
                    .onChange(of: chatThreadViewModel.messages) { _ in
                        if let lastMessage = _lastMessage() {
                            withAnimation(.spring()) {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                .frame(alignment: .leading)
                
                GrowingTextField(
                    onSend: { message in
                        chatThreadViewModel.sendMessage(chatThread: chatThread, sender: MockDataHelper.selfContact, message: message)
                    },
                    onFocusChanged: { isFocused in
                        isTextFieldFocused = isFocused
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if isFocused,
                               let lastMessage = _lastMessage() {

                                withAnimation(.spring()) {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                );
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("AirGPT")
        .task {
            loadThreadObserver = chatThreadViewModel.loadThread()?
                .sink { completion in
                    switch completion {
                    case .finished:
                        Logger.system.infoAndCache("Successfully Loaded Thread")
                    case .failure(let error):
                        Logger.system.errorAndCache("Error loading thread: \(error)")
                    }
                } receiveValue: { output in
                    
                }
        }
    }
    
    private func _lastMessage() -> ChatMessageModel? {
        guard chatThreadViewModel.messages.count != 0 else {
            return nil
        }
        
        return chatThreadViewModel.messages[chatThreadViewModel.messages.count - 1]
    }
}

struct ThreadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThreadView(
                chatThread:MockDataHelper.mockChatThreadModel)
        }
    }
}
