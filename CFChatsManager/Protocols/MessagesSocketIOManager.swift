//
//  MessagesSocketIOManager.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/4/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import SocketIO

class MessagesSocketIOManager: MessagesSocket {
    weak var delegate: CFSocketClientDelegate?
    let manager: SocketManager
    
    var socket: SocketIOClient
    
    init(urlString: String) {
        self.manager = SocketManager(socketURL: URL(string: urlString)!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { (_, _) in
            self.observeMessages()
        }
    }
    
    func connect() {
        print("connect")
    }
    
    func disconnect() {
        print("disconnect")
    }
    
    func sendMessage(message: String) {
        guard let data = message.data(using: .utf8) else { return }
        socket.emit("send", data)
    }
    
    func sendMessage(data: Data) {
        socket.emit("send", data)
    }
    
    func observeMessages() {
        socket.on("messages") { (data, ack) in
            if let dict = data[0] as? [String: Any] {
                if let resultDict = dict["result"] as? [[String: Any]] {
                    if JSONSerialization.isValidJSONObject(resultDict) {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: resultDict, options: [])
                            self.delegate?.didReceiveData(data: data)
                        } catch {
                            self.delegate?.didReceiveError(error: error)
                        }
                    }
                } else if let resultStr = dict["result"] as? String {
                    self.delegate?.didReceiveMessage(message: resultStr)
                }
            } else {
                let error = MessageError.noData
                self.delegate?.didReceiveError(error: error)
            }
        }
    }
}

enum MessageError: Error {
    case noData
    
    var localizedDescription: String {
        return "noData received from socket"
    }
}
