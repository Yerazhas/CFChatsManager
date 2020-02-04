//
//  BaseMessagesViewController.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/4/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class BaseMessagesViewController<Message: CFMessage>: UIViewController {
    private var messages = [Message]()
    private var currentPage: Int = 1
    private var limit: Int = 10
    private let messagesSocket: MessagesSocket
    private let parser: CFParser
    
    init(messagesSocket: MessagesSocket, parser: CFParser) {
        self.messagesSocket = messagesSocket
        self.parser = parser
        super.init(nibName: nil, bundle: nil)
        self.messagesSocket.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnect), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connect), name: UIApplication.willEnterForegroundNotification, object: nil)
        connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        disconnect()
    }
    
    @objc private func connect() {
        messagesSocket.connect()
    }
    
    @objc private func disconnect() {
        messagesSocket.disconnect()
    }
    
    private func getMessages() {
        //some http call to get messages history
    }
}

extension BaseMessagesViewController: CFSocketClientDelegate {
    func didReceiveMessage(message: String) {
        guard let data = message.data(using: .utf8) else { return }
        handleMessageData(data: data)
    }
    
    func didReceiveError(error: Error) {
        print(error.localizedDescription)
    }
    
    func didReceiveData(data: Data) {
        handleMessageData(data: data)
    }
    
    private func handleMessageData(data: Data) {
        let result: Result<Message, Error> = parser.parse(response: data)
        switch result {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let message):
            messages.append(message)
        }
    }
}
