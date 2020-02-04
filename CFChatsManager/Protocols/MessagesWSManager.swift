//
//  MessagesWSManager.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/4/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import Starscream

class MessagesWSManager: MessagesSocket {
    weak var delegate: CFSocketClientDelegate?
    private let socket: WebSocket
    
    init(socket: WebSocket) {
        self.socket = socket
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func sendMessage(message: String) {
        socket.write(string: message)
    }
    
    func sendMessage(data: Data) {
        socket.write(data: data)
    }
}

extension MessagesWSManager: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket did connect successfully")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket did disconnect successfully")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        delegate?.didReceiveMessage(message: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        delegate?.didReceiveData(data: data)
    }
}
